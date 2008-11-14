From: =?ISO-8859-1?Q?=22Andr=E9s_G=2E_Aragoneses=22?= <knocte@gmail.com>
Subject: Re: git integration with monodevelop
Date: Fri, 14 Nov 2008 12:53:47 -0500
Message-ID: <gfkdv8$tsj$1@ger.gmane.org>
References: <491AAE6D.8030304@op5.se> <1226519288.4483.176.camel@erandi.site>
	<m33ahwio3v.fsf@localhost.localdomain>
	<1226540535.4483.203.camel@erandi.site>
	<alpine.DEB.1.00.0811141419520.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
To: monodevelop-list@lists.ximian.com
X-From: monodevelop-list-bounces@lists.ximian.com Fri Nov 14 18:55:18 2008
Return-path: <monodevelop-list-bounces@lists.ximian.com>
Envelope-to: gcgmm-monodevelop-list@m.gmane.org
Received: from galactus.ximian.com ([130.57.169.22] helo=lists.ximian.com)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L12sv-0002hg-G9
	for gcgmm-monodevelop-list@m.gmane.org; Fri, 14 Nov 2008 18:55:09 +0100
Received: from galactus.ximian.com (localhost.localdomain [127.0.0.1])
	by lists.ximian.com (Postfix) with ESMTP id CB2471CFB9B;
	Fri, 14 Nov 2008 12:53:58 -0500 (EST)
X-Original-To: monodevelop-list@lists.ximian.com
Delivered-To: monodevelop-list@lists.ximian.com
Received: from herald.ximian.com (frontgate.ximian.com [130.57.169.19])
	by lists.ximian.com (Postfix) with ESMTP id F2BE91CFB55
	for <monodevelop-list@lists.ximian.com>;
	Fri, 14 Nov 2008 12:53:56 -0500 (EST)
Received: by herald.ximian.com (Postfix, from userid 2601)
	id E7F9E7002D; Fri, 14 Nov 2008 12:53:56 -0500 (EST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by herald.ximian.com (Postfix) with ESMTP id 06C217002D
	for <monodevelop-list@lists.ximian.com>;
	Fri, 14 Nov 2008 12:53:53 -0500 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L12rg-0007wZ-CI
	for monodevelop-list@lists.ximian.com; Fri, 14 Nov 2008 17:53:52 +0000
Received: from 130.57.22.201 ([130.57.22.201])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <monodevelop-list@lists.ximian.com>; Fri, 14 Nov 2008 17:53:52 +0000
Received: from knocte by 130.57.22.201 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <monodevelop-list@lists.ximian.com>; Fri, 14 Nov 2008 17:53:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 130.57.22.201
User-Agent: Thunderbird 2.0.0.17 (X11/20080922)
In-Reply-To: <alpine.DEB.1.00.0811141419520.30769@pacific.mpi-cbg.de>
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	frontgate.ximian.com
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=5.0 tests=RCVD_BY_IP, RCVD_NUMERIC_HELO, 
	SPF_HELO_PASS,SPF_PASS version=3.0.3
X-BeenThere: monodevelop-list@lists.ximian.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: MonoDevelop discussion mailing list
	<monodevelop-list.lists.ximian.com>
List-Unsubscribe: <http://lists.ximian.com/mailman/listinfo/monodevelop-list>, 
	<mailto:monodevelop-list-request@lists.ximian.com?subject=unsubscribe>
List-Archive: <http://lists.ximian.com/pipermail/monodevelop-list>
List-Post: <mailto:monodevelop-list@lists.ximian.com>
List-Help: <mailto:monodevelop-list-request@lists.ximian.com?subject=help>
List-Subscribe: <http://lists.ximian.com/mailman/listinfo/monodevelop-list>,
	<mailto:monodevelop-list-request@lists.ximian.com?subject=subscribe>
Sender: monodevelop-list-bounces@lists.ximian.com
Errors-To: monodevelop-list-bounces@lists.ximian.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100994>

Johannes Schindelin wrote:
> Hi,
> =

> On Wed, 12 Nov 2008, Miguel de Icaza wrote:
> =

>>> I assume that results of Mono's Google Summer of Code 2008 projects to =

>>> create managed git implementation in C# (git#)[1][2] were not very =

>>> successfull?  Taking into account that JGit isn't yet full git =

>>> implementation, after much longer development...
>> They were a complete disaster, one student was going to focus on the =

>> front-end, the other on the back-end.
> =

> I kinda followed the last few weeks via your svn repository (which was no=
t =

> helped by the commits being a complete mix of the individual projects).
> =

> I was a bit disappointed that nobody asked things on the Git mailing list=
; =

> quite a number of very important lessons were learnt during the first =

> implementation of jgit, and you guys could have benefitted tremendously b=
y =

> hearing them.
> =

> By the time I got aware of your effort, it was too late; for example, the =

> code already relied on the fact that every blob's contents were read into =

> memory at once (IIU the code correctly).
> =

> Note: personally, I do not like C# all that much, so I am not that =

> interested in the port myself.  However, we get quite a number of =

> questions in that direction ("do you support .NET yet?"), so I am quite =

> interested to know what's available.

Have you looked at using Sharpen [1]?

[1]
http://evain.net/blog/articles/2008/05/20/sharpen-an-open-source-java-to-c-=
converter

Regards,

	Andr=E9s

-- =
