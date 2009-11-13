From: Curt Sampson <cjs@cynic.net>
Subject: Re: Bug: "git svn clone" does not honor svn.authorsfile setting
Date: Fri, 13 Nov 2009 23:06:31 +0900
Message-ID: <20091113140631.GZ19475@poetic.cynic.net>
References: <20091110130913.GR19475@poetic.cynic.net> <4AFA3D04.3050109@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 15:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8wnN-0004Rg-JK
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 15:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbZKMOG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 09:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbZKMOG0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 09:06:26 -0500
Received: from static-122-103-239-153.ng-fam.svips.gol.ne.jp ([122.103.239.153]:64341
	"EHLO priv.dyadic.cynic.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752774AbZKMOG0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2009 09:06:26 -0500
Received: by priv.dyadic.cynic.net (Postfix, from userid 1765)
	id B2B3E2A242; Fri, 13 Nov 2009 23:06:31 +0900 (JST)
Content-Disposition: inline
In-Reply-To: <4AFA3D04.3050109@vilain.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132835>

On 2009-11-11 17:26 +1300 (Wed), Sam Vilain wrote:

> Does moving the line:
> 
> command_oneline('config', 'svn.authorsfile', $_authors) if $_authors;
> 
> Immediately prior to the "fetch_all" line before it fix the problem? It
> looks strange for it to set it afterwards...

That looks plausible to me, having had a quick look at the source, but
keep in mind I've already spent about 45 minutes debugging this problem
and figuring out how to file a bug report. I don't really have the time
at the moment to learn how to build and test new versions of git, unless
someone wants to walk me through it. I expect it would take rather less
time for someone in the know just to do the test.

cjs
-- 
Curt Sampson       <cjs@starling-software.com>        +81 90 7737 2974
           Functional programming in all senses of the word:
                   http://www.starling-software.com
