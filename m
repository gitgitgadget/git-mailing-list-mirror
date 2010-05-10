From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 11:09:03 +0200
Message-ID: <AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com>
References: <1273475946-2079-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 10 11:09:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBOzS-0001dn-6S
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab0EJJJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 05:09:25 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33649 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0EJJJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:09:24 -0400
Received: by wwa36 with SMTP id 36so1373146wwa.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=jn6vUTZb+qXvUmD2Xm+H5Vu/Y2IepJECu/LPgc48dVs=;
        b=giNiGJbGWUG219fRoT9j3ldbjH97Fl4N2/4SjDbupXYIUuisM4KNHSv+Y6j7Uh/bWv
         BrFEDwXg2KYAnSlmz21bQx54JmDhC3aBTVrVSKhF7JZr3cZtpZ+xdQbHc74mq7JTaw0v
         i0YsTe2Xi+mYfXRnCSJyC6+VXGXUS0dFSQXXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=arGlYbl0NCr/wIQ3vndmMOUMuCe2drZXXYT3/oDyT6/YMdQ0lJRLS0JvN42JQAo2C5
         iPVrBNZ79QbvMad4Mfx4Qip1QHjz7B0GfWCqZWovvDgQqB6GGlgmLnwqaLDtJ4o/+YzH
         XZITSi0bzoaHORg3dyEkJmFru1xYg+5Somsv0=
Received: by 10.216.181.8 with SMTP id k8mr2160492wem.41.1273482563143; Mon, 
	10 May 2010 02:09:23 -0700 (PDT)
Received: by 10.216.60.147 with HTTP; Mon, 10 May 2010 02:09:03 -0700 (PDT)
In-Reply-To: <1273475946-2079-1-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146776>

Heya,

On Mon, May 10, 2010 at 09:19, Johannes Sixt <j6t@kdbg.org> wrote:
> Use 'grep' to check for expected output.

Don't we do this ('test_cmp' on expected output) in many other places
as well? Why is this different?

-- 
Cheers,

Sverre Rabbelier
