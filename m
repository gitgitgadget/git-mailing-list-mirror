From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 2/2] update-ref: fix "verify" command with missing <oldvalue>
Date: Thu, 11 Dec 2014 11:19:46 -0500
Message-ID: <5489C422.9000104@kitware.com>
References: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu> <1418255272-5875-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 11 17:19:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz6T6-0001ru-9l
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 17:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195AbaLKQTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 11:19:51 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:53468 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897AbaLKQTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 11:19:50 -0500
Received: by mail-qg0-f41.google.com with SMTP id j5so4030323qga.0
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 08:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VdkGh83nQF3TyNrjSnEkPRgyK5VuGSpSl7fLlOA52z8=;
        b=h+bJugh+IWCAkHMNhTh9vtW7kUGYMxcTEAto4srixC1N4Mbg8rBKJme/HwVANVGqeX
         HivRgAa7xqWluwIUOQzk4BOzRfkg7jyq6vOc/xYVfCVB96WAM7gv2qMaz0Z/5ABNaSDo
         0zqOiqM+sJdsXqOdA6FYhoIBK6WHabC/Y752GBMSFyzULsDzPKVFvRWwzu/zSVkTYWqV
         PipjH0gPwn42M5mUUOoHsHcwNQRGrbS0X58P6dGv9zFosYNwcwoA718glZAjdXY+AE7W
         8L9FuB+hoFo2a098gICmMTBztgF1sQJ88s8MI01gpQFxEDYcTLCmSXCdU+7RV9xJqKez
         WMow==
X-Gm-Message-State: ALoCoQl1sG5iG4l64wC4AAto9iUMhNucrPNmciRAm14pbBUuK8ns/aHjmEgD4BoywimKgSoUbxRg
X-Received: by 10.229.130.65 with SMTP id r1mr21522181qcs.16.1418314789791;
        Thu, 11 Dec 2014 08:19:49 -0800 (PST)
Received: from [192.168.100.143] (cpe-72-224-128-246.nycap.res.rr.com. [72.224.128.246])
        by mx.google.com with ESMTPSA id a1sm1445317qam.3.2014.12.11.08.19.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Dec 2014 08:19:49 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <1418255272-5875-3-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261284>

On 12/10/2014 6:47 PM, Michael Haggerty wrote:
> set have_old unconditionally and set old_sha1 to null_sha1.

Reviewed-by: Brad King <brad.king@kitware.com>

-Brad
