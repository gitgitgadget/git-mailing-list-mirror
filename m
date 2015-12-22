From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/16] LMDB refs backend atop pre-vtable
Date: Tue, 22 Dec 2015 18:56:17 -0500
Organization: Twitter
Message-ID: <1450828577.3892.12.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 23 00:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBWn3-0008Hp-IA
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 00:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbbLVX4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 18:56:22 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35281 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933257AbbLVX4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 18:56:21 -0500
Received: by mail-pa0-f41.google.com with SMTP id jx14so96590047pad.2
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 15:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=/jmGYCRJOzmDF6+dTrxtLcmfUqpbakAE3YNG70XfVDc=;
        b=OKgtWcSnIJGEFPkXbZAIFw9Bzd9uFMr6a6kzdBUiILrczKr7WKR3odDICmvdtmRBro
         SH3crR0uowpdzsLE+3aYkL7HS6fLKWtDg1rDFKMPqtYiOKT0mqlsjMtBf4GQoM/WKp8f
         9dwFhcZ9aoBoSwcA/Oux8xco8czhmWRCGjdswpUHhCHV1nADR3+wAc/P2sLOjuU25Apm
         3BtjpwzIWMHzoYyqQpFiAgitcN+85BeONRexJ4JOHal9K3TgMl0OnMFzOhJuud0stkFx
         emE5gfdgFf05TaHNwgCG7ch1bYsgGz//zmO2DaGDcJZYe/wVAKxerw5az1BGIvm1wLQZ
         Tu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=/jmGYCRJOzmDF6+dTrxtLcmfUqpbakAE3YNG70XfVDc=;
        b=DcR8DMzh5yKligw7cYmzT71HPoWSfGDw/H5ZvUyEn/jzCnQObIWXf3LlKE+T9Pai7U
         ddyMu6MM+e1Ggjy5curXYEYcFdKtr4cfjkUTviIGu2/CGFSoqtxlWemjBKrO1Zlwc9cw
         wQFMlqfCYc4wSvfTjlOJ2cv1nqwraqK64Ufm57IfFHQHBeK0y1/mFnmowOleE6tkDwm2
         GDSuxOHtKAOpPn4jmaU6WzOTTxL52NT673vS3P4+7LcEJy+4MfBivV0Xm0nrM4vbiaKD
         eEPFoBT/+VfG+cbNaRTFqsSPZY/A59j4ozBi/xgsY8WoupaDDomCjKTS/GrcykcgJXfI
         NHQA==
X-Gm-Message-State: ALoCoQlj+jGWJRlGoGnA0Bd4+KvP1IUPeo1WRQjfAmqDqx+RI7yXIDFEfeCSwmuvMDHCH4BKrAvsYN67mY4jYLBTeko0h3x0fQ==
X-Received: by 10.66.101.36 with SMTP id fd4mr40365919pab.76.1450828580739;
        Tue, 22 Dec 2015 15:56:20 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id xi8sm48301120pab.9.2015.12.22.15.56.19
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Dec 2015 15:56:19 -0800 (PST)
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282918>

On Wed, 2015-12-02 at 19:35 -0500, David Turner wrote:
> I'm starting the patchset numbering over from 1 here, because this
> version of the patchset is a subset of the last version.

I'm going out of town on 12/24 and will return 1/5.  I won't be reading
this email address.  When I get back, I'll read any reviews.
