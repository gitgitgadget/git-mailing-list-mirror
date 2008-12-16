From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Undo a git stash clear
Date: Tue, 16 Dec 2008 13:20:39 +0100
Message-ID: <vpq1vw81fc8.fsf@bauges.imag.fr>
References: <c6c947f60812160407l1b2593e1pde817f5cfb091d59@mail.gmail.com>
	<57518fd10812160412j1edc2ea0mff732825f1f6c4a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alexander Gladysh" <agladysh@gmail.com>, git@vger.kernel.org,
	git-users@googlegroups.com
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 13:25:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCYzm-0002ad-Jl
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 13:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbYLPMY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 07:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755187AbYLPMY3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 07:24:29 -0500
Received: from imag.imag.fr ([129.88.30.1]:54170 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756084AbYLPMY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 07:24:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mBGCKesT016610
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Dec 2008 13:20:41 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LCYul-0003GL-QJ; Tue, 16 Dec 2008 13:20:39 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LCYul-0004Bs-O0; Tue, 16 Dec 2008 13:20:39 +0100
In-Reply-To: <57518fd10812160412j1edc2ea0mff732825f1f6c4a2@mail.gmail.com> (Jonathan del Strother's message of "Tue\, 16 Dec 2008 12\:12\:52 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 16 Dec 2008 13:20:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103277>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> On Tue, Dec 16, 2008 at 12:07 PM, Alexander Gladysh <agladysh@gmail.com> wrote:
>> Hi, list!
>>
>> I've stashed some valuable changes and then I accidentally did git
>> stash clear. (Yes, today is not my day).
>>
>> Is it possible to restore stashed changes?
>
> I ran into this exact problem on Friday.  Some helpful person on IRC
> suggested using

(and the obvious advice before anything else : don't "git gc", don't
"git prune", and if possible back-up the repository before anything
else)

-- 
Matthieu
