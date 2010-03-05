From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] gitignore: do not ignore include/linux/
Date: Fri, 05 Mar 2010 16:19:14 +0100
Message-ID: <4B9120F2.2020000@gmail.com>
References: <4B90CBE5.9090102@viscovery.net>	<1267780845-10547-1-git-send-email-jslaby@suse.cz> <m3pr3jkq26.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiri Slaby <jslaby@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 16:19:39 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnZJQ-0002L4-Ek
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 16:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab0CEPTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 10:19:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:23868 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab0CEPTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 10:19:23 -0500
Received: by fg-out-1718.google.com with SMTP id l26so282640fgb.1
        for <multiple recipients>; Fri, 05 Mar 2010 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=EhLsNMbCIlRk9iXU/ByKrY/BNAnYFJNQV3KMtibubD4=;
        b=YMObl/NPqZk7egpl+6n05NtcBtKiBrKXL1oNTuwgVKXX0116iXjiIJfg24v+vU7eai
         So/0J0XD9LDKGaalPJGGGR3vQz1GNwy6cCd3NbylmxgRcPKCmivED1bQ+KmNJVcJpP8M
         k0559ykyElMoztPWtYq5xuU5+St3/EHGbIBtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=s8+87r54xcWbeZ+37Czf+iH0cwC857f7v+GK6qLKIcNIVXWASk1xG+KiVlvidZLagN
         s8EZta//X+KVPcTcLt1cL5Dsrkg3glPj4I4EOKnPPVMfuDnG91WR4aneQTBGwz7SQ89H
         MHqRN6IZQzBYFNffacQpe1WXk2oi47U7R1F6U=
Received: by 10.87.11.25 with SMTP id o25mr329546fgi.23.1267802360213;
        Fri, 05 Mar 2010 07:19:20 -0800 (PST)
Received: from [192.168.2.129] ([217.66.174.142])
        by mx.google.com with ESMTPS id l19sm844873fgb.1.2010.03.05.07.19.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 07:19:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; cs-CZ; rv:1.9.1.7) Gecko/20100111 SUSE/3.0.1-11.2 Thunderbird/3.0.1
In-Reply-To: <m3pr3jkq26.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141583>

On 03/05/2010 11:43 AM, Jakub Narebski wrote:
>> +!/.gitignore
>> +!/.mailmap
> 
> Actually you want to *not ignore* .gitignore and .mailmap (and
> .gitattributes which is missing here) anywhere, not only as top-level
> file.  So .gitignore and .mailmap should not be prepended with slash.

<and moved out of the 'Top-level generic files' section then>

-- 
js
