From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Reset by checkout?
Date: Sat, 31 May 2014 05:56:49 -0500
Message-ID: <5389b57138645_68b153b2f8a5@nysa.notmuch>
References: <20140531144610.754B.B013761@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Atsushi Nakagawa <atnak@chejz.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 12:56:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wqgy9-0003ck-3l
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 12:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbaEaK4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 06:56:53 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:44538 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbaEaK4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 06:56:52 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so2839102obc.30
        for <git@vger.kernel.org>; Sat, 31 May 2014 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=+h0Hpp/T7DO8d9AdQvY2OYQ48uEZ9ddkooO6PODtbdI=;
        b=l+w+csMCoHUDfFgVqZk9Z1IMgKbrLN/Io4gZyBPpSihYmSaGmxAzDbl0AEYIzGOwW1
         K1Qlj6IBkVEccgRcTElqjGzyNtatg+SvNrlhEyrWI7CcNT6CfmaTFy2ppTvHJSHeoNw3
         p090vtnUfe8UTrAGWQwS1W9ikShBa1CvPNPxMGH14tVY0c040l60VjqqZo/0RRjDQRO0
         KXBYCQPirjohvhBbOIHdSLW8RQ1+ubjPqyh9lv+T3g6AVbr83AEqHn4UGwtWXcVfZvRh
         1RPxzA0fFipT0C4rzJEIZjy10+Q64Fp54Ws60mBYuj6SGiLV8ZQCRvj2vDQp81WW8IQD
         3j2w==
X-Received: by 10.182.47.196 with SMTP id f4mr24338579obn.50.1401533811885;
        Sat, 31 May 2014 03:56:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cu7sm23727016oec.12.2014.05.31.03.56.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 May 2014 03:56:51 -0700 (PDT)
In-Reply-To: <20140531144610.754B.B013761@chejz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250506>

Atsushi Nakagawa wrote:
> Ok, the typical use case is: I'm on 'master' and I make a few test
> commits.  Afterwards, I want to discard the commits and move back to
> 'origin/master'.  I could type 'reset --hard origin/master' and risk
> blowing away dirty files if I'm not careful.  Or, I could use "reset by
> checkout" and be carefree.

Doesn't 'git reset orign/master' do that?

-- 
Felipe Contreras
