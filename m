From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: gitview: Use monospace font to draw the branch and tag name
Date: Sat, 25 Feb 2006 12:30:06 +0530
Message-ID: <cc723f590602242300h65e6a9d6k87148d2124a71907@mail.gmail.com>
References: <43FC8BF2.60205@gmail.com>
	 <7vr75tc8gj.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590602240829y3ebffaf9mdd7de0cd2a9051e@mail.gmail.com>
	 <7vzmkg6kj7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 08:01:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCtQI-0000gH-JF
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 08:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWBYHAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 02:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBYHAJ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 02:00:09 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:1244 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932386AbWBYHAI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 02:00:08 -0500
Received: by uproxy.gmail.com with SMTP id j3so198399ugf
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 23:00:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aM7fCxNJhXDs2sruSvwFliCuhXQcVnOcX/vWK8p1WdD07kqnqXJG/qvLgrdwFZfi1iRaMHgTpX+YK52SxVdLSa188EKR66AiYk+T4kwZHDZd95lYZmX4VogYVsoGZFIW2T3Gpt15UH5cvLi3Osb5wlgYIMeOGyLrAuWXNTfizz0=
Received: by 10.66.222.18 with SMTP id u18mr2517048ugg;
        Fri, 24 Feb 2006 23:00:06 -0800 (PST)
Received: by 10.66.254.7 with HTTP; Fri, 24 Feb 2006 23:00:06 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vzmkg6kj7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16759>

On 2/25/06, Junio C Hamano <junkio@cox.net> wrote:
>
> >> I have an impression that hardcoding UI policy like this is
> >> generally frowned upon.
> >
> > But with that changes branch and the tag name looks neat.
>
> The point being that it only looks neat on your display, with
> its size and resolution, and to your eye.
>
> People have different tastes and equipments.  One thing I really
> liked gitk (I do not know if gitview does this as well -- if so
> I am happy) is I can do - and + to change the text size
> depending on what display I am working on.
>
>

Point taken. Right now gitview doesn't support + and - key binding. I
will try to add that. For the time being can you can drop my font and
font size related  changes and apply rest of the patches.

-aneesh
