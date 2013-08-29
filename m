From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 2/7] refs: report ref type from lock_any_ref_for_update
Date: Thu, 29 Aug 2013 14:08:15 -0400
Message-ID: <521F8E0F.5030606@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <80d72f6f4bf04a8fef8ebfcc02a463e769cea3d4.1377784597.git.brad.king@kitware.com> <xmqqtxi85s50.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:10:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6fP-00061q-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab3H2SJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:09:56 -0400
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:56271 "HELO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755152Ab3H2SJz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 14:09:55 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]) (using TLSv1) by na3sys009aob136.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+OctoAEnbdCeF3bD0tb5DR0IdIWnNI@postini.com; Thu, 29 Aug 2013 11:09:55 PDT
Received: by mail-ob0-f170.google.com with SMTP id eh20so870378obb.15
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Fxtevi+XGnFx/0sWntrPKe3YaAH0y700ptfTU+yjv54=;
        b=GRlQNU34XGoUXOxpUBN9mcCEg7jDBaWj7iNXEkwNCVn/w6Bz2KVJ1EP2cGJgl+DwxH
         7Y3Hw6tY95wrWkAOlvnhXqBtSljblkvEYEIscu55ZbnId764kJhzjTL370pq2gQXtxv0
         hXnWguTg21bok1iSK//fgCQPRpov4lV46za+lE7h5btIDdHyKidzH70RofiCNpxVqxO+
         my/f9vnu28ry23oJTjMh/Q8s4FeNi/eRV4PP9nxrxCKda80+DO6gFvVIk1qd/JB+O6tu
         qh8sgxdoms4EeW7dYTkUWky7esJJmTc164gQc2q3Cp00//ot0AYPx6o290xAhGaij53s
         xo5w==
X-Gm-Message-State: ALoCoQmLk7evUJxJf9kIZMTsIxbXd5gM7VaQiUwa1TEA25V8pFRRlZTLiNrfQ57PruCHISSAJX0QyKH1KTegg+pydS11E3eVo4pa510LI5M8oEz40SplxZXfZwLoebfAHyBDV8Il1ZxV3khDIR6htm+JXS2toCiEBQ==
X-Received: by 10.182.81.41 with SMTP id w9mr3517974obx.18.1377799794306;
        Thu, 29 Aug 2013 11:09:54 -0700 (PDT)
X-Received: by 10.182.81.41 with SMTP id w9mr3517966obx.18.1377799794189;
        Thu, 29 Aug 2013 11:09:54 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id d8sm22489464oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:09:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqtxi85s50.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233298>

On 08/29/2013 01:22 PM, Junio C Hamano wrote:
> If you are passing an NULL as a new parameter, please spell it
> "NULL", not "0".

Fixed at all updated call sites.

-Brad
