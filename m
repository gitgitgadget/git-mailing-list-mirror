From: Patrick Berkeley <patrickberkeley@gmail.com>
Subject: On Tracking Binary Files
Date: Tue, 14 Apr 2009 10:42:22 -0400
Message-ID: <7efce40a0904140742i48aad41ds66de5dfe368f3b16@mail.gmail.com>
References: <7efce40a0904140741w28da9b54ucfe4b54bf48b0844@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 16:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltk0G-00085Y-GG
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 16:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878AbZDNOum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 10:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbZDNOum
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 10:50:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:10049 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZDNOul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 10:50:41 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2683952ywb.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=ZeFdHSas2AE8vNURl9J+BGA2MtKL9U72CZacCZKuung=;
        b=bNN7hKna2YZafdCcPc3XQS8ZjvF1tG0VbWA/62wvEGbZ6CioUo4+nzSLmRYv95zt2N
         ZdWg3f1SR1rkVgnGJO+2dzAxuOhKqE8MVZqyYsWdqBGsz/t1fbEjKopyJb7/hX3lhoAt
         izw9G1pEK9hvVzhRcqdtr2sv6KJchp/GyOOYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=opqtE43uG5IO2gfPxjKKSiJc1ijJxykq5PgHkWJNIBRTdYgyrKdQbT6jfjPgDD+XAP
         3adtSPy4rhjSM28hBJvkxGfgnG02QT5QaKY8bjBe7e13WaNh4NkS2R7BYSC8TpzD8eJ2
         k7ypGgOsMrjgttu3FjM1R8SsgLUFMQ8oe+Xgg=
Received: by 10.151.7.11 with SMTP id k11mr3211253ybi.170.1239720157154; Tue, 
	14 Apr 2009 07:42:37 -0700 (PDT)
In-Reply-To: <7efce40a0904140741w28da9b54ucfe4b54bf48b0844@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116541>

Does Git track the deltas on binary files?

Someone in #git mentioned that if the binaries change too much Git no
longer just stores the changes. If this is the case, what is the
breaking point where Git goes from storing the deltas to the entire
new file?

Thanks, Patrick
