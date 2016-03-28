From: ratheesh kannoth <ratheesh.ksz@gmail.com>
Subject: git difftool help
Date: Mon, 28 Mar 2016 19:37:03 +0530
Message-ID: <CAGZFCEEYYwc=7z5+TRCxE=gR0od2X1oe1WgyhjvO6edb9yyM1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 16:13:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akXp7-0003tR-5k
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 16:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcC1OHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 10:07:05 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34563 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbcC1OHE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 10:07:04 -0400
Received: by mail-io0-f180.google.com with SMTP id e3so63836834ioa.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=egPzDbguEfsJgLfsSfYJpI+0ehQpNOdgg5fyNjOc8RQ=;
        b=n/JrXctbR2smEK90LTxdNSAx7phM31NAipaYFh83POpOuo2K3usnsh7U5oxXp9RBrc
         fbkb7/Ix1isfCBwFwtU0+rUqYmRvugeM0VC+sVzpLXZ987/rvixKKHuhFYVjFC4S7ll4
         YgvV6fz8I+K0pb4gAz3ltz9jMRTU20wv5m1cU0xGtFGZtQtsXqEbYiWV9LEq9KjIYy53
         dr+8ilwiSyJgG/VmCjLpZdfGVbaNG5/OeOi5HdO+o3sxnO9Ynfv7Xa3XdVuK0K/wE/gO
         BhHvC9JD5IhwJxCRzjiOIrG0kzc/+pUCStEw5flL9F7V5rNxtWyoCcsLa3jWIUp0OoRo
         p4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=egPzDbguEfsJgLfsSfYJpI+0ehQpNOdgg5fyNjOc8RQ=;
        b=H1wguzRzQlqKjzsbeCVyDrXvK2krAsFZ3gC1GYA/v5xGhFjbv/bD5pT9IDTAzaIFaW
         9ZcIW/9Nvk6AtZjueN3awfP2b6LdlchEptpJ92tmABV4dHqEDtSp+w9SNvneAFnXFg2z
         Hn0dyRU3ruCOGrYsPellvprmF/1khkrCaZide/pWhECa+RLmxAcsIP4m8V5gOMmeInoN
         rC2JZUYjYncyiK+jxnMXYcy6G+/j29c+pK8tfmjOdtXH/Md5qDC+gHBgv8kfYTaxpmGr
         Q2560bXsow0nQKouEzfNRczrRZT+I/IlrdsEKtecMRu5TYkVv2/U83X6vOjbCj4cK47Z
         girw==
X-Gm-Message-State: AD7BkJKt/Q8Rb/TZE8pubaz4yUP0KVWdGuaxw6zHx5ik4iRYeOiR40F2k90qcDqjfFlKhrl2gCBXBTempCJMQA==
X-Received: by 10.107.18.70 with SMTP id a67mr30401983ioj.116.1459174023247;
 Mon, 28 Mar 2016 07:07:03 -0700 (PDT)
Received: by 10.107.11.78 with HTTP; Mon, 28 Mar 2016 07:07:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290034>

'git diff 'is opening in meld. I could not create a patch using -  git
diff > ./patch-01
i did not make any change to pick meld, by  default it is picking meld.


Which "git difftool" will help to create patch ? i do want to  use
format patch as changes are not yet committed ?


-Ratheesh
