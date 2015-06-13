From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Sat, 13 Jun 2015 10:45:29 +0200
Message-ID: <557BEDA9.30809@alum.mit.edu>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net> <xmqq381zi3ev.fsf@gitster.dls.corp.google.com> <20150610235114.GA786544@vauxhall.crustytoothpaste.net> <20150611000251.GB786544@vauxhall.crustytoothpaste.net> <xmqqpp53gkmq.fsf@gitster.dls.corp.google.com> <xmqq4mmef22j.fsf@gitster.dls.corp.google.com> <20150612203054.GA29305@vauxhall.crustytoothpaste.net> <xmqqvbesbmm6.fsf@gitster.dls.corp.google.com> <20150612222713.GD29305@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGg=?= =?UTF-8?B?w6FpIE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 10:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3h4c-00058n-Op
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 10:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbbFMIpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 04:45:50 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49595 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750853AbbFMIpg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 04:45:36 -0400
X-AuditID: 1207440e-f79fc6d000000caf-66-557bedacbda3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.E6.03247.CADEB755; Sat, 13 Jun 2015 04:45:32 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5D8jUOM011789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 04:45:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150612222713.GD29305@vauxhall.crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqLvmbXWowcwdmhZdV7qZLBp6rzBb
	dE95y2jxo6WH2aJt5g8mB1aP5Tf/MnnsnHWX3eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M54u30uS8ERnoopO2ezNDB2cXUxcnJICJhI/LnewAZhi0lcuLcezBYSuMwo8bojtYuR
	C8g+zyTx7c8NsASvgKbEoZ/zmEFsFgFViX+vT7OA2GwCuhKLepqZuhg5OEQFgiRev8yFKBeU
	ODnzCQvIHBGBn4wSK05+YwJJCAPNubmqjQliwXNmiZeXFrKCJDgFnCUWfbnPDjKIWUBdYv08
	IZAws4C8xPa3c5gnMPLPQjJ3FkLVLCRVCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvl
	ZpbopaaUbmKEBDLfDsb29TKHGAU4GJV4eDNiq0OFWBPLiitzDzFKcjApifJG7gEK8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuH17gbK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbB
	ZGU4OJQkeIWBESskWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rH+GJgRIKkeID2
	uoC08xYXJOYCRSFaTzEqSonzPn0DlBAASWSU5sGNhaWnV4ziQF8K834EqeIBpja47ldAg5mA
	Brf3VIEMLklESEk1MC52DJdua979e+00Gbklqe2apzR+rPj1bYvL2S8zXzzZn5cZMyH42K/M
	b3VyqkX2XZs2HjHjvn4juti9VPXTy+nNauaxElnzNdjOH19xNu3P4vbzJpbNE1u+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271544>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/13/2015 12:27 AM, brian m. carlson wrote:
> On Fri, Jun 12, 2015 at 03:14:25PM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>>> While I did run the tests between each commit, I hadn't noticed
>>> they were failing because I don't have Apache installed on my
>>> laptop, so they were silently skipped.  I'll resubmit with that
>>> fixed.
>> 
>> It is somewhat strange that _only_ http part had failures like
>> this, and is unnerving, too, given that a few people seem to have
>> given at least a cursory read over the patches and didn't spot
>> anything obviously wrong.
>> 
>> Was that because there was a single manual botch, or was that
>> merely that other parts of the system do not have sufficient test
>> coverage?
> 
> It appears that I broke the change in "parse_fetch: convert to use 
> struct object_id" which modifies remote-curl.c, so I think it's a
> single manual botch.  I'm going to rework that patch anyway since
> Michael said that he didn't like the idea of parse_oid_hex as it
> stands, so it will end up being mostly moot.

In the same email where I made those design suggestions, I also I
pointed out a bug in the implementation of parse_oid_hex(). Maybe that
is the reason for the test failures.

Michael

- -- 
Michael Haggerty
mhagger@alum.mit.edu


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlV77aYACgkQwg9mrRwfmAnCyQCeIp9aSOTtQ1ABpiSybcFQFP87
fNwAoLNhQtyFQ2/fqQIvzl1gGEEOlWxa
=gI7/
-----END PGP SIGNATURE-----
