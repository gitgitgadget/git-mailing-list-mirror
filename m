From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Is the textconv filter called for each line ? or once for the file ?
Date: Wed, 20 Jun 2012 14:17:54 +0200
Message-ID: <vpqy5nidvnx.fsf@bauges.imag.fr>
References: <loom.20120620T125636-763@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Laurent Alebarde <l.alebarde@free.fr>
X-From: git-owner@vger.kernel.org Wed Jun 20 14:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShJrO-0001e8-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 14:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab2FTMSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 08:18:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53463 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab2FTMSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 08:18:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5KCHYKx004164
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2012 14:17:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ShJr9-0007OY-KG; Wed, 20 Jun 2012 14:17:55 +0200
In-Reply-To: <loom.20120620T125636-763@post.gmane.org> (Laurent Alebarde's
	message of "Wed, 20 Jun 2012 10:57:33 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 20 Jun 2012 14:17:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5KCHYKx004164
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340799456.76144@7xyt97oyUpphicHFGJLU/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200294>

Laurent Alebarde <l.alebarde@free.fr> writes:

> Hi all,
>
> Something I need clarification please :
>
> In the documentation on gitattributes, it is said :
>
> "A textconv, by comparison, is much more limiting. You provide a transformation
> of the data into a line-oriented text format, and git uses its regular diff 
> tools to generate the output."
>
> Does it mean that the textconv filter is called for each line ?

No. What would "for each line" mean, since textconv is essentially meant
to be called on binary files?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
