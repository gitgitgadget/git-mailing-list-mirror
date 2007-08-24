From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: name-rev does not show the shortest path
Date: Fri, 24 Aug 2007 16:21:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk>
References: <20070823103817.GF6573@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk>
 <20070824125230.GA12030@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1330084439-1187968906=:7313"
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 17:22:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOaze-00029x-0O
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 17:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757169AbXHXPVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757139AbXHXPVu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 11:21:50 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58163 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757063AbXHXPVs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 11:21:48 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4AAE9C6921
	for <git@vger.kernel.org>; Fri, 24 Aug 2007 16:21:47 +0100 (BST)
Received: (qmail 2583 invoked by uid 103); 24 Aug 2007 16:21:46 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/4047. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.03161 secs); 24 Aug 2007 15:21:46 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 24 Aug 2007 16:21:46 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070824125230.GA12030@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56576>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1330084439-1187968906=:7313
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 24 Aug 2007, Uwe Kleine-K=F6nig wrote:

> Hello Julian,
>
> Julian Phillips wrote:
>> On Thu, 23 Aug 2007, Uwe Kleine-K=F6nig wrote:
>>> I want to check to which kernel version I need to upgrade to get a
>>> certain feature.  For my case it was introduced in 0567a0c022d5b.
>>>
>>> =09zeisberg@cassiopeia:~/gsrc/linux-2.6$
>>> =09rev=3D0567a0c022d5b343370a343121f38fd89925de55
>>>
>>> =09zeisberg@cassiopeia:~/gsrc/linux-2.6$ git name-rev --tags $rev
>>> =090567a0c022d5b343370a343121f38fd89925de55 tags/v2.6.22~1686^2~1^3~5
>>>
>>> =09zeisberg@cassiopeia:~/gsrc/linux-2.6$ git name-rev --refs=3D*-rc1 $r=
ev
>>> =090567a0c022d5b343370a343121f38fd89925de55
>>> =09tags/v2.6.22-rc1~1009^2~1^3~5
>>>
>>> I don't now the underlaying algorithm, maybe it's to get a short string=
?
>>>
>>> Anyhow I want to know the earliest tag that includes this patch?  Is
>>> there something I missed?
>>>
>>> I remember there was a similar discussion regarding describe.
>>
>> git describe --contains 0567a0c022d5b
>>
>> probably a 1.5.3 feature? (certainly doesn't exist in 1.5.2.2)
> That command says v2.6.22~1686^2~1^3~5, too.  That is, it doesn't use
> the "older" v2.6.22-rc1 tag as a basis.

From=20a quick look at the code, that's not surprising, it runs "git=20
name-rev --name-only --tags" under the bonnet - so not helpful at all,=20
sorry.

So now I wonder how useful --contains really is ... I would have expected=
=20
to always get the "closest" tag.  ~1009^2~1^3~5 seems closer than=20
~1686^2~1^3~5 to me ... ho hum.

--=20
Julian

  ---
And that's the way it is...
 =09=09-- Walter Cronkite
---1463811584-1330084439-1187968906=:7313--
