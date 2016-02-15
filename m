From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Feb 2016, #04; Fri, 12)
Date: Mon, 15 Feb 2016 18:44:44 +0100
Message-ID: <56C20E8C.30708@web.de>
References: <xmqqfuwxtrni.fsf@gitster.mtv.corp.google.com>
 <56C07182.1040804@web.de> <xmqqy4amr2z4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 18:45:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNCq-0002Tl-5R
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbcBORo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 12:44:59 -0500
Received: from mout.web.de ([212.227.15.14]:65033 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742AbcBORo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 12:44:57 -0500
Received: from [172.29.0.69] ([89.1.31.133]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MKrC4-1aVNCc1ZlQ-0001Au; Mon, 15 Feb 2016 18:44:51
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <xmqqy4amr2z4.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:wJf2myHLn62O+8MqTo2aanDpHnXCq85nRWP/hOVwWCLsdRWH+zi
 bODDfw9RFgsVGp/o6HfiP0sfR0HQX53cVAdcbZgaMh7NJpChR/iMfPYDxqOcagp0iLZEpM6
 qp8Lo71CX3krpEwwwzrY7DlsOJf0B99sO/nUJOaIEBJnU0NBgeFQLTeMsrHwAAvK5gGz4io
 YOAlDwFloZ9EfAwGSe18g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aqaUN8X3Or4=:pdxfOe/FY7pxz4dnSu4CwI
 z0b+a6OmvL0AicNVFBjpVvrMekDnElDxI72DY4BeuWKPg2vYMOwmOO6nQhuKIbXprUJCxrMfz
 /Ggvsg+kBDVg2+zfhL9+JGqF9n95s6vcQS1QH/UMV4K21xcCKpCHjw9+fNYLsxfn3ce29DQiV
 SUZSBwH8kxnKipgrpttT81czriSQEISvZujK5R04LAxtwYiZVrewfXL4K/w/3iBELdTBPh9lz
 q6ilIQbMwJF7NgFP5uiCVsz9oS0dBRnBHTaAxotvzwKhEOaDly5CtKKmJFfOjKml25GfuWYv7
 5PszXUIC1lsU10kDd42QYNZ+sShHCZ8UjAAvxGmifvJ+TnkRIJ3BktGW/X8WkVK3wNf/QFSG/
 3AQ7Lim+SDOfr2KcaizZmp34O8yKPQMlyGxi2OYwZcVGhvOG/iL41O9e045ZHyTp7OAfkiLla
 bJE4an1jHm923GprG/Ou+ferbWKMQOxGOR2iBAWC0xPQXDfO/b+o/b7JTRPuHrSmS7YoHgIRc
 kqWJNUbdYxb8NGGpLq4ef66OVufxlYSdRlWZHwDErWk6oRQUO+SoY6qjTqjg0jyP1pf1/9nzA
 7mj5/qrQzKWLeBigTvj1pQj+BC/GXccleMvcNAr95aWZe6aRxDZRZsoyp2l73CNcO15Oi19c9
 Git+vj10hMUYJnRAe9PVolk4bKtmaQZNSX2Vp/pDYH2yZdaN9i6/W1NmhHdFpL2AOtTsWcwNp
 JyCDc8me5WDFC3HSwDFD06XKVyf9UmynyOpzZFfxAisv/Uo058yRwYoMg+gfosU5M6oJPTLE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286219>



On 15/02/16 05:50, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>>> * tb/conversion (2016-02-10) 6 commits
>>>    (merged to 'next' on 2016-02-12 at 6faf27b)
>> Could we keep it in next for a while ?
>>
>> I found issues that needs to be fixed before going to master,
>> updates follow soonish.
> Hmph, I somehow thought that everything was a no-op clean-up.  Any
> regressions I failed to spot?
The "text" attribute was reported incorrectly in ls-files --eol.
A preleminary fix is here:
<https://github.com/tboegi/git/commit/3a5f50005c0cfa16d2aaa6c602b6105b6=
11a8ed5>
A proper fix will come next week.
