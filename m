From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCH] tests: make all test files executable
Date: Sun, 04 Oct 2009 21:25:27 -0400
Message-ID: <4AC94B07.4000803@mailservices.uwaterloo.ca>
References: <4AC55E78.7010109@mailservices.uwaterloo.ca> <20091002080134.GD27664@coredump.intra.peff.net> <20091002083946.GA8627@coredump.intra.peff.net> <1762B430-2DC0-48F5-8C34-8428F9145A1E@mailservices.uwaterloo.ca> <20091004134022.GA14209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060405040503020900090605"
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 03:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MucOI-0002Uu-RI
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 03:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170AbZJEB0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 21:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758040AbZJEB0Q
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 21:26:16 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:34632 "EHLO
	mailchk-m02.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755161AbZJEB0Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Oct 2009 21:26:16 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m02.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n951PQSh009329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Oct 2009 21:25:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
In-Reply-To: <20091004134022.GA14209@sigill.intra.peff.net>
X-UUID: 778b1cf5-48e6-4524-9f9d-e6b82b2dd117
X-Miltered: at mailchk-m02 with ID 4AC94B06.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m02
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m02.uwaterloo.ca [129.97.128.141]); Sun, 04 Oct 2009 21:25:33 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129522>

This is a multi-part message in MIME format.
--------------060405040503020900090605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09-10-04 9:40 AM, Jeff King wrote:
> On Sun, Oct 04, 2009 at 09:18:20AM -0400, Mark Rada wrote:
> 
>>> Ah, nevermind. The problem is that your patch was word-wrapped, making
>>> the second "diff --git" line bogus. It would have been nice to have it
>>> print a warning instead of silently ignoring that bit of the patch.
>>>
>> I didn't have format=flowed buggering things up this time, so I don't
>> quite understand the problem; could you please explain with more
>> details?
> 
> Sure. The patch is perfect except for one line. What should have been:
> 
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> 
> was wrapped to:
> 
> diff --git a/t/t9501-gitweb-standalone-http-status.sh
> b/t/t9501-gitweb-standalone-http-status.sh
> 
> I have no idea how you did that, though. :)
> 
> It looks like you send with Thunderbird. How do you get the diff content
> into the email? Is it possible that it wraps the content after you have
> gotten it there?

I don't think so, I have plug-in that disables wrapping and has worked
just fine for the last couple of patches I sent, so I'm not sure what
was going on there.

>> When I try to apply the patch from a saved copy of the e-mail, I get
>> the following error:
>>
>> 	# git am ~/Downloads/\[PATCH\]\ tests_\ make\ all\ test\ files\
>> executable.eml
>> 	Patch format detection failed.
>> 	zsh: exit 1     git am
>>
>> The difference between the patch created by format-patch and the saved
>> e-mail is just some e-mail header information. Is that a different error
>> than what you were getting? I'm not sure what I'm doing wrong here, help
>> would be appreciated.
> 
> Yeah, that's totally different than the problem I was having. I save to
> an mbox from mutt, which "git am" understands just fine. I'd have to see
> what was in your .eml file to know why "git am" couldn't figure it out
> (and it might be a good test case, as "git am" has recently learned to
> accept more mailbox formats).

I've attached a copy of the .eml file.


-- 
Mark Rada (ferrous26)
marada@uwaterloo.ca

--------------060405040503020900090605
Content-Type: message/rfc822;
 name="[PATCH] tests_ make all test files executable.eml"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="[PATCH] tests_ make all test files executable.eml"

Subject: 

From:
Mark Rada <marada@mailservices.uwaterloo.ca>
Date:
Thu, 01 Oct 2009 21:59:20 -0400
To:
Junio C Hamano <gitster@pobox.com>
CC:
git@vger.kernel.org

Rm9yIGNvbnNpc3RlbmN5IHdpdGggdGhlIHJlc3Qgb2YgdGhlIHRlc3QgZmlsZXMuCgpTaWdu
ZWQtb2ZmLWJ5OiBNYXJrIFJhZGEgPG1hcmFkYUB1d2F0ZXJsb28uY2E+Ci0tLQoKT24gMjAw
OS0xMC0wMSwgYXQgNDoxMyBBTSwgSmFrdWIgTmFyZWJza2kgd3JvdGU6Cj4+ID4+IGRpZmYg
LS1naXQgYS90L3Q5NTAxLWdpdHdlYi1zdGFuZGFsb25lLWh0dHAtc3RhdHVzLnNoIGIvdC90
OTUwMS1naXR3ZWItc3RhbmRhbG9uZS1odHRwLXN0YXR1cy5zaAo+PiA+PiBpbmRleCBkMGZm
MjFkLi4wNjg4YTU3IDEwMDY0NAo+PiA+PiAtLS0gYS90L3Q5NTAxLWdpdHdlYi1zdGFuZGFs
b25lLWh0dHAtc3RhdHVzLnNoCj4+ID4+ICsrKyBiL3QvdDk1MDEtZ2l0d2ViLXN0YW5kYWxv
bmUtaHR0cC1zdGF0dXMuc2gKPiA+IAo+ID4gQlRXLiB0aGUgcmVzdCBvZiB0ZXN0IHNjcmlw
dHMgYXJlIGV4ZWN1dGFibGUsIGJ1dCBub3QgdGhpcyBvbmU/IFdoeT8KPiA+IChCdXQgY29y
cmVjdGluZyB0aGlzIHNob3VsZCBiZSBkb25lLCBpZiBuZWVkZWQsIGluIHNlcGFyYXRlIGNv
bW1pdCkuCgpJIG5vdGljZWQgb25lIG90aGVyIHRlc3Qgc2NyaXB0IHRoYXQgd2FzIG5vdCBz
ZXQgdG8gYmUgZXhlY3V0YWJsZS4KCgogMCBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pCiBtb2RlIGNoYW5nZSAxMDA2NDQgPT4gMTAwNzU1IHQvdDU1
MzEtZGVlcC1zdWJtb2R1bGUtcHVzaC5zaAogbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+IDEwMDc1
NSB0L3Q5NTAxLWdpdHdlYi1zdGFuZGFsb25lLWh0dHAtc3RhdHVzLnNoCgpkaWZmIC0tZ2l0
IGEvdC90NTUzMS1kZWVwLXN1Ym1vZHVsZS1wdXNoLnNoIGIvdC90NTUzMS1kZWVwLXN1Ym1v
ZHVsZS1wdXNoLnNoCm9sZCBtb2RlIDEwMDY0NApuZXcgbW9kZSAxMDA3NTUKZGlmZiAtLWdp
dCBhL3QvdDk1MDEtZ2l0d2ViLXN0YW5kYWxvbmUtaHR0cC1zdGF0dXMuc2gKYi90L3Q5NTAx
LWdpdHdlYi1zdGFuZGFsb25lLWh0dHAtc3RhdHVzLnNoCm9sZCBtb2RlIDEwMDY0NApuZXcg
bW9kZSAxMDA3NTUKLS0gMS42LjUucmMyIA==
--------------060405040503020900090605--
