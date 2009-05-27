From: Aaron180 <aaron@vanstralen.net>
Subject: Re: Access Denied when pushing git
Date: Tue, 26 May 2009 20:48:09 -0700 (PDT)
Message-ID: <1243396089004-2978977.post@n2.nabble.com>
References: <1243388447198-2978561.post@n2.nabble.com> <robbat2-20090527T031233-374899931Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 05:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9A8E-0005Qy-6r
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 05:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbZE0DsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 23:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756744AbZE0DsI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 23:48:08 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40885 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756060AbZE0DsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 23:48:07 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1M9A7d-0004Uh-0Q
	for git@vger.kernel.org; Tue, 26 May 2009 20:48:09 -0700
In-Reply-To: <robbat2-20090527T031233-374899931Z@orbis-terrarum.net>
X-Nabble-From: aaron@vanstralen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120025>


Well it now works!  Thank you so much.  
Your mention in #2 helped, I thought maybe there is something going on with
windows' line endings or something along those lines since I am using
cygwin.  
I then realized I also had installed Msysgit, so I uninstalled Msysgit and
everything is working like a charm!

Not sure if that is what you intended but it sure nudged me in the right
direction!

Thank you,
Aaron


Robin H. Johnson-2 wrote:
> 
> On Tue, May 26, 2009 at 06:40:47PM -0700, Aaron180 wrote:
>> I've been trying to figure this out for two days now, any help would be
>> appreciated
> 1. I wouldn't rely on the '~' being expanded, try with a full path.
> 2. If there is a banner or some output from your bashrc, I've seen those
>    cause problems.
> 
> -- 
> Robin Hugh Johnson
> Gentoo Linux Developer & Infra Guy
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
View this message in context: http://n2.nabble.com/Access-Denied-when-pushing-git-tp2978561p2978977.html
Sent from the git mailing list archive at Nabble.com.
