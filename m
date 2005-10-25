From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Convention for help in git commands?
Date: Wed, 26 Oct 2005 11:07:08 +1300
Message-ID: <46a038f90510251507oe62ce42i86e6d4cf8200f20@mail.gmail.com>
References: <200510251508.43552.Josef.Weidendorfer@gmx.de>
	 <7vfyqpe87x.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90510251324s50911b88pb5eabb304644bcad@mail.gmail.com>
	 <200510252335.47917.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 00:09:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUWx1-00089z-P8
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 00:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVJYWHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVJYWHO
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 18:07:14 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:54539 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932453AbVJYWHI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 18:07:08 -0400
Received: by xproxy.gmail.com with SMTP id i30so37002wxd
        for <git@vger.kernel.org>; Tue, 25 Oct 2005 15:07:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OIfgJT76UQPhOrwtzNzyMMxfb++kt9kPswslfG0Y3yxwl4/nk6pua+eYcVrBV842xAyDV20w5d2MespxusjFZ7Kjc/gKbViW45kzcH3zfz3RlqThRF7WP8b90S/YCWmv6+UUIj+JVskbvV7Zcp00sCQQKdPmA1KGr/IX604hXh4=
Received: by 10.65.23.10 with SMTP id a10mr177695qbj;
        Tue, 25 Oct 2005 15:07:08 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Tue, 25 Oct 2005 15:07:08 -0700 (PDT)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200510252335.47917.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10625>

On 10/26/05, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 25 October 2005 22:24, you wrote:
> > On 10/26/05, Junio C Hamano <junkio@cox.net> wrote:
> > > > * For commands which need at least one argument, the usage
> > > > is also printed, if the command is run without argument
> > >
> > > This is slightly debatable.  I'd rather see it error out for one
> > > thing, and we might want to do a sane default given no arguments
> > > later.
> >
> > This could lead to subtle bugs when git is used by porcelains. If
> > there are going to be changes in default behaviours, let's have them
> > soon-ish ;-)
>
> What is the difference for a porcelain between error out,
> presumable with an error message, and printing the usage alone?

Sorry! My comment was aimed at the "do a sane default given no
arguments later" part of Junio's post. Error vs help messages don't
affect porcelains if you check your tty and avoid spitting out a help
message when invoked from a script ;-)

cheers,


martin
