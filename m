From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 22:08:22 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511182208.24248.ismail@uludag.org.tr>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 21:09:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCXu-00045D-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVKRUJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKRUJO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:09:14 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:39096 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932426AbVKRUJO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 15:09:14 -0500
Received: from dsl.dynamic8599158195.ttnet.net.tr (unknown [85.99.158.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 060C6AAF91
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 22:09:06 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <20051118200217.GA2831@vrfy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12252>

On Friday 18 November 2005 22:02, you wrote:
> On Fri, Nov 18, 2005 at 09:27:06PM +0200, Ismail Donmez wrote:
> > On Friday 18 November 2005 19:26, you wrote:
> > > On Friday 18 November 2005 18:33, you wrote:
> > > > Hi all,
> > > >
> > > > I am trying to parse git's rss feed and now xml parsers seems to
> > > > choke on it because of an error in the produced feed. Looking at
> > > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;
> > > >a=rs s
> > > >
> > > > line 781 says :
> > > >
> > > > On Thu, 17 Nov 2005, David G\363mez wrote:<br/>
> > > >
> > > > which is part of the commit :
> > > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;
> > > >a=co mm it;h=05b8b0fafd4cac75d205ecd5ad40992e2cc5934d
> > >
> > > Ok looks like this text is latin-1 encoded although xml is served as
> > > utf-8.
> >
> > Any comments on this?
>
> Yes, convince the git maintainers, that it's incredibly stupid not to
> enforce utf8 in commit messages. It makes absolutely zero sense in a
> SCM, which merges forth and back between people around the world to
> allow random encodings from the last century.
>

I totally agree, utf8 should be default else the produced XML is wrong. Its 
advertised as utf-8 but the content is latin1. 

> With the next round of gitweb, I will substitute these caracters with
> valid utf8, which will show up as invalid chars.

When should we expect this? Currently I can't parse commit feed without 
encoding to utf8 first.

> And git guys, please start to think again about your insane options,
> that cause more harm than anything good.

Can git maintainer(s) comment on this please? 

Regards,
ismail
