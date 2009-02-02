From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Force gitk as the forground process when it starts up on 
	Mac OS X
Date: Mon, 2 Feb 2009 20:07:01 +0100
Message-ID: <bd6139dc0902021107x286d77f9s4dc05a0579bd2bce@mail.gmail.com>
References: <b48ea8a00902020536t1baea7fbw4fbf27f235024639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gisle Aas <gisle@aas.no>
X-From: git-owner@vger.kernel.org Mon Feb 02 20:09:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU49m-0006jH-J7
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 20:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbZBBTHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 14:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZBBTHE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 14:07:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:41310 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbZBBTHD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 14:07:03 -0500
Received: by fg-out-1718.google.com with SMTP id 16so683389fgg.17
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=vZJSldMc3fX2XilTjJjpwWxWegoNMGo9VykZfjXs1ww=;
        b=TldsNuWsFjMrhc8BPxcTJW3Z3z2BjxJz54rWn1FzwfJkMC+At446vFiZRDFH/BDL9q
         gjHQdaOnml3Dye+yCahJ/IHcEICEyg0MJk3N/kvrOv0u7Rn65KE26nXwExgt4i7kDDja
         M0UxmNxyQlB2bbI7xhZ9UeJbBLN4Yl1SE72Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=If8HEBitLnU67q4qXe9f+I8hGtt2TQjFmlwUdPbSoiPEtVPI5jfAMm4GbtOjrew+pV
         x8uhccv2MejMjnQtH++wqIKAiOmizrdkPD7LMEBTPPhk4jjYj5MFkUzItTjLSl5qhtEg
         kvLqZc3EucIYtK0RcpncI2VDI4d7BJvmgo87Y=
Received: by 10.86.3.4 with SMTP id 4mr1081053fgc.66.1233601621394; Mon, 02 
	Feb 2009 11:07:01 -0800 (PST)
In-Reply-To: <b48ea8a00902020536t1baea7fbw4fbf27f235024639@mail.gmail.com>
X-Google-Sender-Auth: 405ed0ba8a98ce08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108108>

Heya,

On Mon, Feb 2, 2009 at 14:36, Gisle Aas <gisle@aas.no> wrote:
> It annoys me that gitk always start out in the background on Mac OS X. Hence this patch
> --Gisle
>
>
> From 272c7f9b6a2bcdf48e4141b9dc5af445fa69a27b Mon Sep 17 00:00:00 2001
> From: Gisle Aas <gisle@aas.no>
> Date: Mon, 2 Feb 2009 14:27:20 +0100
> Subject: [PATCH] Force gitk as the forground process when it starts up
> on Mac OS X
>
> This patch makes gitk start in the foreground this for those that have the
> tclCarbonProcess package installed.  Unfortunately that package is not
> shipped by default from Apple, but it's part of ActiveTcl.
>
> Signed-off-by: Gisle Aas <gisle@aas.no>

There, fixed that for ya :).

-- 
Cheers,

Sverre Rabbelier
