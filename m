From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git automatic stashing?
Date: Tue, 09 Nov 2010 20:12:56 +0100
Message-ID: <vpqd3qe8g5j.fsf@bauges.imag.fr>
References: <AANLkTim3MacQK6EtTPNJsYbqb=5bOM3W3BXC6p=hT+PU@mail.gmail.com>
	<AANLkTinwftXiZxbs_=PeM-MxQmMF4VaBCPEufH=OG6iU@mail.gmail.com>
	<AANLkTi=G=Xo90QayvuRDp=GTWtkES2fU0kkmn87Q09_2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Casey McGinty <casey.mcginty@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 20:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFtfh-0006EH-CT
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 20:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab0KITPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 14:15:52 -0500
Received: from imag.imag.fr ([129.88.30.1]:32945 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab0KITPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 14:15:52 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id oA9JCukq004159
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 9 Nov 2010 20:12:56 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PFtcm-0002eY-CK; Tue, 09 Nov 2010 20:12:56 +0100
In-Reply-To: <AANLkTi=G=Xo90QayvuRDp=GTWtkES2fU0kkmn87Q09_2@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Tue\, 9 Nov 2010 19\:36\:02 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 09 Nov 2010 20:12:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161064>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Nov 9, 2010 at 12:37 PM, Casey McGinty <casey.mcginty@gmail.com> wrote:
>> Is there any feature in git to perform and auto stash apply/pop when
>> trying to do a merge/rebase in a dirty working dir? This would save
>> some keystrokes from time-to-time, and make it easier for new users
>> unfamiliar with git.
>
> And when switching branches too.

Isn't that what "git checkout -m" does?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
