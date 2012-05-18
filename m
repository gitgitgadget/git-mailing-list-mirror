From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] Documentation: git-rev-parse: clarify that --git-dir does not necessarily show relative paths
Date: Fri, 18 May 2012 12:24:12 -0700
Message-ID: <xmqqsjex2syr.fsf@junio.mtv.corp.google.com>
References: <20120517182304.GA14367@burratino>
	<1337333004-23164-1-git-send-email-jon.seymour@gmail.com>
	<20120518093159.GA31412@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 21:24:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVSmm-0004E6-K2
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 21:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966532Ab2ERTYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 15:24:16 -0400
Received: from mail-wg0-f74.google.com ([74.125.82.74]:44270 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049Ab2ERTYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 15:24:15 -0400
Received: by wgbdt11 with SMTP id dt11so214388wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 12:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=j0hl5jtgFyMrv3IJv3Q9jc1N1l7M5898qoAo5BvblBM=;
        b=d+VXs1vx9lW38onUVvattn0eM0akbCgDYl7rWIyRh68xiB6yU/LOryNiKUKUkrJGEY
         Nk4byWH3nwLg3qfaGUnF7dzPPQoTlUblk6R2Jp8iexo6hD72pRiyOXQsEWY01CqIgwHi
         ETbypXdtGln7339EhdN7fRfGnbd+QAn7rsvqdjMqh1Hp3w3U/5ienIDp//Q1wf6Mq/xt
         IwwtSoXGjXnEYDk0kGsYjpYhGSiL1uvcAY3Dlw0tdpXGhOUWnkgwTsndZbCcLYcDbFCl
         wuG9MG/WnDcTDz5TCzNFZPKGreLg38skILQMp2dS0s90R97yG8UHLZvA85RmkgmBn26U
         rkkA==
Received: by 10.14.48.4 with SMTP id u4mr940417eeb.6.1337369053894;
        Fri, 18 May 2012 12:24:13 -0700 (PDT)
Received: by 10.14.48.4 with SMTP id u4mr940409eeb.6.1337369053813;
        Fri, 18 May 2012 12:24:13 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b16si9538327eeg.3.2012.05.18.12.24.13
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 12:24:13 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 9BEDF5C0050;
	Fri, 18 May 2012 12:24:13 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id D2552E1772; Fri, 18 May 2012 12:24:12 -0700 (PDT)
In-Reply-To: <20120518093159.GA31412@burratino> (Jonathan Nieder's message of
	"Fri, 18 May 2012 04:31:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlsx8jl8EWED5eJ2bFMseRX2WnHHAuS1X/3NxI5wD/bARuadw8+yfV41pfdQRkn0FxpZiWtSzZ8Lo9B14y6hj3WMnOKp1ZTOmDIgKJKv34Dn3YEk9nW4uFUCXR+2P8RAeCWpkxj+ELEvdYaQW5ajMlwu6/euw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197966>

Thanks, both.
