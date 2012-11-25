From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] emacs: make 'git-status' work with separate git dirs
Date: Sun, 25 Nov 2012 10:06:25 +0100
Message-ID: <87ehjit5ke.fsf@wine.dyndns.org>
References: <1353599934-23222-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
	<7v4nkeyzfb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 10:23:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcYRM-0007yQ-TN
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 10:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab2KYJXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 04:23:38 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:36829 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab2KYJXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 04:23:35 -0500
X-Greylist: delayed 1020 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Nov 2012 04:23:35 EST
Received: from adsl-84-227-211-246.adslplus.ch ([84.227.211.246] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <julliard@wine.dyndns.org>)
	id 1TcYAW-00060W-HD; Sun, 25 Nov 2012 03:06:30 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 487381E71B1; Sun, 25 Nov 2012 10:06:25 +0100 (CET)
In-Reply-To: <7v4nkeyzfb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 24 Nov 2012 22:22:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210341>

Junio C Hamano <gitster@pobox.com> writes:

> Enrico Scholz <enrico.scholz@sigma-chemnitz.de> writes:
>
>> when trying 'M-x git-status' in a submodule created with recent (1.7.5+)
>> git, the command fails with
>>
>> | ... is not a git working tree
>>
>> This is caused by creating submodules with '--separate-git-dir' but
>> still checking for a working tree by testing for a '.git' directory.
>>
>> The patch fixes this by relaxing the existing detection a little bit.
>>
>> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>> ---
>
> This script already relies on the assumption that nobody sane would
> create a directory named ".git" that is not a git repository, and
> this loosens the assumption that nobody would create a file named
> ".git", either.  So I would think it is a sane thing to do, but just
> in case if the area expert has better ideas, I am forwarding it.
>
> Ack?

Sure, that's fine.

-- 
Alexandre Julliard
julliard@winehq.org
