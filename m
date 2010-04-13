From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [EXPERIMENTAL PATCH] S-expression structured output backend
Date: Tue, 13 Apr 2010 18:29:38 +0800
Message-ID: <p2x46dff0321004130329gb21cefecn147b4f1b30152e25@mail.gmail.com>
References: <1271154205-5919-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Apr 13 12:36:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1dTv-0004Fu-3j
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 12:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab0DMKga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Apr 2010 06:36:30 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:34687 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab0DMKg3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Apr 2010 06:36:29 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2370100qwh.37
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MjIPKPuv4dtglvBVDkTEg/Gp8lxwJugjSHvZybmgkd4=;
        b=t9Yt+vOInvGum4dtQqFfBhVRObhsXQHKc7pI0LCCBvMh1qqugKD8GBWC87rI8yWJwr
         zVbnXGdJFOsQReeChyzclp+X29BMEuT4euxMeIgLx+sfJFl3wekA5iJ0S8A+yA9HOJQD
         9zGSVmNCPV7Qk+fLAfzbmZC8wRueP14ExYqRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eOHyzJa6hGoUtU7ZkWw6veAX72fpsdfVC8I48x4jN7iVZPmVezz2YKYlor4ANBoadi
         nyO0yGxpxrHNRM5KVU5TOAxxqv68tIix46pQusUyXGQp25WqfLEw2x31l3HOadt6dZeK
         juX071kls3TGem7Uc+sanKCUJ8n73YH10c/r0=
Received: by 10.229.85.134 with HTTP; Tue, 13 Apr 2010 03:29:38 -0700 (PDT)
In-Reply-To: <1271154205-5919-1-git-send-email-ilari.liusvaara@elisanet.fi>
Received: by 10.229.224.149 with SMTP id io21mr8029833qcb.64.1271154578689; 
	Tue, 13 Apr 2010 03:29:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144809>

On Tue, Apr 13, 2010 at 6:23 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Add structured output mode 'sexp' that prints out canonical form
> S-expressions.
>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> ---
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0output-sexp.c | =C2=A0 76 +++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
I think it's better to put all output-* files in a separate directory.
