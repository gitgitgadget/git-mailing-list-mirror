From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/2] hash-object: support --stdin-paths with --no-filters
Date: Fri, 12 Feb 2010 21:37:08 +0300
Message-ID: <37fcd2781002121037n4c98890eq5d635fc3bad5928a@mail.gmail.com>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	normalperson@yhbt.net, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:37:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng0OD-0004ik-Ou
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 19:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab0BLShL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 13:37:11 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:39748 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259Ab0BLShJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 13:37:09 -0500
Received: by fxm20 with SMTP id 20so2649431fxm.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 10:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=objFM/wVQGloNRNFe/gR/VrhVmljZzbFVVM/kh60ArU=;
        b=DFNyqg2Ydh9yq7JAl81gjxMTR6Mm9VjihkiJHot4lJNS4mTWxzPwIeZjeOegyROFh8
         ELtSKHCX8FTfmaqwAmJLE0nXGgsorSSasHEWkhEKBaECeIknUko8Qt2UZoQcpiO3azXY
         ThbuZW/qYH2GzjS7qOJTuF/QI0fGxHkxpzzQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sOWKLdxUbFHqTPI8pZDlxypkgDq/c8V0sxxHYU9Atyc+1KH10oigugvxm8nFJ6wM/R
         T6SNkl5QbFg5i7zGfLrOISItusErX6WxfH/PgSRcCFDpQsq6Wj94Qn/T4NkBf6Y2MlHA
         A6Y4F2eBDd5ZmQ4l0/NO7DpSZi3EHSqLM9jS8=
Received: by 10.239.133.196 with SMTP id 4mr190877hbw.59.1265999828229; Fri, 
	12 Feb 2010 10:37:08 -0800 (PST)
In-Reply-To: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139738>

Hi Erik,

I don't remember why I made --no-filters incompatible with --stdin-paths
when I added it. So your patch makes perfect sense to me. However, I
think you should correct synopsis in Documentation/git-hash-object.txt,
so it will be clear that these two options can be used together now.
Also, it would be nice if you add a test case to make sure that it works
as expected and will not broken in the future..


Thanks,
Dmitry
