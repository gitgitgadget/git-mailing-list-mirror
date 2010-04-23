From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 18:01:57 +0200
Message-ID: <25441792-181D-456D-8182-F33B49209EFF@wincent.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain> <alpine.LFD.2.00.1004221445310.7232@xanadu.home> <87sk6n4426.fsf@frosties.localdomain> <alpine.LFD.2.00.1004221651590.7232@xanadu.home> <87vdbitu9v.fsf@frosties.localdomain>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 18:33:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5LoX-0001YQ-SI
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 18:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012Ab0DWQcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 12:32:53 -0400
Received: from outmail148106.authsmtp.co.uk ([62.13.148.106]:62910 "EHLO
	outmail148106.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732Ab0DWQcw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 12:32:52 -0400
X-Greylist: delayed 1836 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2010 12:32:51 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt3.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o3NG27M5086751;
	Fri, 23 Apr 2010 17:02:07 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o3NG21ux033862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Apr 2010 17:02:02 +0100 (BST)
Received: from [192.168.1.6] (175.Red-88-3-72.dynamicIP.rima-tde.net [88.3.72.175])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o3NG1vxu016543
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 23 Apr 2010 12:01:59 -0400
In-Reply-To: <87vdbitu9v.fsf@frosties.localdomain>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: 8e6eefc7-4ef1-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCEVH aB0dB0JJdwdEHAkR AmEBW1ZeUF8/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNF3sfAx1E Th4dURF0dUtHcHdx bQhqC3YOCRIpclt5 FxhVCGwHMTF9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcQVbMysj Ekc/Mj44IDFDYDhS Ck4GKlcXQFpDWzdz Dw8CEDNnG0pNTCU6 KRMrMRYDEVwcekw+ PVYtMQAA
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145626>

El 23/04/2010, a las 11:03, Goswin von Brederlow escribi=F3:
>=20
> You all say the index is such a great thing. So I might use it
> eventually. Other people might use it 1 out of 10 times. Yet other
> people use it 9 out of 10 times. Can you at least accept that the use=
 of
> the index feature is different for each person?
>=20
> My suggested change, with the --a-if-empty option, would not impose
> anything on existing usage. But it would benefit those that rarely us=
e
> an index and would like git to be smart enough to know when to use th=
e
> index and when not. Yes, it would mean the use of the index ideology =
is
> not force upon people anymore. But isn't that a good thing? Free
> software is about freedom. That should include the freedom not to use
> the index method.

Not really. Git is free in the sense that: (1) it costs nothing; and (2=
) you can modify the code to do anything you want.

But you've also got to recognize that along with your freedom to make m=
odifications, the maintainers are free to either accept or reject them =
too.=20

And in the event that the changes you want aren't accepted, you're free=
 to either fork the tool or pick another one which does conform better =
to your expectations.

In the present case experience has shown that the index and the way it =
can be exploited are an incredibly useful thing. Not only that, it's a =
differentiating feature of Git and it sets it apart from other SCMs, in=
 a good way. We could mindlessly homogenize to be more like other syste=
ms, or less "surprising" for users coming from other systems, but we'd =
be throwing away something valuable in the process.

I personally don't see the point in having a bunch of SCMs that are all=
 exactly alike. I _like_ that Git's different, and over the years have =
become so used to the benefits that working with the index "the Git way=
" bring, that it's hard to imagine how I ever lived without it.

Cheers,
Wincent
