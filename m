From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] git-rebase.sh: fix typo
Date: Thu, 2 Aug 2012 19:41:32 +0200
Message-ID: <CAN0XMOLHZ1Cfct+7=mGk6bm1yJcHBQvEKWDQVz8vw9T6vaQDPg@mail.gmail.com>
References: <1343840949-3122-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 19:41:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwzP1-0005jd-5b
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 19:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab2HBRle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 13:41:34 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51808 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2HBRld (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 13:41:33 -0400
Received: by wgbdr13 with SMTP id dr13so8267809wgb.1
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tmy1bNxgZCDOfXE02X8byfSifizUo+AEn4ptOdW0NX8=;
        b=DLX/0IaUy0niZt7U//mWods9TSWsBmMdJ7bw6PDdfTq6GnUVDVxMGS5GUaxjfsFT0V
         yIU/ozY1GWd81Nn7uj+gaP8YC1aAhK0GCMOQr0twkL+GcrpdTIFEfo5PByCWj7bO93l6
         FazqHqv2juA9Yzsk3gacb4qzd7EuOKUZDGP3GUt5EAaBNpomMT4Qej5Sdua1sIvuFc4g
         Gu6qjM9eVs9g0VhTDgAiUxewfHKYNwZcbUzceQlgigCNe0ygLSRJPizJsu69OmNFq0BO
         Mj81P5r8eWNEp0eUnr+x7MmP7bA+QMVeE80MueNRLR58pj7MT9p0Z/xGAcdqRpdlFXCG
         cT2w==
Received: by 10.180.96.3 with SMTP id do3mr6542639wib.5.1343929292497; Thu, 02
 Aug 2012 10:41:32 -0700 (PDT)
Received: by 10.194.26.33 with HTTP; Thu, 2 Aug 2012 10:41:32 -0700 (PDT)
In-Reply-To: <1343840949-3122-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202785>

On Wed, Aug 1, 2012 at 7:09 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>  $(eval_gettext 'It seems that there is already a $state_dir_base directory, and
> -I wonder if you ware in the middle of another rebase.  If that is the
> +I wonder if you are in the middle of another rebase.  If that is the
>  case, please try

After looked at it again, I've noticed that there are also two whitespace
characters after the sentence (same on another sentence in this message).
I don't think that we need another patch for that, though, but it should be
fixed when the message gets changed.
