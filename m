From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 12/23] query_refspecs(): move some constants out of
 the loop
Date: Wed, 30 Oct 2013 18:31:20 +0100
Message-ID: <52714268.5010608@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu> <1383111192-23780-13-git-send-email-mhagger@alum.mit.edu> <CALkWK0m-qNcCe_Zmn6PeN91JEM-7Ki0F0b0Fp+1bhQTWdmR7EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:31:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZcB-0003xL-RT
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab3J3Rb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:31:28 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53806 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630Ab3J3Rb1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 13:31:27 -0400
X-AuditID: 12074412-b7fc96d0000023d5-d7-5271426e6463
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 30.1A.09173.E6241725; Wed, 30 Oct 2013 13:31:26 -0400 (EDT)
Received: from [192.168.69.9] (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9UHVKBk011688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 13:31:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CALkWK0m-qNcCe_Zmn6PeN91JEM-7Ki0F0b0Fp+1bhQTWdmR7EA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3aOZ5/TE6ej5ucSzVnYhdmFiAPFutAfR4ToYv8IYWfu5Ebb
	UXe2aBEhU7vMzSIMdcWwIqEJGXazGDpmdJEk08oSlEBdagWBZoUJnU/z8t/D+zzP++Pj/SDB
	DsZooUVyiHZJsOooDcmq92Xopb2lhzZfmlrPBeuH1Fytp4nkPO+qVFyZ7x3BBQaeqrhgfyPB
	3an7CLiRiy4uMDpKcb8rvMRuDd9zd0zFR/7WqPnoy/MU/8Q/oOZ7xn5RfNQXAvzbnky+ruIr
	yU+0pPHh3iHqgCY/bqdRcJw8bCmSNhmOxZl7/l6gSsJxp6LnakEZaIQeACFitqHOznQPiFXk
	StQ92Ex5gAayTC9AgZEZChss06VCLTfzsKaZjWhi8hGJNcmsRT6fT401xejRTW+5CuskJg/d
	CL5Qz+VXoFf1wyRmJSqZaDAXjwmmmkDRmWysE5gjyN/f+p/bAdDtP5Wze2KZg2jQXR6DuwST
	hZoD7Fw3HT3+fp24DBj/EoJ/MeVfkmoARBCkCVanTW8TLFZZLNTLhYIkiXb99mybxZEtmpwt
	YO4+bCtofpUWAQwEunh6mb70EBsjnJRdtghIgSpdEn12lzJabiw2ucyCbC6wO62iHAEIErpE
	OneP4tEmwXVatBfPW6sgqUum/9zK2s8yRYJDPCGKJaJ93k2FUIfob7i4wi4WiaeOW6yORVsF
	Y/FyjTZRFiWTaBecDnMBvmiBrJwUW/EKt2uWK5cINmU6V+0EehiY/DEFWFIqlkRtMn0Phxgc
	MjulBcT8txwHycqLE+hunIpXPu3CpnEFolIgIVLCEIewaGnLwIkHwSpv9YMLz/Py 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237042>

On 10/30/2013 12:05 PM, Ramkumar Ramachandra wrote:
> Michael Haggerty wrote:
>> diff --git a/remote.c b/remote.c
>> index e42daa8..a5e6c7f 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -825,6 +825,8 @@ static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *q
>>  {
>>         int i;
>>         int find_src = !query->src;
>> +       const char *needle = find_src ? query->dst : query->src;
>> +       char **result = find_src ? &query->src : &query->dst;
>>
>>         if (find_src && !query->dst)
>>                 return error("query_refspecs: need either src or dst");
>> @@ -833,8 +835,6 @@ static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *q
>>                 struct refspec *refspec = &refs[i];
>>                 const char *key = find_src ? refspec->dst : refspec->src;
>>                 const char *value = find_src ? refspec->src : refspec->dst;
>> -               const char *needle = find_src ? query->dst : query->src;
>> -               char **result = find_src ? &query->src : &query->dst;
>>
>>                 if (!refspec->dst)
>>                         continue;
> 
> Why? Is it used in some later patch?

It's just improving the code hygiene in a function that I was reading to
understand the other code affected by the patches.  It's unrelated to
the other patches.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
