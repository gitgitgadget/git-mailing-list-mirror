From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 4/6] add ref_abbrev_matches_full_with_rules()
Date: Mon, 12 Nov 2007 21:51:16 +0100
Message-ID: <03A9B0D0-5B70-47BB-B528-B86CE3FAAD8C@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de> <11947897083381-git-send-email-prohaska@zib.de> <11947897081278-git-send-email-prohaska@zib.de> <11947897083159-git-send-email-prohaska@zib.de> <11947897083265-git-send-email-prohaska@zib.de> <7vve872qen.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:50:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgF3-0006do-Su
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXKLUua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbXKLUua
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:50:30 -0500
Received: from mailer.zib.de ([130.73.108.11]:57740 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbXKLUu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:50:29 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lACKnxq8007591;
	Mon, 12 Nov 2007 21:50:08 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lACKnxC4010457
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 12 Nov 2007 21:49:59 +0100 (MET)
In-Reply-To: <7vve872qen.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64706>


On Nov 12, 2007, at 8:51 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> +int ref_abbrev_matches_full_with_rules(const char *abbrev_name,  
>> const char *full_name, const char **rules)
>> +{
>> +	const char **p;
>> +	const int abbrev_name_len = strlen(abbrev_name);
>> +
>> +	for (p = rules; *p; p++) {
>> +		if (!strcmp(full_name, mkpath(*p, abbrev_name_len,  
>> abbrev_name))) {
>> +			return 1;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>
> How about calling this simply "ref_abbrev_matches()" or
> "refname_match()" which is even shorter?

Yes. As you already did on pu. Thanks for cleaning up.

	Steffen
