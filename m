From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: What's in git.git
Date: Wed, 02 Aug 2006 22:15:43 -0700
Message-ID: <44D1867F.3090805@gmail.com>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>	<20060802192922.GA30539@prophet.net-ronin.org> <7virlas9ol.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	carbonated beverage <ramune@net-ronin.org>
X-From: git-owner@vger.kernel.org Thu Aug 03 07:16:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8VYz-0005yU-Ev
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 07:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWHCFPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 01:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWHCFPu
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 01:15:50 -0400
Received: from qb-out-0506.google.com ([72.14.204.232]:22072 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932223AbWHCFPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 01:15:50 -0400
Received: by qb-out-0506.google.com with SMTP id p36so32173qba
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 22:15:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GZcNl0nrPI2fxon7EeCSA7RGsGhx8V5l12qgGIdX0HZ18TTKK7fXVvbPKyhTXZhCGF6tjUg4U/g3kYFxsdW3niS2UP5BcPdDE5lT4396Wz4eECA8EYf2qNobhV7NZL5EVpHAQeTHSY/mjCPSqHCfzmjI+0Lz2mQxNfBiUtxpoPs=
Received: by 10.35.78.13 with SMTP id f13mr2712142pyl;
        Wed, 02 Aug 2006 22:15:49 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.32.187.210])
        by mx.gmail.com with ESMTP id c12sm4573196nzc.2006.08.02.22.15.45;
        Wed, 02 Aug 2006 22:15:48 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7virlas9ol.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24703>

Broken for me also:
	Suse 9.3
	Ubuntu Hoary
	Ubuntu Breezy

No Gnome(s) here.


Junio C Hamano wrote:
> carbonated beverage <ramune@net-ronin.org> writes:
> 
>> Any plans on a fix for:
>> http://marc.theaimsgroup.com/?l=git&m=115089393505286&w=2
> 
> Unfortunately, plan needs to be drawn by somebody who sees
> breakage.
> 
>> Commenting out the line mentioned in the reply lets me resize the window and
>> see the bottom panel properly -- but I do have to resize it every time so it
>> doesn't extend past the bottom of the screen.
>>
>> FYI, if it's not easy to reproduct, I'm running it on Debian/stable systems,
>> i386 and x86_64, both with backports.org X servers, using tcl/tk 8.4
> 
> I am running Debian/testing+unstable on i386 and x86_64 with
> tcl8.4 (8.4.12-1.1) and tk8.4 (8.4.12-1), displaying on
> xserver-xorg (1:7.0.22).  I cannot get gitk to misbehave the way
> the quoted post describes.  Even after resizing it to so short
> that the bottom search input and commitdiff area becomes
> invisible, moving the middle separator around gives the lower
> panes back, and both of the scrollbars on the lower panes seem
> to be behaving during that exercise.
> 
> The "workaround" to disable ".ctop conf" feels actively wrong;
> this makes the command forget the dimension from the last
> session, which is not so different from removing ~/.gitk every
> time.
> 
> Could this be some funny interaction between window manager and
> gitk perhaps?  I think my machines run metacity and the
> environment is minimally Gnome.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
