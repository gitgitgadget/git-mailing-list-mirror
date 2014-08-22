From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Fri, 22 Aug 2014 22:22:37 +0200
Message-ID: <53F7A68D.2000109@gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>	<53F7A119.7070704@gmail.com> <xmqqiolknvfz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:22:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvMB-0002mT-5b
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaHVUWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:22:39 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35545 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbaHVUWi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:22:38 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so194434wiw.12
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QWsFeaPCPg4peTrK9gDA3UJViB2pp/2ivzpMaV8vuWk=;
        b=Cp1xvLb4h79qAcutflqT0XyhaDPDxNLjwRnDfhccgCTsBH5VciLuswzrPsTXCWru3Y
         76Yvs+4CZVS9NJySX1SoOv7GVlGqCoZqm+eX3upFF+KGeSIRp26WOu0tfBMXjSshZCJG
         tBLHLuyNcPrevH1dEgeTJPWaIddNXwLFzvXkf0QADQnk9h8TNVJZ/Td2AgBLdUcFZ6wf
         W4cv4KvRSSOSlXxwzM3+TuIk40z7l6fzZsQobYdm9nX1DFrNsXKaV2saqnPLKB6VJQ6b
         j+9mCtAaVwshlhS7JdhVeLmNW3CxYq5tK6Sdhb1116NgymDTHdgqypdqy5e1VDxfoar/
         xMGg==
X-Received: by 10.180.73.6 with SMTP id h6mr550110wiv.65.1408738957719;
        Fri, 22 Aug 2014 13:22:37 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id kz6sm66277218wjb.47.2014.08.22.13.22.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Aug 2014 13:22:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqiolknvfz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255700>

On 22.08.2014 22:03, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
> 
>> So there would be tags like:
>> 	master_2014_08_21
>> 	master_2014_08_22
>> 	...
>> 	maint_2014_08_13
>> 	maint_2014_08_21
>> and so on. Whenever there is no tag at the tip of the branch, we'd
>> know there is something wrong.
> 
> Who creates that tag?
> 

> My guess would be usability as tagging so many branches is cumbersome
for a maintainer?
