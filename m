From: Andreas Ericsson <ae@op5.se>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can
 it be done in Git?
Date: Tue, 11 Mar 2008 11:20:41 +0100
Message-ID: <47D65CF9.60607@op5.se>
References: <200803091459.21354.jnareb@gmail.com> <200803101938.09300.jnareb@gmail.com> <47D6541F.8000503@op5.se> <7vtzjdbngf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	mercurial@selenic.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 11:22:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ1cR-0004sf-Lh
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 11:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060AbYCKKUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 06:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756316AbYCKKUq
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 06:20:46 -0400
Received: from mail.op5.se ([193.201.96.20]:52589 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbYCKKUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 06:20:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 339C91F080C2;
	Tue, 11 Mar 2008 11:21:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vc-PPY-G6toh; Tue, 11 Mar 2008 11:21:36 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 44B061F080BE;
	Tue, 11 Mar 2008 11:21:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <7vtzjdbngf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76830>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Jakub Narebski wrote:
>>> Mercurial extension | git equivalent (or proposal)
>>> --------------------+------------------------------------
>>> bisect              | git-bisect
>>>
>>> Footnotes:
>>> ==========
>>> (*) Directly inspired by git feature
>>> (!) No direct equivalent, would be quite a work to add
>>> (!!!) No equivalent, don't know if possible
>>>
>> IIRC, bisect should have a star here (or five, as it's a killer feature).
> 
> Heh, why do we even care?  It is a norm that good features cross pollinate
> across systems and who borrows ideas from whom does not really matter
> much.

Because companies such as the one where I work pride themselves in using
the most innovative tools. Clearly, git is the most innovative tool here,
since its developers managed to cook up something so immensely useful as
"git bisect" (which by the way is well-nigh single-handedly responsible
for reducing our average bugreport-to-fix time from 4 days to 6 hours).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
