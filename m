From: Frans Pop <elendil@planet.nl>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sat, 3 Apr 2010 00:12:24 +0200
Message-ID: <201004030012.25092.elendil@planet.nl>
References: <201004030005.35737.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 00:12:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxp6N-0007EE-Km
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 00:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab0DBWM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 18:12:27 -0400
Received: from cpsmtpm-eml101.kpnxchange.com ([195.121.3.5]:61807 "EHLO
	CPSMTPM-EML101.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755238Ab0DBWM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 18:12:26 -0400
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML101.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Sat, 3 Apr 2010 00:12:25 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <201004030005.35737.elendil@planet.nl>
Content-Disposition: inline
X-OriginalArrivalTime: 02 Apr 2010 22:12:26.0042 (UTC) FILETIME=[939329A0:01CAD2B1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143857>

The environment is the same as for the reflog problem, but I should have 
added that info anyway. Here it is again.

On Saturday 03 April 2010, Frans Pop wrote:
> I have a git-svn checkout of a subversion repo which I wanted to
> compress as much as possible. 'git gc --aggressive' starts to run fairly
> well, but eats more and more memory and gets slower and slower. After it
> gets to about 45% or 50% progress slows down noticeably and so far I
> haven't had the patience to let it finish (40 minutes is already way too
> long).

I'm seeing this with both git 1.6.6.1 and 1.7.0.3 on the same repo.
Environment:
- Debian amd64/Lenny; Core Duo x86_64 2.6.34-rc3 -> 1.6.6.1
- Debian i386/Sid; chroot on the same machine -> 1.7.0.3
