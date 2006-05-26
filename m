From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git-format-patch possible regressions
Date: Fri, 26 May 2006 08:09:12 +0200
Message-ID: <e5bfff550605252309h2c4b74bcp50b095e09e6c133f@mail.gmail.com>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
	 <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0605260014340.13003@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vy7wpr97n.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0605260125420.16816@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 26 08:09:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjVVe-0003QX-6L
	for gcvg-git@gmane.org; Fri, 26 May 2006 08:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWEZGJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 02:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbWEZGJO
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 02:09:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:19096 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030506AbWEZGJO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 02:09:14 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1976373wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 23:09:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dn6BsJ1VpdRov55TaDvfalcwtYhwGMKS8SfYiY0f+xeBRgPMHAnJxHBh3ndkvyq0PYbXsAlLmg8kdM9jwXGJi51q6aKUIN1hkB9ceVR4kqJg/vmGL3jUxRCIVKaw9HcSsCB9QkNqdJE4f8PrV7Yod50/kGj4vO7kP3OTts10llQ=
Received: by 10.65.254.13 with SMTP id g13mr131374qbs;
        Thu, 25 May 2006 23:09:12 -0700 (PDT)
Received: by 10.64.142.14 with HTTP; Thu, 25 May 2006 23:09:12 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605260125420.16816@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20797>

On 5/26/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 25 May 2006, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > Thinking about this again, it makes more sense not to imply --numbered:
> >
> > Yes, that makes sense.  That way you can say "Please start
> > naming the output files at 0032-xxxx.txt, because you gave me 31
> > patch series last time, but I do not want [PATCH x/y] on the
> > subject line, just [PATCH]".
> >
> > That brings up another issue.  Don't we need to have another
> > option --total-number that overrides the /y part above?
>
> I thought about that, too. Isn't the --numbered only useful for submitting
> a patch series via mail? And isn't it necessary to make certain that these
> patches really apply in that order? Isn't it then sensible to force the
> user to have a branch (at least a throw-away one) having exactly these
> patches, just to make sure that the patches really, really apply in that
> order?
>
> If all that is true, then --start-number && --numbered does not make sense
> at all.
>

I was thinking, probably wrong, that the number prepended in file name
is used also to disambiguate two patches with the same subject.


     Marco
