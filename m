From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 05 Mar 2010 10:29:01 +0100
Message-ID: <4B90CEDD.6020106@gmail.com>
References: <4B90C701.3070308@gmail.com> <4B90C974.2050405@viscovery.net> <4B90C9BE.1030407@gmail.com> <4B90CBE5.9090102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Mar 05 10:29:19 2010
connect(): Connection refused
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NnTqQ-0002Se-56
	for glk-linux-kernel-3@lo.gmane.org; Fri, 05 Mar 2010 10:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0CEJ3I (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 5 Mar 2010 04:29:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:28890 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0CEJ3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2010 04:29:04 -0500
Received: by fg-out-1718.google.com with SMTP id l26so159054fgb.1
        for <multiple recipients>; Fri, 05 Mar 2010 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=djVw6sWEyU8G55gxyHH4wXaVa+zMiGZjJrkVH3LkIxo=;
        b=FbIeWkUC4MgZT5Hk/+1/G30Hk2F/+EkHipwxwdX1xHsP3JcjTh51/JhHNhncxCd5NY
         ia9Rl4HO2VCRgLDyANaklgUVMRdZHrwbDkHRmNzjdarydE8dY9IRezqzlm4W5JzphYiC
         6C+cHiVQO36d/ySqHRT23D3vbno4h8xBBaiTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=FYrFFvib/gbcYZqgq2LaZV0JDDVRF3KdZI5cVCvPgV2BBNzChjr2xj7EEco+SGyVv1
         1NJg7aVvY4t8ygtJ60U9aQyFgMWZePT59HerniHDORR+29W7nGJtDSfTUhhM0azlqanE
         v6oILUWh7VvokmfUjOOlADkdj4232FbDW7nHA=
Received: by 10.87.45.14 with SMTP id x14mr838755fgj.54.1267781343049;
        Fri, 05 Mar 2010 01:29:03 -0800 (PST)
Received: from [192.168.2.129] ([217.66.174.142])
        by mx.google.com with ESMTPS id d8sm2352709fga.24.2010.03.05.01.29.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 01:29:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; cs-CZ; rv:1.9.1.7) Gecko/20100111 SUSE/3.0.1-11.2 Thunderbird/3.0.1
In-Reply-To: <4B90CBE5.9090102@viscovery.net>
X-Enigmail-Version: 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141570>

On 03/05/2010 10:16 AM, Johannes Sixt wrote:
> The cited sentence says that the particular check considers only the last
> path component of the pathname.

Thinking about it, there is no way to specify a *filename* no matter
where it lies? I.e. patterns such as *.o matches also a/b/test.o/test.c?
Am I missing something?

-- 
js
