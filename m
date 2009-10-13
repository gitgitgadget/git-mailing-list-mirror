From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: linkify author/committer names with search
Date: Tue, 13 Oct 2009 13:16:03 -0700
Message-ID: <780e0a6b0910131316j58703de4l80da2eca547ae337@mail.gmail.com>
References: <1255328340-28449-1-git-send-email-bebarino@gmail.com> 
	<1255429615-4402-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<4AD4C94A.9010909@gmail.com> <cb7bb73a0910131241t7220a3c2q16e99a8fc62dd29a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxnwl-0006OW-HB
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761237AbZJMUYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761218AbZJMUYs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:24:48 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:52509 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760822AbZJMUYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:24:47 -0400
Received: by pzk26 with SMTP id 26so9315277pzk.4
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=b0eX04fqeXtvdWzOm+pqycQ6cGaTFr9g5wfjsAyQnHc=;
        b=sbRBASajUcLe4tpa9ar+haVw1jGHz8uy31lAzWGmcWHai4nwhhtw90eW2AAZABH07U
         grAnw8vAZA4LCHghMiZDz/PGlzpa5W6tWchylnUeAol8BEi526kf4o5THdcXDOqT0Z1Q
         /ov6AVsi71as7IVLd0PoVmizeDw4i8iWa+JNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kRlerRzamUEPmfdkqcowZd0w0IdplPLGGOVpxRXkaQi1uRV/e5DZ6rH+p5Sq0N8NVr
         VpZqY4aFYgjeHiTXI9Hon88I15E/WXJPtdGzYCY/sTF6QlUGoU1YemWS9afa9JLDASIl
         iHoq0rkHuL+6cRj3bIv0hwsys6+hddmKEcoaM=
Received: by 10.142.249.41 with SMTP id w41mr625511wfh.347.1255464983066; Tue, 
	13 Oct 2009 13:16:23 -0700 (PDT)
In-Reply-To: <cb7bb73a0910131241t7220a3c2q16e99a8fc62dd29a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130203>

On Tue, Oct 13, 2009 at 12:41 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
>
> Reproduced, debugged, patch incoming (the problem is not in your patch
> but in esc_param).
>

Thanks. I will test later today. I think a similar problem affects the
branch name labels (the colored boxes with ref names in them) when the
name has utf8 characters.
