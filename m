From: Ed Hutchins <eh@demeterr.com>
Subject: Feature request: "author branch" in commit object
Date: Tue, 2 Jul 2013 12:37:13 -0700
Message-ID: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 21:43:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu6Tm-0004RO-3H
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 21:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab3GBTnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 15:43:05 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:53903 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab3GBTnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 15:43:04 -0400
Received: by mail-qa0-f50.google.com with SMTP id l18so3111642qak.9
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 12:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=T9F+2awWbY78IZt4WoQM2+yoeMEiPmUk8w5pPHUs+/0=;
        b=W2ohp0J90ItRsgkvGJAav/KlbdNYih//U59DjsjJXkzZIgG18y7SySheu0vjMJp/O3
         PbSqZM+0HpjHZ9F7uZL/skAfUztUHZR41l/oFW0w3I/SoFyYYzjcKHkRG52FCUzX9Pqn
         Kwx2EHQV9oZLmv82HijffTDa/N4tQ/tDCMCqq8GHVFikq09TtmYIHATM+19gPGpZFOUV
         umbB/Lpn5MmEKtEwaro6zA2nWZYIFHylqjZh1KiEHe03dRvatRqRfjJoh1k4Lu2Z44X0
         iVkCVjkS5QBGQd5ZmxvpEcEkVU+FKb3HMP9YmnsPv9m++nzr9R3vUpM0Q8Jeb+15xqOJ
         DsjQ==
X-Received: by 10.49.12.33 with SMTP id v1mr40172628qeb.85.1372793834036; Tue,
 02 Jul 2013 12:37:14 -0700 (PDT)
Received: by 10.49.76.234 with HTTP; Tue, 2 Jul 2013 12:37:13 -0700 (PDT)
X-Gm-Message-State: ALoCoQkh3Wl6BL5ibLSPVk0QkGnGDfJRpofQW7BCJvbM/EPCJ9EnGE3srcpBHcjYf+a7bame5n0+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229422>

I realize that branch names are ephemeral repo-specific things, but it
would be really useful to be able to determine what branch a commit
was authored from (as a hint to ancestry graph layout tools, for
example). Is there any way to do this currently, is it planned, or
would it be deemed useful enough to be worth adding to each commit
object?

  - Ed
