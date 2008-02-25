From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [Q] Tell Git to follow symlinks?
Date: Mon, 25 Feb 2008 11:06:28 +0100
Message-ID: <vpqtzjxbba3.fsf@bauges.imag.fr>
References: <c6c947f60802240305w40a7af96yc47f90e573384c04@mail.gmail.com>
	<m3k5ktbep1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alexander Gladysh" <agladysh@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 11:09:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTaGp-0008Qh-B0
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 11:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbYBYKIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 05:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbYBYKIh
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 05:08:37 -0500
Received: from imag.imag.fr ([129.88.30.1]:36109 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbYBYKIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 05:08:36 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m1PA6hXQ005965
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2008 11:06:44 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JTaE8-0002gF-E8; Mon, 25 Feb 2008 11:06:28 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JTaE8-0003dD-Bt; Mon, 25 Feb 2008 11:06:28 +0100
In-Reply-To: <m3k5ktbep1.fsf@localhost.localdomain> (Jakub Narebski's message of "Mon\, 25 Feb 2008 00\:52\:48 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 25 Feb 2008 11:06:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75021>

Jakub Narebski <jnareb@gmail.com> writes:

> "Alexander Gladysh" <agladysh@gmail.com> writes:
>
>> I thought to construct my repo of the number of symlinks to other
>> places, but apparently Git does not follow any symlinks.
>
> Git stores symlinks as symlinks. Changing that (adding for example
> core.followSymlinks) would require quite a bit of surgery.

In particular, this would raise the question of what to do when
writting to a symlink. Following symlinks when doing a checkout or a
merge could mean to allow git to write outside its working tree, which
is problematic security-wise.

-- 
Matthieu
