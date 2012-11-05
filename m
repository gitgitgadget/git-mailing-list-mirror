From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 05 Nov 2012 15:13:04 +0100
Message-ID: <5097C970.9010901@drmicha.warpmail.net>
References: <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com> <509149D9.3070606@drmicha.warpmail.net> <CAMP44s2oKMog5GygrAag8SOdwhQJr4gCZxZAwWUo-ERDzni0ag@mail.gmail.com> <CAMP44s0KFJW2F3gbO_Xd9QKrZ1OoxvUCvecU084-zH2UDqXKag@mail.gmail.com> <CAMP44s3UHQE69O__EVK29uN_VPdZN=a0-Gczeh-Tbjp1ZAAbJw@mail.gmail.com> <20121102144827.GB11170@sigill.intra.peff.net> <CAMP44s1P5Y_H24=ZKS5n_rUORf1dTiqg3qXm3bHcOiQ8K12PUQ@mail.gmail.com> <CAMP44s1mbNBUspJ8SX=VwGSXthxWAHkrQLFR
 xzyCzkupLYSagA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 15:13:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVNQc-0008Iz-3V
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 15:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab2KEONK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 09:13:10 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50277 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab2KEONH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 09:13:07 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2A02820969;
	Mon,  5 Nov 2012 09:13:07 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 05 Nov 2012 09:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=f7HnBYMcgdGh+BQAsPy/3L
	PbUBY=; b=K4ExUfQxN8Fa9e0xgfiSRR35CyHMmGwpi5JVW/o1dhxEp0MvTyJRKM
	pbVOPxBCPSbF4WLJgX0093JQXZ2jxk4adR5+gxhli+mxA7qw9C6blN6eLULlsYLk
	uDxs4CdbYAwSTT1SXBHEWhlqX9Gz8/79qNc7r+TzCQWsqVx/Uqje0=
X-Sasl-enc: OeLfhVmFUhNonRg29RF2AQmITqJcgAFIFxbidnBetTaA 1352124786
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E91B34827D5;
	Mon,  5 Nov 2012 09:13:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMP44s1mbNBUspJ8SX=VwGSXthxWAHkrQLFRxzyCzkupLYSagA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209060>

Felipe Contreras venit, vidit, dixit 02.11.2012 19:01:
> On Fri, Nov 2, 2012 at 5:41 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Nov 2, 2012 at 3:48 PM, Jeff King <peff@peff.net> wrote:
>>> On Thu, Nov 01, 2012 at 05:08:52AM +0100, Felipe Contreras wrote:
>>>
>>>>> Turns out msysgit's remote-hg is not exporting the whole repository,
>>>>> that's why it's faster =/
>>>>
>>>> It seems the reason is that it would only export to the point where
>>>> the branch is checked out. After updating the to the tip I noticed
>>>> there was a performance difference.
>>>>
>>>> I investigated and found two reasons:
>>>>
>>>> 1) msysgit's version doesn't export files twice, I've now implemented the same
>>>> 2) msysgit's version uses a very simple algorithm to find out file changes
>>>>
>>>> This second point causes msysgit to miss some file changes. Using the
>>>> same algorithm I get the same performance, but the output is not
>>>> correct.
>>>
>>> Do you have a test case that demonstrates this? It would be helpful for
>>> reviewers, but also helpful to msysgit people if they want to fix their
>>> implementation.
>>
>> Cloning the mercurial repo:
>>
>> % hg log --stat -r 131
>> changeset:   131:c9d51742471c
>> parent:      127:44538462d3c8
>> user:        jake@edge2.net
>> date:        Sat May 21 11:35:26 2005 -0700
>> summary:     moving hgweb to mercurial subdir
>>
>>  hgweb.py           |  377
>> ------------------------------------------------------------------------------------------
>>  mercurial/hgweb.py |  377
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 377 insertions(+), 377 deletions(-)
>>
>> % git show --stat 1f9bcfe7cc3d7af7b4533895181acd316ce172d8
>> commit 1f9bcfe7cc3d7af7b4533895181acd316ce172d8
>> Author: jake@edge2.net <none@none>
>> Date:   Sat May 21 11:35:26 2005 -0700
>>
>>     moving hgweb to mercurial subdir
>>
>>  mercurial/hgweb.py | 377
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 377 insertions(+)
> 
> I talked with some people in #mercurial, and apparently there is a
> concept of a 'changelog' that is supposed to store these changes, but
> since the format has changed, the content of it is unreliable. That's
> not a big problem because it's used mostly for reporting purposes
> (log, query), not for doing anything reliable.

Is the changelog stored in the repo (i.e. generated by the hg version at
commit time) or generated on the fly (i.e. generated by the hg version
at hand)? See also below.

> To reliably see the changes, one has to compare the 'manifest' of the
> revisions involved, which contain *all* the files in them.

'manifest' == '(exploded) tree', right? Just making sure my hg fu is not
subzero.

> That's what I was doing already, but I found a more efficient way to
> do it. msysGit is using the changelog, which is quite fast, but not
> reliable.
> 
> Unfortunately while going trough mercurial's code, I found an issue,
> and it turns out that 1) is not correct.
> 
> In mercurial, a file hash contains also the parent file nodes, which
> means that even if two files have the same content, they would not
> have the same hash, so there's no point in keeping track of them to
> avoid extracting the data unnecessarily, because in order to make sure
> they are different, you need to extract the data anyway, defeating the
> purpose.

Do I understand correctly that neither the msysgit version nor yours can
detect duplicate blobs (without requesting them) because of that sha1 issue?

I'm really wondering why a file blob hash carries its history along in
the sha1. This appears completely strange to gitters (being brain washed
about "content tracking"), but may be due to hg's extensive use of
delta, or really: delta chains (which do have their merit on the server
side).

> Which means mercurial doesn't really behave as one would expect:
> 
> # add files with the same content
> 
>  $ echo a > a
>   $ hg ci -Am adda
>   adding a
>   $ echo a >> a
>   $ hg ci -m changea
>   $ echo a > a
>   $ hg st --rev 0
>   $ hg ci -m reverta
>   $ hg log -G --template '{rev} {desc}\n'
>   @  2 reverta
>   |
>   o  1 changea
>   |
>   o  0 adda
> 
> # check the difference between the first and the last revision
> 
>   $ hg st --rev 0:2
>   M a
>   $ hg cat -r 0 a
>   a
>   $ hg cat -r 2 a
>   a

That is really scary. What use is "hg stat --rev" then? Not blaming you
for hg, of course.

On that tangent, I just noticed recently that hg has no python api.
Seriously [1]. They even tell us not to use the internal python api.
msysgit has been lacking support for newer hg, and you've had to add
support for older versions (hg 1.9 will be around on quite some
stable/LTS/EL distro releases) after developing on newer/current ones.
I'm wondering how well that scales in the long term (telling from
git-svn experience: it does not scale well), or whether using some
stable api like 'hgapi' would be a huge bottleneck.

Cheers,
Michael

[1] http://mercurial.selenic.com/wiki/MercurialApi

Really funny to see they recommend the command line as api ;)
