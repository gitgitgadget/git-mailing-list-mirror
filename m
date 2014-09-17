From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series
 overview)
Date: Wed, 17 Sep 2014 15:23:05 +0200
Message-ID: <54198B39.8020405@alum.mit.edu>
References: <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com> <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com> <20140820231723.GF20185@google.com> <20140911030318.GD18279@google.com> <xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com> <20140912004717.GY18279@google.com> <xmqqsijwaclo.fsf@gitster.dls.corp.google.com> <20140912191812.GZ18279@google.com> <xmqqk358a9yz.fsf@gitster.dls.corp.google.com> <54136B10.4050001@alum.mit.edu> <20140912235745.GB18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 15:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUFCV-0004Om-8A
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 15:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbaIQNXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 09:23:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51658 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754957AbaIQNXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2014 09:23:09 -0400
X-AuditID: 1207440c-f79036d000005e77-35-54198b3c347c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id EE.C5.24183.C3B89145; Wed, 17 Sep 2014 09:23:08 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C15.dip0.t-ipconnect.de [93.219.28.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8HDN6e6014540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 17 Sep 2014 09:23:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140912235745.GB18279@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqGvTLRliMGuxpkXXlW4mi4beK8wW
	b28uYbT4N6HGgcVj56y77B4LNpV6XLyk7PF5k1wASxS3TVJiSVlwZnqevl0Cd8b0bzuZCr6y
	V1zf28vWwLicrYuRk0NCwESi9+stJghbTOLCvfVAcS4OIYHLjBKTDrUyQTjnmCR+PbjDCFLF
	K6AtceHWXrAOFgFViUWnTrGC2GwCuhKLeprB4qICARIfOh9A1QtKnJz5hAXEFhHQkHj+6RvY
	BmaBZkaJk/fmgjUIC0RJPN3wkAVi2zdmiSMzmsE6OAUMJE5fmQVmMwvoSey4/osVwpaXaN46
	m3kCo8AsJEtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQ
	gObZwfhtncwhRgEORiUe3g2XJUKEWBPLiitzDzFKcjApifJa1EiGCPEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLhfd8OlONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfC+
	6QRqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFa3wxMGJBUjxAe3u7QPYWFyTm
	AkUhWk8x6nKs6/zWzyTEkpeflyolznsWZIcASFFGaR7cClj6esUoDvSxMG8+yCgeYOqDm/QK
	aAkT0JKzPWIgS0oSEVJSDYw6lhsF2b1Lfy+8sUZbu0fv5qqXM/r33C+7HLnNK4PhxOxWpiqz
	S08N3vFuzv8anuCbvmDzzDk7v7Adid6w/qXkf+d044/er04FrFh/lZHl1t/NFVuC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257222>

On 09/13/2014 01:57 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>>>> so I'll send a reroll of the series as-is in an hour or so.
>>
>> Jonathan: Is a current version of this patch series set up for review in
>> Gerrit?
> 
> Yes.
> (https://code-review.googlesource.com/#/q/project:git+topic:ref-transaction)

I just worked through the patch series, leaving lots of comments in
Gerrit. Overall it looks pretty good and makes a lot of very worthwhile
progress. The only patch that gives me a bit of heartburn is

    [PATCH 15/19] refs.c: fix handling of badly named refs

not because it is necessarily wrong, but because it has a lot of
non-local effects that are hard to evaluate. I made a bunch of comments
in Gerrit about that patch, too, and will wait for a response before
having another go at it.

Thanks for all your hard and detailed work, Ronnie and Jonathan!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
