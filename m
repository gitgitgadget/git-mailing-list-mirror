From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 16:26:46 +0530
Message-ID: <5284AC6E.4030208@gmail.com>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com> <51A963B7.6060002@alum.mit.edu> <20130601050355.GA23408@sigill.intra.peff.net> <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com> <20130601090934.GA13904@sigill.intra.peff.net> <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com> <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com> <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com> <528416EA.1070307@gmail.com> <87bo1nmn6w.fsf@linux-k42r.v.cablecom.net> <20131114080735.GB16327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 14 11:57:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgubZ-0002uv-Rl
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 11:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab3KNK4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 05:56:54 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52865 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3KNK4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 05:56:52 -0500
Received: by mail-pa0-f49.google.com with SMTP id lf10so1911040pab.36
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 02:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=15TL8TxHEwcJRPnRvbQ81nvZbay/ieryaTtQVpDDv8k=;
        b=gOLJFB0VG5FX3H94oWNPTnN8mVE+mpnB772ech8EX23BznBeNfqYkZNj/rqBRB1XOM
         k9eis82BErNNOLbsZyM0ZBDHwsazpMfabFIuZO6UEyw1/MOdr9H/tCH2JfD6L5srHfJ7
         K8/tSBi/s/2HrEXMp5Ky8JIpX2S1suwv8u4VORa2EMIB7bG9We7o0x1tp0zIap2lHs1B
         OFP4+NmwP52474X/XnQvlhzN72YeNRPVfT/X2T3tteVmaUYBBl0cN34DTjiyyck/pjh3
         i7zCu5OZLtig0QhT3Y9NrI7WWOYxcRSSmxbMkR0Qv/jwGbjuT5zgsjpX+fM8uojd5nZA
         0l3w==
X-Received: by 10.68.160.69 with SMTP id xi5mr782305pbb.168.1384426612016;
        Thu, 14 Nov 2013 02:56:52 -0800 (PST)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id ry3sm23548283pbc.8.2013.11.14.02.56.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 02:56:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131114080735.GB16327@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237821>

On 11/14/2013 01:37 PM, Jeff King wrote:
> On Thu, Nov 14, 2013 at 08:56:07AM +0100, Thomas Rast wrote:
> 
>>> Whatever it was that happened to a hundred or more repos on the Jenkins
>>> project seems to be stirring up this debate in some circles.
>>
>> Making us so curious ... and then you just leave us hanging there ;-)

Oh my apologies; I missed the URL!!  (But Peff supplied it before I saw
this email!)

>> Any pointers to this debate?
> 
> I do not know about any particular debate in git circles, but I assume
> Sitaram is referring to this incident:
> 
>   https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/t4nkXONp8qgJ
> 
> in which a Jenkins dev force-pushed and rewound history on 150 different
> repos. In this case the reflog made rollback easy, but if he had pushed
> a deletion, it would be harder.

I don't know if they had a reflog on the server side; they used
client-side reflogs if I understood correctly.

I'm talking about server side (bare repo), assuming the site has
core.logAllRefUpdates set.

And I'll explain the "some circles" part as "something on LinkedIn".  To
be honest there's been a fair bit of FUDding by CVCS types there so I
stopped looking at the posts, but I get the subject lines by email and I
saw one that said "Git History Protection - if we needed proof..." or
something like that.

I admit I didn't check to see if a debate actually followed that post
:-)
