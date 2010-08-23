From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Mon, 23 Aug 2010 10:33:21 +0200
Message-ID: <vpqaaod7mpa.fsf@bauges.imag.fr>
References: <4C6A1C5B.4030304@workspacewhiz.com>
	<7viq39avay.fsf@alter.siamese.dyndns.org>
	<20100818233900.GA27531@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 23 10:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnSTc-0000nu-L0
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 10:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab0HWIdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 04:33:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33144 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704Ab0HWIdp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 04:33:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7N8LsSb002178
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Aug 2010 10:21:54 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OnST4-0004Gn-4i; Mon, 23 Aug 2010 10:33:22 +0200
In-Reply-To: <20100818233900.GA27531@localhost> (Clemens Buchacher's message of "Thu\, 19 Aug 2010 01\:39\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 23 Aug 2010 10:21:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7N8LsSb002178
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283156516.48725@aSED2yZw9ABlirouvBqbSA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154206>

Clemens Buchacher <drizzd@aon.at> writes:

> By default, checkout and fast-forward merge will overwrite ignored
> files. Make this behavior configurable.

I'd use this option if it gets into git.git.

I didn't follow the discussions when the feature was added, and I was
basically not aware that Git could trash my ignored files this way.
I've always thought that Git took great care not to touch untracked
files, and I found this good ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
