From: Agostino Sarubbo <ago@gentoo.org>
Subject: An option to sign the push by default
Date: Sun, 09 Aug 2015 18:57:16 +0200
Message-ID: <2404018.OElJjohJ7Q@arcadia>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 18:57:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOTuZ-0005r8-LU
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 18:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933101AbbHIQ5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 12:57:23 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:37170 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933071AbbHIQ5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 12:57:22 -0400
Received: from arcadia (ns207970.ip-94-23-217.eu [94.23.217.136])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ago)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9F09F3406AA
	for <git@vger.kernel.org>; Sun,  9 Aug 2015 16:57:21 +0000 (UTC)
User-Agent: KMail/4.14.8 (Linux/3.18.16-gentoo; KDE/4.14.8; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275551>

Hello folks,

during the configuration of git, client side, to sign all commit I used:

git config --global commit.gpgsign "1"


Since at push time I use:

git push --signed

I'm wondering if there is a git config option which put something in the 
config file and avoid to type --signed.

If there isn't this feature, I'd like to know if it is a reasonable feature 
request.

Thanks in advance.


-- 
Agostino Sarubbo
Gentoo Linux Developer
