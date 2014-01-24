From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH v2 0/9] add --gpg-sign to rebase and pull
Date: Fri, 24 Jan 2014 10:14:44 +0100
Message-ID: <20140124091444.GM10748@mars-attacks.org>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 10:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6czy-0008Tc-0n
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 10:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbaAXJYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 04:24:20 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:43100 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbaAXJYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 04:24:17 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2014 04:24:17 EST
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id E44C54E64;
	Fri, 24 Jan 2014 10:15:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TWWs7UwihPbU; Fri, 24 Jan 2014 10:15:13 +0100 (CET)
Received: from wxy.mars-attacks.org (unknown [92.59.127.38])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 3A00F3EE6;
	Fri, 24 Jan 2014 10:15:12 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 14FFA4394D; Fri, 24 Jan 2014 10:14:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240998>

On Fri, 24 Jan 2014, brian m. carlson wrote:

> This series was posted to the list some time back, but it fell through
> the cracks.  This is a re-send of Nicolas Vigier's work with an
> additional patch that adds --gpg-sign to pull as well.  I added my
> sign-off to his patches because SubmittingPatches (section (c)) seems to
> imply that I should, although I can rebase it out if it's a problem.

Thanks!

An improvement I was thinking to do on this series but had not time to
do yet is to make the '--no-gpg-sign' option disable gpg signing when
the commit.gpgsign config option is set to true.

This would fix the problem mentioned about commit.gpgsign in "What's
cooking in git.git" that the variable cannot be overriden from the
command line of some of the commands that create commits.

Nicolas
