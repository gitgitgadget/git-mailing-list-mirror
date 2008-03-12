From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [Q] assume unchanged?
Date: Thu, 13 Mar 2008 06:53:07 +0900
Message-ID: <20080227222243.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 22:54:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYu4-0007Xv-CT
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbYCLVxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbYCLVxj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:53:39 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:47721 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYCLVxj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:53:39 -0400
Received: from fe1.bluebottle.com (internal.bluebottle.com [206.188.24.43])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m2CLrcJK003608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 12 Mar 2008 14:53:38 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:date:subject:message-id:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=g9fE+6KtWpjVKnMSB930/fhSpQ96lYtvvGHT2xC78LT3WskVn1patooE6HVp//vsz
	76X5gkgVbg495ugOyVwmYBIUsWVlflfT6pzUkRmQhoQPtrMOZg7unq84GNIGJNb
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m2CLrTeY008857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 12 Mar 2008 14:53:36 -0700
X-Trusted-Delivery: <d0d96063a2423081160bae2336763b06>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77009>

I was looking at the documentation of git-update-index because I thought git-add is the preferred way to do what the command was used for in the old versions of git, and wanted to see if the old command has more features that are missing from git-add.

I noticed that there is --assume-unchanged option, and I read its description three times, but I do not understand it.  What is it good for?  Version control systems are used in order to keep track changes, and if using that option makes my changes ignored, how can it be a good thing?

The manual says "This is sometimes helpful when working with a big project on a filesystem that has very slow lstat(2) system call", but unfortunately it does not answer my question.

Could somebody explain, please?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com/tag/3
