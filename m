From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 22:27:16 +1000
Message-ID: <2cfc403205042205277b2d9f69@mail.gmail.com>
References: <1114166517.3233.4.camel@localhost>
	 <2cfc4032050422043419b578cd@mail.gmail.com>
	 <20050422121059.GB7173@pasky.ji.cz>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Christian Meder <chris@absolutegiganten.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 14:23:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOxBP-0003ho-RP
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 14:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVDVM1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 08:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVDVM1Y
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 08:27:24 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:48113 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262034AbVDVM1R convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 08:27:17 -0400
Received: by rproxy.gmail.com with SMTP id c51so638339rne
        for <git@vger.kernel.org>; Fri, 22 Apr 2005 05:27:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i8l8Y0oAUWyKpw+6UnlZPVnbKlhlGVUJeXfqcLFydT3HZPa4IxZ4TwdhnMfhhF++gzBez4y74cNlSbQcxvNKF8tlR6Ve9veX/n+G/+0pzoH8HGohE659sOqvoi9YoH1k2E6pHbyYwAva8xIoYoqHewZOzXCRauhhHK3/wazYgLM=
Received: by 10.38.15.7 with SMTP id 7mr3373760rno;
        Fri, 22 Apr 2005 05:27:16 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Fri, 22 Apr 2005 05:27:16 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422121059.GB7173@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/22/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Fri, Apr 22, 2005 at 01:34:45PM CEST, I got a letter
> where Jon Seymour <jon.seymour@gmail.com> told me that...
> > On 4/22/05, Christian Meder <chris@absolutegiganten.org> wrote:
> > >
> > > Comments ? Ideas ? Other feedback ?
> > >
> >
> > I'd suggest serving XML rather than HTML and using client side XSLT to
> > transform it into HTML. ...
> 
> Why "rather than"? Why not "in addition to"?
> 
> You just append either .html or .xml, based on what you want.
> 

You are right - there is no good reason that an implementation should
not to support both.

>From the point of view of a specification, though, I think it would be
useful to focus on an XML content model rather than the details of one
particular HTML model - get the XML model right and you can do
whatever you like with the HTML model at any time after that.

jon.

On 4/22/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Fri, Apr 22, 2005 at 01:34:45PM CEST, I got a letter
> where Jon Seymour <jon.seymour@gmail.com> told me that...
> > On 4/22/05, Christian Meder <chris@absolutegiganten.org> wrote:
> > >
> > > Comments ? Ideas ? Other feedback ?
> > >
> >
> > I'd suggest serving XML rather than HTML and using client side XSLT to
> > transform it into HTML. Client-side XSLT works well in IE 6 and all
> > versions of Firefox, so there is no question that it is a mature
> > technology. Provide a fall back via server transformed HTML if need
> > be, but that is trivial to do once you have the client-side XSLT
> > stylesheets.
> >
> > Serving XML is as easy as serving HTML and gives you a much more
> > flexible outcome.
> 
> Why "rather than"? Why not "in addition to"?
> 
> You just append either .html or .xml, based on what you want.
> 
> --
>                                 Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> 


-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
