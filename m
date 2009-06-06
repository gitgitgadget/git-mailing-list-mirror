From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [WIP/RFC] Allow push and fetch urls to be different
Date: Sat, 6 Jun 2009 22:50:15 +0800
Message-ID: <be6fef0d0906060750u2da77229p59f21b59d0aef4d2@mail.gmail.com>
References: <7v1vpztsci.fsf@alter.siamese.dyndns.org>
	 <1244299395-6605-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nikos Chantziaras <realnc@arcor.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jun 06 16:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCxE1-0003aG-60
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 16:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZFFOuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 10:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbZFFOuP
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 10:50:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:16307 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbZFFOuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 10:50:14 -0400
Received: by wf-out-1314.google.com with SMTP id 26so926381wfd.4
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UtqCXUIXt4xeY2amZIL0SgLjsPMBRZe3Nl/5t15zFH4=;
        b=vBNDlMKerL+hSRMJ4sbdZ4Wso1ISM+hJssPpt5iseOoHiMP1VrHuQLSk5UG7jwuWan
         6oW4MSl7Am7yc2MAL83ZprUmHRmwS8SrNIi5Fis1jnwYo8rSVYgfdBygDikyN4iID/xi
         Eus1RF2FBFCK5j7JB6yJrO1nXIjlPcUa0WbS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k0nS63g/QyoCnhYrPxGuDr/8OHX7IKoMV3sf66nF5Km0yU8UXwyyvG1lkGcTasJWeT
         CKD0oV/5tyr5DDMmh1GEeAMMHgZZ/x6+MGltFC62uHKNqGTkZoR7cgY95xCoCg1kx4+R
         PqVQy7qh2f5HgloySDSAkrkVG+NCnIgzKxi/4=
Received: by 10.143.31.11 with SMTP id i11mr1615562wfj.289.1244299815190; Sat, 
	06 Jun 2009 07:50:15 -0700 (PDT)
In-Reply-To: <1244299395-6605-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120923>

Hi,

On Sat, Jun 6, 2009 at 10:43 PM, Michael J
Gruber<git@drmicha.warpmail.net> wrote:
> This is a working prototype, but I'd like to rfc about the approach before
> coding further. Do I need to do anything in http-push.c? I don't think so.

As long as you're "controlling" the url before it gets used (like
you're doing now in builtin-push.c), you don't have to bother about
http-push.c.

-- 
Cheers,
Ray Chuan
