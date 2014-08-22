From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Thu, 21 Aug 2014 20:22:54 -0400
Organization: Twitter
Message-ID: <1408666974.1282.16.camel@leckie>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	 <1408485987-3590-19-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:23:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKcdK-00031e-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 02:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbaHVAXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 20:23:05 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:60252 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaHVAXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 20:23:04 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so9332403qge.25
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 17:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=/iZsFzhQsXJreJSx2N87fi0+cuIp1zN/AcPztLHhjvo=;
        b=fTcR4URLJiGDWZ/hAQoiNb0fqllu9FYI/NYfqAV3ErHg9tFFRmv01/N5aJR472K3pi
         DdnWmPMT/tdhU+n2lezS64kjJ9q+/9B3cQ97nAviyYz0mLCRgq9Sj6tEpk/L7SYtaEYJ
         bqFRjS8qHKxH2lnxOWVIz/ey5+CJ59RSSFUca+IWTwaigLwigQGaf9AzIJhGrzf6bQLD
         D1HR1k6SuP7IMoKDErLb+ircHWaezKbFo8nUAzoXay17fXltT2PiAC289VXs2pQI2grv
         Z8tfbgYh4hQJ2eegP04C3vr1KOpfmEf9KkhHflNUtK/lSyrlsnJGat65D4ezVSkXM1Ws
         pDdw==
X-Gm-Message-State: ALoCoQmqEe7mTJ4Teka2NvR6dHOADld36mU/rXXupGvwffWOAgnlq9W3R2TsKIeNUdBRVstzUJ37
X-Received: by 10.224.79.13 with SMTP id n13mr2946207qak.79.1408666979329;
        Thu, 21 Aug 2014 17:22:59 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id u36sm31457180qge.43.2014.08.21.17.22.57
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 21 Aug 2014 17:22:58 -0700 (PDT)
In-Reply-To: <1408485987-3590-19-git-send-email-gitster@pobox.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255650>

On Tue, 2014-08-19 at 15:06 -0700, Junio C Hamano wrote:
>  
> +If the receiving end does not support push-cert, the sending end MUST
> +NOT send a push-cert command.
> +
> +When a push-cert command is sent, command-list MUST NOT be sent; the
> +commands recorded in the push certificate is used instead.  The GPG
> +signature lines are detached signature for the contents recorded in

"are a detached signature"

> +the push certificate before the signature block begins and is used

"which is used" (or "and are used")

> +to certify that the commands were given by the pusher which must be

", who must be"

> +the signer.
> +
> +
> +The receive-pack server that advertises this capability is willing
> +to accept a signed push certificate.  A send-pack client MUST NOT
> +send push-cert packet unless the receive-pack server advertises this

"packets" (or "a push-cert packet")

>  
> +static void queue_commands_from_cert(struct command **p,

Uninformative parameter name p.
