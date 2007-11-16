From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Fri, 16 Nov 2007 10:59:54 +0200
Message-ID: <4207CF02-36BD-4733-9861-17B0C4DB9D94@pp.inet.fi>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com>
 <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com>
 <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com>
 <8B2E66EB-22C7-4C08-9947-C0D6A755309F@pp.inet.fi>
 <E20C625B-100C-44B0-9AF3-7342DAF9B2A7@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 10:26:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsxSk-0000Gd-40
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 10:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbXKPJZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 04:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbXKPJZx
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 04:25:53 -0500
Received: from astana.suomi.net ([82.128.152.18]:52248 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489AbXKPJZv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 04:25:51 -0500
Received: from taku.suomi.net ([82.128.154.66])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JRL00BE7E3IH940@astana.suomi.net> for
 git@vger.kernel.org; Fri, 16 Nov 2007 11:23:42 +0200 (EET)
Received: from spam3.suomi.net (spam3.suomi.net [212.50.131.167])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRL00BRKE70NQA0@mailstore.suomi.net> for git@vger.kernel.org;
 Fri, 16 Nov 2007 11:25:49 +0200 (EET)
Received: from Kaalimaa.fudeco.com
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam3.suomi.net (Postfix) with ESMTP id B9B3A22D9CA; Fri,
 16 Nov 2007 10:59:55 +0200 (EET)
In-reply-to: <E20C625B-100C-44B0-9AF3-7342DAF9B2A7@wincent.com>
X-Mailer: Apple Mail (2.915)
X-DNA-MailScanner-Information: Please contact the ISP for more information
X-DNA-MailScanner: Found to be clean
X-DNA-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.784,
 required 5, AWL 0.12, BAYES_00 -1.00,	RDNS_DYNAMIC 0.10)
X-DNA-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65208>


On Nov 16, 2007, at 10:37, Wincent Colaiuta wrote:

> El 16/11/2007, a las 5:25, V=E4in=F6 J=E4rvel=E4 escribi=F3:
>
>> On Nov 15, 2007, at 18:11, Wincent Colaiuta wrote:
>>
>>> I don't use Darwin Ports or Fink, and this is a clean Leopard =20
>>> install (ie. nothing installed in /usr/local apart from git and a =20
>>> very small number of other tools that aren't related to Subversion)=
=2E
>>>
>>> This is the output of "/usr/bin/svn --version":
>>>
>>> svn, version 1.4.4 (r25188)
>>> compiled Sep 23 2007, 22:32:34
>>>
>>> Perhaps then it is something in the environment.
>>
>> I cannot reproduce this on Leopard (not yet updated to 10.5.1). I =20
>> tested this with self-compiled GIT from commit id ca2b71c
>>
>> svn version is the same as yours, I do use Fink, and I have used =20
>> Fink to install Perl SVN bindings.
>
> Strange. I've looked in the environment and there is nothing =20
> suspicious; in fact, running the tests with a totally clean =20
> environment (env -i ./t9101-git-svn-props.sh) produces exactly the =20
> same result.
>
> This was with commit 039bc64e (HEAD of master yesterday). I just =20
> tested the commit you mention (HEAD of next) and get the same =20
> failure; this is the procedure I'm using to test:
>
> git fetch
> git checkout -b next_test origin/next
> git describe # (v1.5.3.5-1780-gca2b71c)
> git clean
> make clean && make
> cd t
> env -i ./t9101-git-svn-props.sh
>
> So really, not sure what could be causing this.

Did you forget to install the newly compiled version? Or does the test =
=20
system use git from the source tree?

--
V=E4in=F6
