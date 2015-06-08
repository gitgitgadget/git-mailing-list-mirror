From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v5 03/10] for-each-ref: rename 'refinfo' to 'ref_array_item'
Date: Mon, 08 Jun 2015 20:49:18 +0530
Message-ID: <5575B276.7030005@gmail.com>
References: <55729B78.1070207@gmail.com>	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>	<1433574581-23980-3-git-send-email-karthik.188@gmail.com> <vpq4mmi8doc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:19:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ypp-0006ox-FK
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbbFHPTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:19:25 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36067 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbbFHPTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:19:23 -0400
Received: by pdjm12 with SMTP id m12so106838951pdj.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=f0q7Tmg2TlLH68KzR71VZxLfiyCN/iD/glxwHsCE8vc=;
        b=VRAT8c0P32xLBoRb3jVvgYoRvuASWy6HCPJ7Y3be+RTLgiEYjQjaovmRs6UoUW6pyY
         U1ixxhW0DZS/EfpplsIb4CaqcBlmlqaofMSFemzg5fUHncnd0c3mLUNNRNsR0Xdxr+qy
         2S0Hd1d6u7c1FQo+aDRU6HR1wk+NDPOGXIbCP8JzzxU1tJ4KEjbDzeaWCzFNp0CKNdtQ
         QiVIn1jhAY62vAKE3WqOiLGdPdOjtWZ9IyNP2yKUQAoWKHjkM202/w0opzQNcAnfEuna
         GIhBoFK+Mnha1y0yPjwhuzStycoJbDaQ4EQ6O3XUGnrfi6jRUnEgrN13KK2OkxJJwGdf
         taRQ==
X-Received: by 10.68.94.193 with SMTP id de1mr30082673pbb.153.1433776762800;
        Mon, 08 Jun 2015 08:19:22 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id v9sm2910190pdr.96.2015.06.08.08.19.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 08:19:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq4mmi8doc.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271048>

On 06/08/2015 08:12 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Make 'symref' a non const char pointer, so that the compiler doesn't
>> throw an error when we try to free the memory allocated to it.
>
> Casting to non-cost when calling free() is a common pattern. I think it
> would make more sense to cast at free() time and keep the member const.
>

Ok! will do that. thanks :)

-- 
Regards,
Karthik
