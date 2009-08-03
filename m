From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Mon, 03 Aug 2009 15:56:50 -0700
Message-ID: <4A776B32.4070509@zytor.com>
References: <4A7735B0.2040703@zytor.com> <7vocqw8u0x.fsf@alter.siamese.dyndns.org> <200908031556.35634.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY6Sr-0005MR-HT
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 00:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbZHCW47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 18:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753518AbZHCW46
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 18:56:58 -0400
Received: from terminus.zytor.com ([198.137.202.10]:55761 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbZHCW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 18:56:58 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n73MupGM017673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 3 Aug 2009 15:56:54 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
In-Reply-To: <200908031556.35634.wjl@icecavern.net>
X-Virus-Scanned: ClamAV 0.94.2/9648/Mon Aug  3 06:27:08 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124734>

On 08/03/2009 02:56 PM, Wesley J. Landaker wrote:
> On Monday 03 August 2009 15:30:38 Junio C Hamano wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>> In a serious case of craniorectal immersion, the Thunderbird developers
>>> have started using \r\n line endings on saved emails:
>>>
>>> https://bugzilla.mozilla.org/show_bug.cgi?id=503271
>>> https://bugzilla.mozilla.org/show_bug.cgi?id=507530
>>>
>>> It would be nice if git-am could handle this case automatically.
>> Perhaps
>>
>>     $ dos2unix *.eml | git am
> 
> I didn't try it, but would "git am" with "apply.whitespace" and 
> "core.whitespace" set in some reasonable manner help? Not "automatic", but 
> may help if dos2unix isn't available for some reason.

It works, but it's extremely noisy.

	-hpa
