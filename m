From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: First time gitr - have some questions
Date: Mon, 24 Jan 2011 14:28:11 -0500
Message-ID: <71753C67-F692-4CA6-A8BB-39B606D0CC76@kellerfarm.com>
References: <1295893245907-5956101.post@n2.nabble.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: toltmanns <toltmanns@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 21:40:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhTDK-00032T-U9
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 21:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab1AXUkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 15:40:33 -0500
Received: from sanjose.tchmachines.com ([208.76.86.38]:38089 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1AXUkc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jan 2011 15:40:32 -0500
X-Greylist: delayed 4337 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jan 2011 15:40:32 EST
Received: from public-67-55.emich.edu ([164.76.67.55])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1PhS5B-0007xc-2l; Mon, 24 Jan 2011 14:28:09 -0500
In-Reply-To: <1295893245907-5956101.post@n2.nabble.com>
X-Mailer: Apple Mail (2.1082)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165457>

On Jan 24, 2011, at 1:20 PM, toltmanns wrote:

> First off, I may be in the wrong place, but I need a sanity check here.

Communication is the most efficient way to implement a sanity check.

> I've downloaded and am attempting to use the git bash app, trying to issue
> the following command and am getting fatal: Not a git repository
> 
> git submodule add git@github.com:toltmanns/steal.git public/steal

I like that error because of how few scenarios can cause it.  Your current working directory is not inside a repository.  'cd' into the repository and try again.

~ Andrew Keller
