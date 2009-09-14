From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH 08/17] Test for WIN32 instead of __MINGW32_
Date: Mon, 14 Sep 2009 21:42:32 +0200
Message-ID: <4AAE9CA8.1070900@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <7v1vm9cohd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 21:42:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnHRd-0003Gc-I8
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 21:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885AbZINTm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756882AbZINTm2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 15:42:28 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:52401 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865AbZINTm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 15:42:27 -0400
Received: by ewy2 with SMTP id 2so996714ewy.17
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 12:42:29 -0700 (PDT)
Received: by 10.211.155.19 with SMTP id h19mr3610276ebo.48.1252957345704;
        Mon, 14 Sep 2009 12:42:25 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 28sm3746491eyg.12.2009.09.14.12.42.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 12:42:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <7v1vm9cohd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128495>

Junio C Hamano said the following on 14.09.2009 21:31:
> Marius Storm-Olsen <mstormo@gmail.com> writes:
> 
>> From: Frank Li <lznuaa@gmail.com>
>>
>> The code which is conditional on MinGW32 is actually conditional on Windows.
>> Use the WIN32 symbol, which is defined by the MINGW32 and MSVC environments,
>> but not by Cygwin.
>>
>> Signed-off-by: Frank Li <lznuaa@gmail.com>
>> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
> 
> The description sounds very sensible; I wish I read this one first, before
> wasting time scratching my head while reading 03/17.  Shouldn't that patch
> be squashed into this one?

Heh, yeah, I agree. After patch got updated with suggestions from last 
roll, it clearly makes more sense hear now. I'll update tomorrow. Thanks.

--
.marius
