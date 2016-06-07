From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/13] Reference iterators
Date: Tue, 7 Jun 2016 13:58:19 +0200
Message-ID: <5756B6DB.4050301@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
 <xmqqporyneik.fsf@gitster.mtv.corp.google.com>
 <5751FCBF.3070507@alum.mit.edu>
 <xmqq4m99265o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:58:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFeT-00029Z-7V
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbcFGL61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:58:27 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63609 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754331AbcFGL6Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 07:58:25 -0400
X-AuditID: 1207440c-c53ff70000000b85-a2-5756b6dfa145
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id FE.40.02949.FD6B6575; Tue,  7 Jun 2016 07:58:23 -0400 (EDT)
Received: from [192.168.69.130] (p548D6137.dip0.t-ipconnect.de [84.141.97.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u57BwKss014964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 7 Jun 2016 07:58:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqq4m99265o.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqHt/W1i4waXZ2hbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MFjOvWlucedPI6MDusXPWXXaPZ717GD0uXlL22L90G5vH4gdeHgue
	32f3+LxJLoA9itsmKbGkLDgzPU/fLoE7o3PxLdaChZwVbx98Z2pg3MLexcjBISFgIvH1rlgX
	IyeHkMBWRolPP9m6GLmA7LNMEs8W/2MBSQgLGEpsvrKUCcQWEVCTmNh2iAWiaDejxMXzXYwg
	DrPALCaJjq0XGUGq2AR0JRb1NIN18ApoS+xbtggsziKgInHn8Bt2EFtUIETi/LqtrBA1ghIn
	Zz4B28YpYC1xbXM7WC+zgJ7Ejuu/WCFseYntb+cwT2Dkn4WkZRaSsllIyhYwMq9ilEvMKc3V
	zU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3ECAl4nh2M39bJHGIU4GBU4uEV+B4aLsSaWFZc
	mXuIUZKDSUmU96F3WLgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6EtUA53pTEyqrUonyYlDQH
	i5I4r+oSdT8hgfTEktTs1NSC1CKYrAwHh5IE79qtQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWp
	eSmpRYmlJRnxoJiMLwZGJUiKB2gvyzaQvcUFiblAUYjWU4yKUuK8jCBzBUASGaV5cGNhaewV
	ozjQl8K8EiDtPMAUCNf9CmgwE9DgZdeCQQaXJCKkpBoYGR+dUT4U46QctnNi183VJ9s3BxWm
	dv9VZtuneeRJUrov83OnSZe8Hy6Nd57ZJe5jerDMKb0sj+9Q178Yg0dXzLTbqhy/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296666>

On 06/04/2016 01:40 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 06/03/2016 11:33 PM, Junio C Hamano wrote:
>>> [...]
>>> Ah, that reminds me.  What's the doneness of the dependent topic?
>> [...]
> 
> What I meant was the doneness of mh/split-under-lock actually.

I don't know of any open issues or unaddressed feedback in
split-under-lock. I've gone over the code many times myself and am
pretty confident about it.

I just reviewed the series again, and one thing that I wasn't so happy
about was that it makes many changes to the ref transaction
error-handling code, but that code is not very well tested (and the
content of the error messages is not really tested at all). So I just
submitted another patch series to add more tests in this area [1]. Those
tests turned up a couple of cosmetic problems but nothing serious.

So as far as I know, this series is ready to go. But it is a big and
rather intricate change to an important area of the code, so I hope it
can get merged early in the next release cycle to get wider testing.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/296626
