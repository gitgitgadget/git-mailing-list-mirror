From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Git Feature Request - show current branch
Date: Thu, 19 Feb 2015 08:32:03 -0500
Message-ID: <001801d04c48$732f9980$598ecc80$@nexbridge.com>
References: <13b.3lxh{.41MsIT3sthY.1KvU6v@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: <mdconf@seznam.cz>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 14:32:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YORDJ-0007Vo-Co
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 14:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbbBSNcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 08:32:17 -0500
Received: from elephants.elehost.com ([216.66.27.132]:51193 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbbBSNcQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 08:32:16 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t1JDW5B1004468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Feb 2015 08:32:06 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <13b.3lxh{.41MsIT3sthY.1KvU6v@seznam.cz>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQI9x45zhK7x7xw78XPJW+dxgCS+VZwdAZuw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264098>

Hi Martin,

I use:

git symbolic-ref --short HEAD

in scripts. Not sure it's the best way, but it works 100% for me.

Regards,
Randall

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of mdconf@seznam.cz
Sent: February 19, 2015 8:15 AM
To: git@vger.kernel.org
Subject: Git Feature Request - show current branch

Hello,

To start with, I did not find an official way to submit feature request so hopefully this is the right way to do so - if not then my apologize & appreciate if somebody could re-submit to the proper place.

I'd like to request adding a parameter to 'git branch' that would only show the current branch (w/o the star) - i.e. the outcome should only be the name of the branch that is normally marked with the star when I do 'git branch' command. This may be very helpful in some external scripts that just simply need to know the name of the current branch. I know there are multiple ways to do this today (some described here: http://stackoverflow.com/questions/6245570/how-to-get-current-branch-name-in-git) but I really think that adding simple argument to 'git branch' would be very useful instead of forcing people to use 'workarounds'.

My suggestion is is to name the parameter '--current' or '--show-current'.
Example:

Command: git branch
Outcome:
 branchA
 branchB
* master

Command: git branch --current
Outcome:
master

Thank you,
Martin
--
To unsubscribe from this list: send the line "unsubscribe git" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
