From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v10 00/20] index-helper/watchman
Date: Thu, 19 May 2016 16:30:00 -0400
Organization: Twitter
Message-ID: <1463689800.24478.82.camel@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
	 <1463684925.24478.81.camel@twopensource.com>
	 <xmqq1t4xizag.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 22:30:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3UaD-000085-CV
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 22:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbcESUaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 16:30:04 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36029 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbcESUaD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 16:30:03 -0400
Received: by mail-qg0-f44.google.com with SMTP id w36so50191315qge.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=IzrBgAKh7egbeMpfpMZUQbcNVcn6/S91scgdTlUmuNM=;
        b=W/SrBgnUMTOQ5rMZ4fLasTqjcL5VAWdchjeItpxsNSfkBtJjTdp0FP4ImioD3dSn36
         ow3hIAdwWA06zSH9W1zf6jp2elUXGXDNWie9+DrPLjjA/lpV1mAwYnJOSN20hLhXZ8BR
         ADV4prNo2Z2I5SeE5xnab+a54958QREoFW0q7ZiqrsFbsMrqd2zVxL1VJi0/gdIe9+M8
         L4H1g/mHUAZ2Tp2fYEPzTHGVL3le3NKMWXWPsx6VPNsxYIBtFejFDnhHX2/fV9FST5yC
         dbUQUDwVsVt2yILy8Y+2gJyegn/3e8LC9ccWVHr0aCmfZLpl4Wo4zixn1lIAWpVhNG00
         xCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=IzrBgAKh7egbeMpfpMZUQbcNVcn6/S91scgdTlUmuNM=;
        b=VPaMo9ey9m5dWWGntlJHloYMOaTBVcv/+RNrBT7WY7gZXv6/nFyqYLz2wgkJO9jNQN
         szRIrbwajGC0ujt4sNnk2N6JMn9LzVMJmFybH2iV0whavCw8w0i1l/qITIZhTegtkKbp
         8Vep/XLUFV7trlLgtTm80DFyGNT1xso3G2EBgoYQg3Ubg2L/gcFX9hfd1+q334XhBu1L
         6UAHBIrDU9xWJ8Sfad7ixcxMw/x0iiQydBHfJ8OwkwaKCDrwLH3V56EIo+xmrJ3PpJ3v
         9pQFsV+V5iY7J5lm7+ZtZ6dRjg2sNbbhBMelG8c+iH0bVB6B+uvxxfvv8nS6eXWK3bXq
         2TQQ==
X-Gm-Message-State: AOPr4FXLpThZaP6nt4GOOTrDbyIWik32LvmarFoY+R1FeaycLhFwyQfh7zpG/voZVaq9vg==
X-Received: by 10.140.143.144 with SMTP id 138mr16768750qhp.88.1463689802207;
        Thu, 19 May 2016 13:30:02 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id w17sm7327712qha.23.2016.05.19.13.30.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2016 13:30:01 -0700 (PDT)
In-Reply-To: <xmqq1t4xizag.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295098>

On Thu, 2016-05-19 at 13:11 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Do folks have any more comments on this version?
> 
> Not from me at the moment.
> 
> > Do I need to re-roll
> > to replace 11/20 as I proposed and drop 20/20?  
> 
> FYI, I think I have the one taken from
> 
>     Message-Id:
>     <1463174182-20200-1-git-send-email-dturner@twopensource.com>
> 
> aka http://thread.gmane.org/gmane.comp.version-control.git/294470/foc
> us=294585
> 
> queued at 11/20.

LGTM!

Thanks.
