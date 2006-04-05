From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC/PATCH] date parsing: be friendlier to our European friends.
Date: Thu, 6 Apr 2006 00:47:51 +0200
Message-ID: <20060405224751.GA10139@mars.ravnborg.org>
References: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net> <20060404231606.219a4cc5.akpm@osdl.org> <7virpo4jxf.fsf@assigned-by-dhcp.cox.net> <7vlkujzly0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 06 00:48:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRGny-0001Dp-HT
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 00:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWDEWr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 18:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWDEWr6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 18:47:58 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:4370 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932113AbWDEWr5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 18:47:57 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 1F2481EC308;
	Thu,  6 Apr 2006 00:47:56 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 0031743C21C; Thu,  6 Apr 2006 00:47:51 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkujzly0.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18457>

On Wed, Apr 05, 2006 at 03:39:35PM -0700, Junio C Hamano wrote:
> This does three things, only applies to cases where the user
> manually tries to override the author/commit time by environment
> variables, with non-ISO, non-2822 format date-string:
> 
>  - Refuses to use the interpretation to put the date in the
>    future; recent kernel history has a commit made with
>    10/03/2006 which is recorded as October 3rd.
> 
>  - Adds '.' as the possible year-month-date separator.  We
>    learned from our European friends on the #git channel that
>    dd.mm.yyyy is the norm there.

I my company we have always used yyyy-mm-dd - this is an ISO standard
IIRC. The company is European based.

mm/dd/yy has always made my head spin ;-)

	Sam
