From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Any way to get complete diff up to a tag?
Date: Fri, 7 May 2010 06:17:51 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC744829D68C7@xmail3.se.axis.com>
References: <AANLkTilOOYlrQ5hfgxFnCIG4Qp5RE_EbfzP6vkfqBAJM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "'Knittl'" <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 07 06:18:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAF0o-0008AY-6a
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 06:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824Ab0EGER7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 00:17:59 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:34272 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab0EGER6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 00:17:58 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o474Hq6M021020;
	Fri, 7 May 2010 06:17:52 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Fri, 7 May 2010 06:17:52 +0200
Thread-Topic: Any way to get complete diff up to a tag?
Thread-Index: AcrtM4US8DqJTHT9Rw6TgNd7DP/+lQAZ1WwQ
In-Reply-To: <AANLkTilOOYlrQ5hfgxFnCIG4Qp5RE_EbfzP6vkfqBAJM@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146518>

> -----Original Message-----
> From: git-owner@vger.kernel.org
> [mailto:git-owner@vger.kernel.org] On Behalf Of Knittl
> Sent: den 6 maj 2010 17:44
> To: Peter Kjellerstedt
> Cc: git@vger.kernel.org
> Subject: Re: Any way to get complete diff up to a tag?
>
> On Thu, May 6, 2010 at 11:27 AM, Peter Kjellerstedt
> <peter.kjellerstedt@axis.com> wrote:
> > Basically, what I think I am asking for is a way to specify the
> > empty parent of the initial commit, i.e., where v1.7.1~1000000 would
> > end up. I can see this being useful in at least one other case as
> > well, namely when doing an interactive rebase to allow the initial
> > commit to be rebased (something I have wanted to do a couple of
> > times...)
>
> wait, let me get this straight. you want to diff some tag against the
> empty parent of the root commit (empty tree)?
>
> which in turn means you will get a diff, where all lines in all files
> existing in the tree that tag references are added. all files get
> basically prefixed with + and have header information (filename). what
> purpose has such a diff?
>
> regards, daniel

Well, I can see a couple of purposes, but in my case I have a tool
post-processing the generated diff. And to it there is no difference
regarding what point was used as the start of the diff, whether it
was the empty tree (i.e., a diff containing everything), some commit
in the middle, or the last commit (i.e., an emptry diff). All it
wants is a diff.

//Peter
