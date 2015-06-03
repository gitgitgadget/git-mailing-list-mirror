From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] ewah: use less generic macro name
Date: Wed, 3 Jun 2015 02:51:20 -0400
Message-ID: <CAPig+cRySp4_uJYAwC-PY_Yh-YjBb0y1Tq=TwoD7d-Bpb_YANg@mail.gmail.com>
References: <20150603063812.GA21319@peff.net>
	<20150603063937.GB29008@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:51:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02WL-0005Vj-T2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbbFCGvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:51:21 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35727 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbbFCGvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:51:20 -0400
Received: by iesa3 with SMTP id a3so6618542ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9jV3DpvjbpfY/aV8w66XN6Jt0UuCzlnoi0IRPenHpHg=;
        b=eyxv0/Ngiytw5vzFT/jX2nqvj/up/ueRRLbPcCXgZhefcGaom5d2P4nfAn53DKvk0Q
         9krZz5ndNrGbbJL6Q2TQou8UzPfiTvMCBrJjbWH7QQFVst2RXUKHH/nzcqCAA5+I3zpO
         2vcbAdARSEQ18mfhG6cIdVAxH35EaMpAqG6I81wDVMdsFRg3TMnqe8xO4AYUfC/ubcV5
         8D4vdEAZk009FgZkXMs0Jm6+RPMBVldJh8DzFgKHhXRA81C5vJVR2h4QSKBR9ZoFiBNj
         c6mZSXLQIjUU3+0/LU6l1ooPii0i8twYIqXhGR8qU31zaxq3zYkKnJTzmfkZgQybRBUE
         patw==
X-Received: by 10.107.151.75 with SMTP id z72mr3865164iod.46.1433314280182;
 Tue, 02 Jun 2015 23:51:20 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 23:51:20 -0700 (PDT)
In-Reply-To: <20150603063937.GB29008@peff.net>
X-Google-Sender-Auth: BE0s-gE_qjYJdZB7nCdLArjPKMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270659>

On Wed, Jun 3, 2015 at 2:39 AM, Jeff King <peff@peff.net> wrote:
> The ewah/ewok.h header pollutes the global namespace with
> "BITS_IN_WORD", without any specific notion that we are
> talking about the bits in an eword_t. We can give this the
> more specific name "BITS_IN_EWORD".
>
> Signed-off-by: Jeff King <peff@peff.net>

Yeah, splitting the patches this way makes sense and feels a bit cleaner.

It's such a simple patch that it doesn't need a reviewed-by, but for
what it's worth...

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
