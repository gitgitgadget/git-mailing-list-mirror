From: Bertrand Jacquin <beber.mailing@gmail.com>
Subject: Re: git-http-push and hooks
Date: Tue, 7 Feb 2006 22:02:42 +0100
Message-ID: <4fb292fa0602071302p551aca02j53d40e3f8e25ff8a@mail.gmail.com>
References: <20060206205203.GA20973@guybrush.melee>
	 <20060206232231.GK3873@reactrix.com>
	 <20060207195458.GA7217@c165.ib.student.liu.se>
	 <20060207202351.GA3833@reactrix.com>
	 <20060207205709.GB7217@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nick Hengeveld <nickh@reactrix.com>,
	"Bertrand Jacquin (Beber)" <beber@guybrush.melee>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 22:29:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6aOF-0003zm-5t
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 22:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWBGV23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 16:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWBGV23
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 16:28:29 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:23690 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964874AbWBGV22 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 16:28:28 -0500
Received: by uproxy.gmail.com with SMTP id h2so14963ugf
        for <git@vger.kernel.org>; Tue, 07 Feb 2006 13:28:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y0lYh99Ib9VhJYeOemE34d7+INkUyz/Dh+DJZdQ8f80BCWIy3J4fclUGeQ5QtOBN7gQJD5KUydGaTmqp7oOoU6zXxk645azpAeaaWQjCHSJmC/C6x++9kbE8QdeIf8gfk0SDGJ36tBBrHkE0ZtrJb9TaT+f8VVk18HegH0JFeUE=
Received: by 10.48.108.11 with SMTP id g11mr1695625nfc;
        Tue, 07 Feb 2006 13:02:42 -0800 (PST)
Received: by 10.49.5.3 with HTTP; Tue, 7 Feb 2006 13:02:42 -0800 (PST)
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060207205709.GB7217@c165.ib.student.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15717>

On 2/7/06, Fredrik Kuivinen <freku045@student.liu.se> wrote:
> On Tue, Feb 07, 2006 at 12:23:51PM -0800, Nick Hengeveld wrote:
> > On Tue, Feb 07, 2006 at 08:54:58PM +0100, Fredrik Kuivinen wrote:
> >
> > > I know basically nothing about DAV, but wouldn't it be possible to
> > > have a CGI-script which executes the hooks upon the client's request?
> >
> > It would, although if custom software can be run on the server you might
> > as well run the git daemon.
>
> You can't push to a git daemon, can you?
>
> Furthermore, if the user has a working http/DAV server installed it
> might be the case that she prefers to use that one instead of
> installing a new daemon.

Personaly is use http because at work i've a $$@#! proxy and allow dav
and nothing else.
Could you push over http/proxy with gitdaemon ? Isn't it just a read
only method ?

>
> - Fredrik
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
Beber
#e.fr@freenode
