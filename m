From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 15:32:33 +0200
Message-ID: <1114176754.3233.47.camel@localhost>
References: <1114166517.3233.4.camel@localhost>
	 <2cfc4032050422043419b578cd@mail.gmail.com>
	 <20050422121059.GB7173@pasky.ji.cz>
	 <2cfc403205042205277b2d9f69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:29:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyCX-0005Pe-7D
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVDVNco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVDVNco
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:32:44 -0400
Received: from shadow.prohost.de ([216.71.84.228]:64387 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S261511AbVDVNck
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 09:32:40 -0400
Received: from blue.office.onestepahead.de (h-62.96.100.62.host.de.colt.net [62.96.100.62] (may be forged))
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3MDWZu23615;
	Fri, 22 Apr 2005 15:32:35 +0200
To: jon@zeta.org.au
In-Reply-To: <2cfc403205042205277b2d9f69@mail.gmail.com>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 22:27 +1000, Jon Seymour wrote:
> On 4/22/05, Petr Baudis <pasky@ucw.cz> wrote:
> > Dear diary, on Fri, Apr 22, 2005 at 01:34:45PM CEST, I got a letter
> > where Jon Seymour <jon.seymour@gmail.com> told me that...
> > > On 4/22/05, Christian Meder <chris@absolutegiganten.org> wrote:
> > > >
> > > > Comments ? Ideas ? Other feedback ?
> > > >
> > >
> > > I'd suggest serving XML rather than HTML and using client side XSLT to
> > > transform it into HTML. ...
> > 
> > Why "rather than"? Why not "in addition to"?
> > 
> > You just append either .html or .xml, based on what you want.
> > 
> 
> You are right - there is no good reason that an implementation should
> not to support both.
> 
> >From the point of view of a specification, though, I think it would be
> useful to focus on an XML content model rather than the details of one
> particular HTML model - get the XML model right and you can do
> whatever you like with the HTML model at any time after that.

Actually I think the order is get the C content model right (done), get
the Python object model right (in flux), produce an appropriate XML
model.


				Christian
> 
> jon.
> 
> On 4/22/05, Petr Baudis <pasky@ucw.cz> wrote:
> > Dear diary, on Fri, Apr 22, 2005 at 01:34:45PM CEST, I got a letter
> > where Jon Seymour <jon.seymour@gmail.com> told me that...
> > > On 4/22/05, Christian Meder <chris@absolutegiganten.org> wrote:
> > > >
> > > > Comments ? Ideas ? Other feedback ?
> > > >
> > >
> > > I'd suggest serving XML rather than HTML and using client side XSLT to
> > > transform it into HTML. Client-side XSLT works well in IE 6 and all
> > > versions of Firefox, so there is no question that it is a mature
> > > technology. Provide a fall back via server transformed HTML if need
> > > be, but that is trivial to do once you have the client-side XSLT
> > > stylesheets.
> > >
> > > Serving XML is as easy as serving HTML and gives you a much more
> > > flexible outcome.
> > 
> > Why "rather than"? Why not "in addition to"?
> > 
> > You just append either .html or .xml, based on what you want.
> > 
> > --
> >                                 Petr "Pasky" Baudis
> > Stuff: http://pasky.or.cz/
> > C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> > 
> 
> 
-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

