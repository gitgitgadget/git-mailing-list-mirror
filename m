From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] test-lib: user-friendly alternatives to test [-d|-f|-e]
Date: Tue, 10 Aug 2010 04:11:08 -0700
Message-ID: <E0E79EC3-DC41-40C5-AF38-53C73759EFAE@gmail.com>
References: <7vvd7j7nys.fsf@alter.siamese.dyndns.org> <1281438055-6971-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 10 13:11:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oimjk-0003DN-6s
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 13:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388Ab0HJLLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 07:11:12 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44685 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab0HJLLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 07:11:10 -0400
Received: by pvg2 with SMTP id 2so1131195pvg.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 04:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=BEGphj4UiQxZtSAgBOEVD8uGBORES+wGja+KTixHzUs=;
        b=bwSgRK0IIwQ7SxnqGzE5QJmmd5s8RLmriJSHzgspQ3rk3EkPiH47UzRyB8z1vPkR9s
         DTbnDe6ABiXG9rnhLd1diodnSaGwiaz5OVOGxT/e8WacswROcDADt/bdGIYYwtIcUQV0
         d+5HPC1wQuR9GfMMPynn17Wqyk0Cq+RO8hRmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=W6p0Y2OUG1Q43RzkJJYAfTH16XVmFIQABo10bCe8Vx9/Fapa35CEK6my12Ie4SjOIE
         WdHkDHHAsjm/7HWGGOd52ICgLBzg1gz6oBQ1HY5RUi2qJ+6qH5mrX0nFodsU88hLwOa/
         xrEn7jENP8jljzAABu6PSM96eZ4aL0xqVNXic=
Received: by 10.142.73.3 with SMTP id v3mr5939349wfa.255.1281438670444;
        Tue, 10 Aug 2010 04:11:10 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id n2sm7646480wfl.1.2010.08.10.04.11.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 04:11:10 -0700 (PDT)
In-Reply-To: <1281438055-6971-1-git-send-email-Matthieu.Moy@imag.fr>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153091>

On Aug 10, 2010, at 4:00 AM, Matthieu Moy wrote:

> +# debugging-friendly alternatives to "test [-f|-d|-e]"
> +# The commands test the existence or non-existance of $1. $2 can be

s/existance/existence/

Josh
