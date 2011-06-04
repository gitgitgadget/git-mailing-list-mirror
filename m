From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative paths.
Date: Sat, 04 Jun 2011 17:39:15 +0200
Message-ID: <4DEA51A3.3000603@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vhb86a4kt.fsf@alter.siamese.dyndns.org> <4DE99724.9090607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 17:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSswc-0007RL-0h
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 17:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab1FDPjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2011 11:39:17 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46665 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1FDPjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2011 11:39:17 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 1CE241A1864C1;
	Sat,  4 Jun 2011 17:39:16 +0200 (CEST)
Received: from [93.240.100.218] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QSswW-0000Lo-00; Sat, 04 Jun 2011 17:39:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DE99724.9090607@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX183phUWPg4J9Rw8wrd1WT5CWfcHPt8ztMmvRWx9
	LmOtHgOUFwxa5rNa4HzXLttThCNuIt4xPJiFZ3JBPd5jwUCXv/
	5KD8ylFjZZG3a5ipNIWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175060>

Am 04.06.2011 04:23, schrieb Mark Levedahl:
> On 06/03/2011 07:16 PM, Junio C Hamano wrote:
>> Jens Lehmann<Jens.Lehmann@web.de>  writes:
>> The "how about this" patch you are voting against (I am neutral by the
>> way) is a response to your earlier "I have three use cases and the current
>> implementation is forgetting the third", which in turn was a response to
>> my "your third use case does not count, so the updated wording of the
>> documentation is wrong---it should say 'do not', not 'cannot'".
>>
>> So what should the updated document say?
>>
> If I understand this correctly, the third use case isn't actually unique: if the upstream repo is on a local file system, why not just use a file://... url for the super project's origin?

Right, if you use a "file:/" scheme these two cases become one. But you
can omit the "file:/" scheme part and it will still give the same result.
(So if the file scheme would be regarded as default the third case would
already be covered by the url case)
