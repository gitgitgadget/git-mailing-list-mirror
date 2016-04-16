From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Parallel checkout (Was Re: 0 bot for Git)
Date: Sat, 16 Apr 2016 07:17:03 +0200
Message-ID: <5711CACF.9060204@alum.mit.edu>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
 <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
 <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
 <20160415095139.GA3985@lanh>
 <CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+N2x9UBYxA@mail.gmail.com>
 <20160415165208.GA17928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 07:24:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arIiQ-0008OQ-7w
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 07:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbcDPFYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 01:24:13 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57944 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750802AbcDPFYM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2016 01:24:12 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Apr 2016 01:24:11 EDT
X-AuditID: 12074412-52fff700000009f7-58-5711cad2e0bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 13.D5.02551.2DAC1175; Sat, 16 Apr 2016 01:17:06 -0400 (EDT)
Received: from [192.168.69.130] (p508EAC03.dip0.t-ipconnect.de [80.142.172.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3G5H4Jq011068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 16 Apr 2016 01:17:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <20160415165208.GA17928@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqHvplGC4wYGfZha3Z7YwW3Rd6Way
	6J7yltHiR0sPs8Xmze0sDqweO2fdZfdYsKnU41nvHkaPz5vkAliiuG2SEkvKgjPT8/TtErgz
	nq7dxVjQyV2x4tEatgbGzxxdjJwcEgImEs8nzmPuYuTiEBLYyijxr+UJI4Rzjkli4ZNr7CBV
	wgJmEqfmTAKzRQR8JK4v+scEUdTMIrF7zh8mkASzQI1EU88RFhCbTUBXYlFPM1icV0Bb4se8
	xawgNouAqsSrk61gcVGBEIlt676xQtQISpyc+QSol4ODU8Ba4u8DRoiR6hJ/5l1ihrDlJba/
	ncM8gZF/FpKOWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMj
	JISFdjCuPyl3iFGAg1GJhzdjm2C4EGtiWXFl7iFGSQ4mJVHezgKgEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHepKNAOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCV4u
	YKwKCRalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxINiMr4YGJUgKR6gvV9PguwtLkjM
	BYpCtJ5i1OU4sv/eWiYhlrz8vFQpcV4OkB0CIEUZpXlwK2AJ6xWjONDHwrxuIFU8wGQHN+kV
	0BImoCVl73hBlpQkIqSkGhhljrzaeHfmab3mw0ntaUqPjWL0gl9kfbPpaRZv2vPpDf9+w7B/
	T+bysQgKz/3s77dhBn+t9M8FedWvi/+qBbW9aDmp/KKyI8GmddfLsIL+s81r5R6V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291715>

On 04/15/2016 06:52 PM, Jeff King wrote:
> On Fri, Apr 15, 2016 at 01:18:46PM +0200, Christian Couder wrote:
> 
>> On Fri, Apr 15, 2016 at 11:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Fri, Apr 15, 2016 at 12:04:49AM +0200, Christian Couder wrote:
>>>>
>>>> There is a draft of an article about the first part of the Contributor
>>>> Summit in the draft of the next Git Rev News edition:
>>>>
>>>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-14.md
>>>
>>> Thanks. I read the sentence "This made people mention potential
>>> problems with parallelizing git checkout" and wondered what these
>>> problems were.
>>
>> It may have been Michael or Peff (CC'ed) saying that it could break
>> some builds as the timestamps on the files might not always be ordered
>> in the same way.
> 
> I don't think it was me. I'm also not sure how it would break a build.
> Git does not promise a particular timing or order for updating files as
> it is. So if we are checking out two files "a" and "b", and your build
> process depends on the timestamp between them, I think all bets are
> already off.

I'm hazy on this, but I think somebody at Git Merge pointed out that
parallel checkouts (within a single repository) could be tricky if
multiple Git filenames are mapped to the same file due to filesystem
case-insensitivity or encoding normalization.

Michael
