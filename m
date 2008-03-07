From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [announce] text-based tree visualizer
Date: Fri, 07 Mar 2008 05:45:50 -0800 (PST)
Message-ID: <m3ablahcl4.fsf@localhost.localdomain>
References: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr>
	<20080306201429.GA24528@old.davidb.org>
	<Pine.LNX.4.64.0803062137020.7660@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Fri Mar 07 14:46:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXcu8-0004Nm-Og
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 14:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbYCGNpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 08:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbYCGNpz
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 08:45:55 -0500
Received: from ik-out-1112.google.com ([66.249.90.183]:42454 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbYCGNpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 08:45:54 -0500
Received: by ik-out-1112.google.com with SMTP id c28so1118750ika.5
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 05:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=3IGgnSZTDNZjboXesWyD2DblHBsbhnKjZ3PVIyCCXN4=;
        b=KkH1RxBgRsRivz5NmtEbEaJIQyQ60fd2Hq1d2MXGKsEZEZq2GPKvPTpWfWJGtUyw4OmIZ7v3zWDeaipA3Yd3LM0T2+ausyBhbeyVAnSVuunKj0f4ToeaFarRuu5qhH7eh5lzeTMQbKZ/XZKBzW7rPXwhIzMe3uNNh0vX8ttoUuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=WoAW0kmtCdY64jXclm740lrRoiGn7fcpdHOf7YkliqP+XOvUzwnaiyh7hDEBTpH14YY1jb8i/mgTcUPiLdwb6QiUAuk3rWxP2/l3Lu8dhD2DnmD38dC/TubbI4NXCJ6aBZQT3kpIJlBBG/Zn7q/4HiTCDXn+fsDPhnA0E7wzdwo=
Received: by 10.78.165.16 with SMTP id n16mr3686445hue.59.1204897551008;
        Fri, 07 Mar 2008 05:45:51 -0800 (PST)
Received: from localhost.localdomain ( [83.8.252.126])
        by mx.google.com with ESMTPS id 24sm2201046huf.23.2008.03.07.05.45.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 05:45:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m27DjlLw000431;
	Fri, 7 Mar 2008 14:45:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m27DjhIM000427;
	Fri, 7 Mar 2008 14:45:43 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <Pine.LNX.4.64.0803062137020.7660@fbirervta.pbzchgretzou.qr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76491>

Jan Engelhardt <jengelh@computergmbh.de> writes:

> On Mar 6 2008 12:14, David Brown wrote:
>> On Thu, Mar 06, 2008 at 06:48:19PM +0100, Jan Engelhardt wrote:
>>
>>> Program (perl):
>>> http://dev.computergmbh.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest
>>> Top of file contains option overview.
>>
>> Do you have a git URL instead of just a link to a single version of a
>> single file?  I haven't been able to figure one out.
> 
> No problem; git://dev.computergmbh.de/hxtools .
> 
> Any idea how I can make gitweb display an URL text like it does on
> http://git.kernel.org/?p=git/git.git;a=summary ?

Please read gitweb/README and gitweb/INSTALL.

>From gitweb/README:

 * GITWEB_BASE_URL
   Git base URLs used for URL to where fetch project from, i.e. full
   URL is "$git_base_url/$project".  Shown on projects summary page.
   Repository URL for project can be also configured per repository; this
   takes precendence over URL composed from base URL and project name.
   Note that you can setup multiple base URLs (for example one for
   git:// protocol access, one for http:// access) from gitweb config
   file.  [No default]

[...]

 * @git_base_url_list
   List of git base URLs used for URL to where fetch project from, shown
   in project summary page.  Full URL is "$git_base_url/$project".
   You can setup multiple base URLs (for example one for  git:// protocol
   access, and one for http:// "dumb" protocol access).  Note that per
   repository configuration in 'cloneurl' file, or as values of gitweb.url
   project config.

[...]

 * cloneurl (or multiple-valued gitweb.url)
   File with repository URL (used for clone and fetch), one per line.
   Displayed in the project summary page. You can use multiple-valued
   gitweb.url repository configuration variable for that, but the file
   takes precendence.


P.S. Will you add short info about your tool to the GitWiki page
     http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
     (somewhere along gitk and tig, in "History Viewers..." section)?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
