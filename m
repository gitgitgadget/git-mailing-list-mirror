From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 19:18:26 +0530
Message-ID: <5284D4AA.2030204@gmail.com>
References: <20130601050355.GA23408@sigill.intra.peff.net> <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com> <20130601090934.GA13904@sigill.intra.peff.net> <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com> <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com> <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com> <528416EA.1070307@gmail.com> <87bo1nmn6w.fsf@linux-k42r.v.cablecom.net> <20131114080735.GB16327@sigill.intra.peff.net> <5284AC6E.4030208@gmail.com> <20131114110937.GA11597@sigill.intra.peff.net> <66513F31-CF2E-4327-AEA3-20176C14EEE1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Luca Milanesio <luca.milanesio@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 14 14:48:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgxHg-00047h-N5
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 14:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab3KNNsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 08:48:33 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49001 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab3KNNsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 08:48:32 -0500
Received: by mail-pd0-f182.google.com with SMTP id y13so2016429pdi.27
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=m2ucUd70U7S3UOIlqHu7HlEc9zRv36wJ/TjoJc3zP9I=;
        b=K/HGRhO75ApU4Ol2h0aAPtCoJGGMjZ6CJ5qDHh2q4kLudZaac5RGi3rOfSWU9uz+5Q
         uFbB+X/HkW/dTO4CvrEt85JA6ibV2uH/b6trkD8VvQKTP4kST4KNsMwiieReCxkaLR8u
         JdoajQTBRwYm8H0kwY/bd7VouYq7x7HRUQOG4/uTc2/I4OXGhnCcwdNO3mtGk5uA/iTD
         F0twM1JxrwiCbJ/7BDE0vRogzd44Txt69zi7QHgLlsMEeWcUxh5yW/kZ2VL+1RVKLSU9
         7JdhDov2qhWmL2C8mTJQM1cW1jZoXGZljTKkYSTFhML5vj6J1zteobmmkhNYYRtfBfsV
         MJjg==
X-Received: by 10.66.191.162 with SMTP id gz2mr1423601pac.151.1384436911443;
        Thu, 14 Nov 2013 05:48:31 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.164.152])
        by mx.google.com with ESMTPSA id gg10sm51675866pbc.46.2013.11.14.05.48.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 05:48:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <66513F31-CF2E-4327-AEA3-20176C14EEE1@gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237849>

On 11/14/2013 04:47 PM, Luca Milanesio wrote:
> Would be really useful anyway to have the ability to create a
> server-side reference based on a SHA-1, using the Git protocol.
> Alternatively, just fetching a remote repo based on a SHA-1 (not
> referenced by any ref-spec but still existent) so that you can create
> a new reference locally and push.

That's a security issue.

Just to clarify, what I am asking for is the ability to recover on the
server, where you have access to the actual files that comprise the
repo.

sitaram

> 
> Luca.
> 
> On 14 Nov 2013, at 11:09, Jeff King <peff@peff.net> wrote:
> 
>> On Thu, Nov 14, 2013 at 04:26:46PM +0530, Sitaram Chamarty wrote:
>>
>>>> I do not know about any particular debate in git circles, but I assume
>>>> Sitaram is referring to this incident:
>>>>
>>>>  https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/t4nkXONp8qgJ
>>>>
>>>> in which a Jenkins dev force-pushed and rewound history on 150 different
>>>> repos. In this case the reflog made rollback easy, but if he had pushed
>>>> a deletion, it would be harder.
>>>
>>> I don't know if they had a reflog on the server side; they used
>>> client-side reflogs if I understood correctly.
>>>
>>> I'm talking about server side (bare repo), assuming the site has
>>> core.logAllRefUpdates set.
>>
>> Yes, they did have server-side reflogs (the pushes were to GitHub, and
>> we reflog everything). Client-side reflogs would not be sufficient, as
>> the client who pushed does not record the history he just rewound (he
>> _might_ have it at refs/remotes/origin/master@{1}, but if somebody
>> pushed since his last fetch, then he doesn't).
>>
>> The "simplest" way to recover is to just have everyone push again
>> (without --force). The history will just silently fast-forward to
>> whoever has the most recent tip. The downside is that you have to wait
>> for that person to actually push. :)
>>
>> I think they started with that, and then eventually GitHub support got
>> wind of it and pulled the last value for each repo out of the
>> server-side reflog for them.
>>
>> -Peff
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
