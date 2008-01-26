From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [ANNOUNCE] Pyrite project.
Date: Sat, 26 Jan 2008 16:58:33 -0600
Message-ID: <5d46db230801261458k23f8054w38895a9f1647b476@mail.gmail.com>
References: <5d46db230801260127pf6f7a2fwfc8f35884a6322e@mail.gmail.com>
	 <alpine.LSU.1.00.0801261311380.23907@racer.site>
	 <5d46db230801260842i89db074u29657c22f6dbedef@mail.gmail.com>
	 <alpine.LSU.1.00.0801261654410.23907@racer.site>
	 <5d46db230801260937w3a514842t3943d0bd7c8dfb70@mail.gmail.com>
	 <alpine.LSU.1.00.0801261749000.23907@racer.site>
	 <5d46db230801261453q5d877e4eva8adbb5bc233bb75@mail.gmail.com>
	 <5d46db230801261455u1d27979ex662366f7abaee6fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 23:59:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JItzO-0002vP-Cp
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 23:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYAZW6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 17:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbYAZW6f
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 17:58:35 -0500
Received: from hs-out-0708.google.com ([64.233.178.240]:63599 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752514AbYAZW6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 17:58:34 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1036184hsz.5
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 14:58:33 -0800 (PST)
Received: by 10.150.192.7 with SMTP id p7mr1539927ybf.21.1201388313453;
        Sat, 26 Jan 2008 14:58:33 -0800 (PST)
Received: by 10.150.156.18 with HTTP; Sat, 26 Jan 2008 14:58:33 -0800 (PST)
In-Reply-To: <5d46db230801261455u1d27979ex662366f7abaee6fa@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 12352c1b4c1c2f18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71793>

 Apologies, sending to the list.


 ---------- Forwarded message ----------
 From: Govind Salinas <blix@sophiasuchtig.com>
  Date: Jan 26, 2008 4:53 PM
 Subject: Re: [ANNOUNCE] Pyrite project.
 To: Johannes Schindelin <Johannes.Schindelin@gmx.de>





 On 1/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
 >   Hi,
 >
 > On Sat, 26 Jan 2008, Govind Salinas wrote:
 >
 > > On 1/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
 >  >
 > > > On Sat, 26 Jan 2008, Govind Salinas wrote:
 >  > >
 > > > > On 1/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
 >  > > >
 > > > > > Govind wrote:
 > > > > >
 >  > > > > >  3. Start stripping away non-performance-critical C code and
 > > > > > >     convert it to python code to help interoperate with
 > > > > > >     extensions and GUIs
 >   > > > >
 > > > > > I am absolutely no fan of "extensions".  You keep breaking other
 > > > > > people's code if your core introduces changes; see for example the
 > > > > > libgit.a issue with cgit.
 >   > > >
 > > > > The nice thing about extensions is that you don't have to use them
 > > > > if you don't want to.
 > > >
 > > > I know what the nice thing about extensions is.  My point was that
 >   > > there is also a pretty nasty side.  One that I am not prepared to
 > > > accept easily.
 > >
 > > There is another benefit too.  Have a bit of code that might be
 > > dangerous? Put it in an extension and it can be tested in isolation,
 >   > without the need to rebuild the project (for people that offer to test
 > > for you).  Once it is ready and tested for general use, it can
 > > beincorporated into the standard.
 >
 > We have branches for that.  We don't even need an extension mechanism.


 If you have branches, you still need to pull the code and build it.  Extensions
 allow you to deliver functionality at will.  You can also deliver things with
 the standard distribution that not all users will want.  Imagine you had an
 extension to deal with cross platform issues like the case-sensitivity and
 unicode decomposing on OSX.  People who don't need this, don't ever
 incur the extra overhead.  People doing cross-platform can load them
 and people who aren't, don't have to.

 YMMV

 -Govind
