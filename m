From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Make core.sharedRepository more generic
Date: Sat, 12 Apr 2008 22:50:46 +0300
Message-ID: <20080412195046.GH31039@zakalwe.fi>
References: <20080412185105.GA14331@zakalwe.fi> <2008-04-12-21-15-04+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Sat Apr 12 21:51:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkll8-00053h-2i
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 21:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbYDLTur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 15:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756218AbYDLTur
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 15:50:47 -0400
Received: from zakalwe.fi ([80.83.5.154]:43903 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762AbYDLTur (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 15:50:47 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 3E9952C333; Sat, 12 Apr 2008 22:50:46 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <2008-04-12-21-15-04+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79380>

On Sat, Apr 12, 2008 at 09:15:03PM +0200, Samuel Tardieu wrote:
> I don't see where you deal with executable files.

This code sets permissions for files written to the .git/ directory. 
Are there script files in the .git/ directory that we want to set 
executable flag for?

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
