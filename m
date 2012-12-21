From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: [RFC/FR] Should "git checkout (-B|-b) branch master...branch"
 work?
Date: Fri, 21 Dec 2012 22:59:44 +0100
Message-ID: <50D4DBD0.7050601@alum.mit.edu>
References: <7v8v8r2y8s.fsf@alter.siamese.dyndns.org> <CANiSa6jP_JN+DpDgYpWA9Aky9REJvFq3aR3Yj0vF3+axWvtmsw@mail.gmail.com> <CANiSa6ibS7ORY=QMS3WQzXYJQQH4ZYvPO75qgLgv-oWGMSBBrw@mail.gmail.com> <7vr4mj1g8j.fsf@alter.siamese.dyndns.org> <50D4BBDC.6030700@alum.mit.edu> <CANiSa6hcDHTpZnAXR3zxdv-H4r-yRjuSx_kgE5V1rSFk_pNhOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:00:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmAdR-0008AY-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 23:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab2LUV7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 16:59:49 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:45617 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752010Ab2LUV7r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 16:59:47 -0500
X-AuditID: 1207440d-b7f306d0000008b7-b2-50d4dbd26370
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 17.94.02231.2DBD4D05; Fri, 21 Dec 2012 16:59:46 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBLLxjHd001190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Dec 2012 16:59:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CANiSa6hcDHTpZnAXR3zxdv-H4r-yRjuSx_kgE5V1rSFk_pNhOA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqHvp9pUAgy3vrSy6rnQzWTT0XmG2
	6PzYxuLA7LFz1l12j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M549fQVU8Fu9or22Y4NjO9Y
	uxg5OSQETCSmzX0CZYtJXLi3nq2LkYtDSOAyo8SJJR+hnONMEufm7gOr4hXQlth49TgziM0i
	oCpx4+QUNhCbTUBXYlFPMxOILSoQILF4yTl2iHpBiZMzn7CA2CICBhK3bt4Cm8MsYC2x4vVh
	oHoODmGBcIlLm11BwkIC55gkvn+1BrE5BQIlulZ1gpUwC6hLrJ8nBNEpL7H97RzmCYwCs5As
	mIVQNQtJ1QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIUHLu4Px/zqZ
	Q4wCHIxKPLxarVcChFgTy4orcw8xSnIwKYnyel0DCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh
	9Z8HlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAm3wJqFCxKTU+t
	SMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFaHwxMEpBUjxAextA2nmLCxJzgaIQracYdTlu
	Ndx8yijEkpeflyolzlsLUiQAUpRRmge3ApaiXjGKA30szLscpIoHmN7gJr0CWsIEtERECWxJ
	SSJCSqqBMSAle1agsenj2YrH09pWiRdVxRz2OviF7dnNrEVbPpr/7J8a+Id94VKTTYqlTgwN
	7CKmOxv52dSFVNbrquq9CAp93SF16ZJFcqrN55na9w7xXcmxrWfa7NjJdtGXqeb8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212015>

On 12/21/2012 10:31 PM, Martin von Zweigbergk wrote:
> On Fri, Dec 21, 2012 at 11:43 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 12/21/2012 06:12 PM, Junio C Hamano wrote:
>>>     side note: incidentally, now we have rev_cmdline_info support,
>>>     we could start deprecating "diff A..B" syntax.
>>
>> I often find myself using "git diff A..B" syntax when using the command
>> line history because the previous command used "A..B"; e.g.,
>>
>>     git log A..B
>>     git diff A..B
> 
> The problem with this, to me, if it wasn't clear, is that "git log
> A..B" shows you is new _since B branched off from A_, while "git diff
> A..B" shows you what has changed _between A and B_.

You are quite right, of course, though in many useful cases they are the
same.  But I guess I should just buck myself up for the new orthodoxy :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
