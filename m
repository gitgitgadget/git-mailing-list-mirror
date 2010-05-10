From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 12:45:14 +0200
Message-ID: <AANLkTilKpMfaXdPumJpX3ohRmkq0zOrIm3Hq-_ggjcFP@mail.gmail.com>
References: <1273475946-2079-1-git-send-email-j6t@kdbg.org> 
	<AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com> 
	<4BE7DEB8.5000900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 10 12:45:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBQUY-0008Eb-VJ
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 12:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab0EJKph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 06:45:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63836 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab0EJKpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 06:45:35 -0400
Received: by wyf19 with SMTP id 19so740150wyf.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=rnTMNHpwYpUfG0Z2ljsevR1nLHZYQGI+jZOUVeyYQnI=;
        b=hFzhacVn4v0XEiah+DRbPk1B1iAeourtO1CZPs+EpIXhc6aGOCrYwM0AQZB7W3hb+e
         b/6YX3i1P55YyE3Dg7mroDMIXlXqYmx2dzzpYfDS29N6UNoI9AXNrzflPcTzlLmtxy2Q
         MDIFEBsr2UC4PZwm4Io3f3/c/nv0pt/7XjBwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eXGEKCNZ0gjxeizH3UwGByChGXOGWc8epeqicRN97xxVn8Nb16k+rvbug78bxdrCJv
         VmqsHgJioIRZoamY83j6WJsyBoyTmXYiLh6dvMfbI/0GaWZhOo5j0BowSknvCR5x9BVp
         CUlsI2XWkhSs2cIwM9Uv/m9SSl/0ARJEQmSRo=
Received: by 10.216.168.84 with SMTP id j62mr2283630wel.89.1273488334157; Mon, 
	10 May 2010 03:45:34 -0700 (PDT)
Received: by 10.216.60.147 with HTTP; Mon, 10 May 2010 03:45:14 -0700 (PDT)
In-Reply-To: <4BE7DEB8.5000900@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146794>

Heya,

On Mon, May 10, 2010 at 12:23, Johannes Sixt <j.sixt@viscovery.net> wrote:
> This is really only special because the test_cmp looked at the stderr of a
> test_must_fail command. The old code was:
[...]
> i.e., there were command traces in the file.

Ah, that makes sense. Did you check if other tests are not affected by
the same problem (by running all tests with -x)?

-- 
Cheers,

Sverre Rabbelier
