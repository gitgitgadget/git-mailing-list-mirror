From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sat, 30 Jan 2010 13:31:18 +0100
Message-ID: <4B642696.2070501@web.de>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com> 	<7vzl3wiz59.fsf@alter.siamese.dyndns.org> <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 13:34:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbCWc-0007Wc-RP
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 13:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab0A3MbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 07:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355Ab0A3MbY
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 07:31:24 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:42164 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab0A3MbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 07:31:23 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id B20B514CDA0AF;
	Sat, 30 Jan 2010 13:31:22 +0100 (CET)
Received: from [80.128.91.77] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NbCTx-0004m6-00; Sat, 30 Jan 2010 13:31:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18ckk6jCIqplUiddg/ohsOsJ0R7jj4ZdXQTlON4
	HSbcBt6ur0F0XbVP/wnpF6Z+qy/2j4Nc2lakbRLObusVXGD/xy
	WeXxL59/GeHxw4u5WTCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138473>

Am 30.01.2010 01:46, schrieb Jonathan del Strother:
> On 29 January 2010 17:44, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan del Strother <maillist@steelskies.com> writes:
>>
>>> Heya,
>>>
>>> git-stash in v1.7.0-rc0 gives me several hundred lines of :
>>> The previous build I was using -
>>> 5b15950ac414a8a2d4f5eb480712abcc9fe176d2 from Jan 19th - didn't show
>>> this problem.  Want me to try and bisect further?
>>
>> Yes, please.
>>
> 
> ee6fc514f2df821c2719cc49499a56ef2fb136b0 (Show submodules as modified
> when they contain a dirty work tree) seems to be the first bad commit.

Thanks for pinning that down.

I assume you have one or more submodules, maybe even with untracked
or yet uncommitted modified files in your tree? If so, what does git
status say in the superproject and in the submodule(s)?

(If you want to keep some information off the list, you can mail me
privately)
