From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Commit/merge messages for binary files
Date: Fri, 18 Feb 2011 14:53:12 +0100
Message-ID: <vpq39nlsb3r.fsf@bauges.imag.fr>
References: <AANLkTikXMi92iUd-1bEfs5WfawyHp4G7=Ynd+eaq_wsR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 14:53:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqQm2-00013V-CW
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 14:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab1BRNxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 08:53:16 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36980 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab1BRNxP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 08:53:15 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p1IDrB4I021120
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Feb 2011 14:53:11 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PqQlk-00042I-Ki; Fri, 18 Feb 2011 14:53:12 +0100
In-Reply-To: <AANLkTikXMi92iUd-1bEfs5WfawyHp4G7=Ynd+eaq_wsR@mail.gmail.com> (Piotr Krukowiecki's message of "Thu\, 17 Feb 2011 21\:40\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Feb 2011 14:53:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1IDrB4I021120
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1298641991.53193@e660JHktJDfaJJZNXfd3Nw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167208>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Hi,
>
> there's a different output when committing change and when merging
> change for a binary file.
> Do the insertions/deletions have any meaning for binary files?

No. They're inserted/deleted *lines*, and that wouldn't make sense for
binary files.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
