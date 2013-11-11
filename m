From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 5/7] test-hg.sh: avoid obsolete 'test' syntax
Date: Mon, 11 Nov 2013 05:44:25 -0600
Message-ID: <5280c31919c9_6841541e7851@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384142712-2936-6-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 12:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfq1t-000662-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 12:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab3KKLvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 06:51:38 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34049 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab3KKLvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 06:51:37 -0500
Received: by mail-oa0-f46.google.com with SMTP id m1so2115912oag.19
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=gPk8x6VkK/Ltp/k47rOuDXvo2el7igolaFHHujzE/ZY=;
        b=hdhMyB26g2GloP5o0ITedo4fEc/t1GH2oTd0ja0/1+OmB9EFarBcxn1Bu7LaPOCW3s
         RofaLbXTIdnso3BshbLZ7SU2XAzgDajZt6S/AicH/y3BcFGWiBDA63RE/L237ZOGL8Co
         o5B1Ph8ko3p9gvU9vBMSPOHiSG4mH9cq2wOmgml/3gUgHpVjlix2IVDAetVEdx9y5l3+
         7GO/xmbQm30XFDoviPMsIYeomb6Q7zB3pkp8BbwfNMxopDEs9VnloOY3bitK9NtUzaTb
         7If4f594dg1fi9HdLt8/JEWZMsd1yM9eO58k4kCTON449AXEh0652k4qG3Bkfg8Am8Sj
         R3rw==
X-Received: by 10.60.42.72 with SMTP id m8mr809068oel.64.1384170697161;
        Mon, 11 Nov 2013 03:51:37 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm25801909obu.4.2013.11.11.03.51.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 03:51:36 -0800 (PST)
In-Reply-To: <1384142712-2936-6-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237614>

Richard Hansen wrote:
> The POSIX spec says that the '-a', '-o', and parentheses operands to
> the 'test' utility are obsolete extensions due to the potential for
> ambiguity.  Replace '-o' with '|| test' to avoid unspecified behavior.

All right, if you say so.

-- 
Felipe Contreras
