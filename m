From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/8] absolute_path(): reject the empty string
Date: Sun, 09 Sep 2012 06:48:06 +0200
Message-ID: <504C1F86.4060608@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu> <1346971264-23744-4-git-send-email-mhagger@alum.mit.edu> <7vy5kmzr3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 06:48:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZRU-0004cU-0F
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 06:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab2IIEsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 00:48:13 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:65277 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751411Ab2IIEsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 00:48:09 -0400
X-AuditID: 12074411-b7fa36d0000008cc-6a-504c1f889025
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 00.00.02252.88F1C405; Sun,  9 Sep 2012 00:48:08 -0400 (EDT)
Received: from [192.168.69.140] (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q894m6aO025914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 00:48:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vy5kmzr3e.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqNsh7xNg8OiHsUXXlW4mi4beK8wW
	T+beZbZYv6iB1aJ7yltGB1aPnbPusns8fNXF7nHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZ
	3w/8Zy/YzFOx4N9tpgbGh5xdjJwcEgImEttmLmCDsMUkLtxbD2RzcQgJXGaUeLVgDxOEc5pJ
	4v/cGaxdjBwcvALaEqemGYM0sAioStzb1scCYrMJ6Eos6mlmArFFBUIkZlyezAxi8woISpyc
	+QSsRkRATWJi2yEWkJnMAnMZJf5cW88IkhAWcJH4vOAAM8Sy5YwSK67dB+vmFDCTeDr1EFg3
	s4COxLu+B8wQtrzE9rdzmCcwCsxCsmQWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtL
	LdI11cvNLNFLTSndxAgJbsEdjDNOyh1iFOBgVOLhZb7jHSDEmlhWXJl7iFGSg0lJlHeirE+A
	EF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeq+xAOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU
	7NTUgtQimKwMB4eSBG+PHFCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCha44uB
	8QqS4gHaWwzSzltckJgLFIVoPcVozDH75or7jBx3PwJJIZa8/LxUKXHerSClAiClGaV5cItg
	ae0VozjQ38K8S0GqeIApEW7eK6BVTECrRJ55gKwqSURISTUwslyK3ty6YsGeP01yBbuv/v3N
	tdUupGsjm8iDC1vKj8XHdh6S1+TO/Ox2xfK/ysTabelzn+Xuv8hTb3VprczXlPPX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205041>

On 09/07/2012 01:09 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> I think I asked why this matters (iow, why it is the right thing to
> do to reject an empty string, instead of treating it as "the current
> directory") in the previous round.  I would have expected to find
> the answer be above the S-o-b line here.

The reasons that the change is desirable:

1. The empty string is not a legitimate path according to POSIX; e.g.,
see Linux's path_resolution(7):

   Empty pathname
       In the original UNIX, the empty pathname referred to the current
       directory.   Nowadays  POSIX  decrees  that  an  empty  pathname
       must not be resolved successfully.  Linux returns ENOENT in this
       case.

Accordingly, comparable standard functions like realpath(3) reject the
empty string.

2. The functions did not handle the empty path consistently with the way
they handled other paths (namely, the return value contained a trailing
slash).

3. This unusual behavior was undocumented.

The above points let me to the conclusion that the anomalous handling of
the empty string was a bug in the implementation rather than an intended
behavior.  Moreover, a quick check of callers didn't turn up any that
seemed to rely on the strange behavior.

Do you want a re-roll with this verbiage added to the commit messages of
the two relevant commits?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
