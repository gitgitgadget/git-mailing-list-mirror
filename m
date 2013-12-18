From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v5 02/14] add a hashtable implementation that supports
 O(1) removal
Date: Wed, 18 Dec 2013 14:11:08 +0100
Message-ID: <52B19EEC.5020904@gmail.com>
References: <52851FB5.4050406@gmail.com> <528521E2.7090305@gmail.com> <20131214020413.GB2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 14:11:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtGuB-0006xr-6P
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 14:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab3LRNLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 08:11:10 -0500
Received: from mail-ee0-f49.google.com ([74.125.83.49]:51755 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab3LRNLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 08:11:09 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so3507514eek.22
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 05:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XH4LJCzX9uclbSRvlpErRDrO+iQcD481J30Ovue9Bmw=;
        b=rLt+zSstZcl+VMBEewaRsRF2cIG2G0CtPwyPKYk+zOJdfM51zs4SuxtxugI19Mb8kJ
         igDr3bwrRxnezhKnBSO94LDS7GP430MvBVVAWH/xCBljq1O/XFpOHhGERkTkOIlxFFRV
         BhODFMt1nJNmYwsQTbq5ONEU3+AiInqB5/ompZEyEFoSA8w1e2V5prC7L7itnVS9PuEx
         7bHfI+fk4akEFQIE9Fs8qdOVFVc+8TnSYeuZmOeDdCTaXs6kwuVt7SXD0sgP1YVgqYLV
         aqakrST3pXYoMkT2pClAzvXXOntBmUGF7WYns886HX28IXvebGhre4ENsn0JjpJzSzHo
         I0zg==
X-Received: by 10.14.172.130 with SMTP id t2mr28499647eel.68.1387372268278;
        Wed, 18 Dec 2013 05:11:08 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id e3sm62345207eeg.11.2013.12.18.05.11.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 05:11:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131214020413.GB2311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239431>

Am 14.12.2013 03:04, schrieb Jonathan Nieder:
> Hi,
> 
> Karsten Blees wrote:
> 
>>  test-hashmap.c                          | 340 ++++++++++++++++++++++++++++++++
> 
> Here come two small tweaks on top (meant for squashing in or applying
> to the series, whichever is more convenient).
> 
> Thanks,
> Jonathan Nieder (2):
>   Add test-hashmap to .gitignore
>   Drop unnecessary #includes from test-hashmap
> 
>  .gitignore     | 1 +
>  test-hashmap.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
Thanks, these two make perfect sense.

I'm too damn slow again (merged to next two days ago), but FWIW:
Acked-by: Karsten Blees <blees@dcon.de>
