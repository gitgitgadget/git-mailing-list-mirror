From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 08 Apr 2008 18:47:19 -0400
Message-ID: <47FBF5F7.1060105@et.gatech.edu>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>	 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>	 <47FBDA77.2050402@et.gatech.edu> <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 00:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjMbo-0000aq-HM
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 00:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbYDHWrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 18:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbYDHWrZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 18:47:25 -0400
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:47959 "EHLO
	QMTA10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752345AbYDHWrY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2008 18:47:24 -0400
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA10.emeryville.ca.mail.comcast.net with comcast
	id B3rN1Z0030EPchoAA0TD00; Tue, 08 Apr 2008 22:46:50 +0000
Received: from [192.168.1.98] ([66.56.40.49])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id BAmx1Z00B13e8jm8M00000; Tue, 08 Apr 2008 22:47:00 +0000
X-Authority-Analysis: v=1.0 c=1 a=mLU-mYli3v0A:10 a=vmUirt_5B3MA:10
 a=I1CAwwv7f9KOW3yf-v0A:9 a=7mY3Kt_H2TsHcHwlK9sA:7
 a=qhJFu17zh0tgj_10gvWxCq8Fw6YA:4 a=mFGnfPYPwAgA:10
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
In-Reply-To: <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79042>

Avery Pennarun wrote:
> Anyway, in this case, what you need to know is that .git/config
> already contains your submodule information.  Sadly, .gitmodules is
> probably sitting somewhere on your original branch, so it probably
> doesn't exist.  You could remove the entry from .git/config by hand
> and use git-submodule-add again (thus putting it in both places), or
> copy the .gitmodules file from the original branch, or git-cherry-pick
> the commit where you added it.
> 
> You should *also* cd into the access subdir and checkout the right
> revision there; at that time, the next commit to the sakai repository
> will make sure the submodule reference is to the right place.
> 
> Phew, I hope that made things more clear instead of less clear. :)
> 
> Have fun,
> 
> Avery

OK, this makes a lot more sense now.  Thanks.

-- 
Stuart
