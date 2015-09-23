From: Luke Diamand <luke@diamand.org>
Subject: git-p4: t9819 failing
Date: Wed, 23 Sep 2015 10:27:36 +0100
Message-ID: <CAE5ih79t+62XUKsj9cnkJCCv4WPhUgQZQ6hF39Nx0ky+WFi-sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 11:27:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZegL1-0006pg-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 11:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbbIWJ1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 05:27:39 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33563 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbbIWJ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 05:27:37 -0400
Received: by oixx17 with SMTP id x17so20356383oix.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=6gJtDIRZc5IjlmQUpcUnlhe9uNT+dlY7Vm9qmG3HDI0=;
        b=WSlx5pmL35xGN96JZ54Zo20yop/yIKMjRF6tyM4HutN5mMSx2bbsEjhb5JA8zKHJg0
         LT6/2/AsxTwzk3Wf60t368oc9TQuq2l7jofjebc1FOcYs+NbFAKuGenU8S4P5nnU0vCx
         Mc9MC1lQVFVjMYu2lNLMpRz2g7hh9EH2zl/4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=6gJtDIRZc5IjlmQUpcUnlhe9uNT+dlY7Vm9qmG3HDI0=;
        b=WHqT/T3BlVU9YtnZV8e/LQ4kgUpsZfNb24pS7oOoX9haTpnloQBcJhsRiZ1e/nQBCe
         EJ+Eg6GMzCSPpTUMFlLbbnEhoBpevBMu9tbYUt6oXTucvQbsQm75hHefepVAFsspGisk
         0kDWjKtlMozvhr417AxKZ6uN7ZylIx2eTDCSZU4L701W3hIijDITklA9w1bYrbzy/Y+a
         cbPUykFj91PIgM44jYvM8qHOJ4FxKeW2yJaGm1kTgNzypYDJLR3r8ut25Wtn23fUSVyD
         DPzFmSlCGePYRhh+z2pmdGsaJnHn0ZYASrWu24Pk/TSD38yJcu8gWSgqO27rZ6MuEk4A
         Jozw==
X-Gm-Message-State: ALoCoQmzspMrKKcIRoGd4C7JfKjrbvLmrGTUYVisXsrYuOj2YVdT31TqNDZKJAC51do4q16oDlpt
X-Received: by 10.202.175.88 with SMTP id y85mr17777472oie.22.1443000456774;
 Wed, 23 Sep 2015 02:27:36 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Wed, 23 Sep 2015 02:27:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278478>

Lars,

I just noticed that your change "git-p4: honor core.ignorecase when
using P4 client specs" seems to break t9819.

I suspect that the problem is just that t9819 needs to be updated to
reflect your change - do you have any thoughts on that?

Thanks!
Luke
