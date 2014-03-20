From: Yao Zhao <zhaox383@umn.edu>
Subject: Re: Re: [GSOC 2014]idea:Git Configuration API Improvement
Date: Thu, 20 Mar 2014 16:15:03 -0500
Message-ID: <1395350103-4899-1-git-send-email-zhaox383@umn.edu>
References: <vpqd2hh5j7k.fsf@anie.imag.fr>
Cc: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	Yao Zhao <zhaox383@umn.edu>
To: Matthieu.Moy@grenoble-inp.fr
X-From: git-owner@vger.kernel.org Thu Mar 20 22:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQkK8-0001BB-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 22:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbaCTVQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 17:16:19 -0400
Received: from vs-m.tc.umn.edu ([134.84.135.97]:35566 "EHLO vs-m.tc.umn.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933436AbaCTVQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 17:16:19 -0400
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com [209.85.223.178])
	by vs-m.tc.umn.edu (UMN smtpd) with ESMTP
	for <git@vger.kernel.org>; Thu, 20 Mar 2014 16:16:17 -0500 (CDT)
X-Umn-Remote-Mta: [N] mail-ie0-f178.google.com [209.85.223.178] #+LO+TS+TR
X-Umn-Classification: local
Received: by mail-ie0-f178.google.com with SMTP id lx4so1575365iec.37
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 14:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmuzdb9LhVfGN7ILI++ntYpDLWtEKvyibf0qXJkjBy0=;
        b=RJNKnd+bagYxWKcWAqhdnmcQXfvKQ6nmYxMdvUAgp4zORhMN7lZIAnqB7E/Qk1v3dC
         PJW9XCPsmVGPVxUSinyiTlanpPFXWWjJ9AhTMCnDDFmkPjzuoeIx8pzAp287EJAcP0nm
         rT+icifAxeBGyOsNzQ8AJcm3yGgVDI37ULrvIPufl7h40gn+OlJTz6U6RQHURbKl5Shj
         XlFuxcO2XvgOPu5HkZZ1TpOnwr5hkkxaJbJi3b7wwTKJ2BhW3feQnYImI1fmKWZkJGYi
         TxARUEZPspDJW0o1nXvYqtzn3fBfQwdenfTYMB4tcb6PLszrfTD4hdhDIor9/r1ByIvG
         DUUg==
X-Gm-Message-State: ALoCoQlNNk6i7kvADKotkC4Nnxu6LR0lniMSxSMESL9LCUrYZhmfE66O4rqQxZcmKeDvw2j0xA868vTDWQPE5RKl37WEEPPstwqiXCtvYoSVRMoYHX+HLEIa/XGdhCDRPkvNMzRHA/RpnXv/WkyqHTzZyqqwowx14A==
X-Received: by 10.50.83.38 with SMTP id n6mr33240285igy.30.1395350176786;
        Thu, 20 Mar 2014 14:16:16 -0700 (PDT)
X-Received: by 10.50.83.38 with SMTP id n6mr33240278igy.30.1395350176687;
        Thu, 20 Mar 2014 14:16:16 -0700 (PDT)
Received: from Yao-Laptop.umn.edu (x-131-212-240-218.uofm-secure.wireless.umn.edu. [131.212.240.218])
        by mx.google.com with ESMTPSA id c10sm38878982igj.17.2014.03.20.14.16.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 14:16:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <vpqd2hh5j7k.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244585>

I think I misunderstand the project as Moy said. I thought the purpose of project is to store configuration into memory between multiple git calls. Sorry.

Moy, thanks for explaining. You said API should be hided. Is that means I should indicate an arbitary feature in old version or new feature we added should be linked to a manipulation of inner structure? And I need to find the connection to make this abstraction?

Besides maybe I should focus on code part more in my proposal, like which part should be changed for this project?
