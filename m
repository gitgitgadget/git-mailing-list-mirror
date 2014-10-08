From: Adrian Stern <adrian.stern@unchained.ch>
Subject: Vendor-Branch setup
Date: Wed, 8 Oct 2014 16:07:39 +0200
Message-ID: <CAOHZ5L4aAT0vYfJ4g=5NmED9=nWyHS1ATf+15Y060uiz=CtkRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 16:07:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbru4-00063Z-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 16:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbaJHOHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 10:07:41 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:49665 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbaJHOHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 10:07:40 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so7431592igb.8
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 07:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=xBo+vRBQPZK8LPQ+NWiHMYqVcBOhyJzYbRQbmpRP0AY=;
        b=carwkJxZ/+h3RgegHQVCdo/IrjTdX+HCCpzNmrgLW7OROEmbvrDJDGXefCS2adSlwa
         FlpUCjlP8qHI8HeX0IO8gJGZv2wn82mrnHhL0mjiaKI3zt8QjbrchdJ0g7Eic3vYmjGE
         bRpoz1jTVnMrwPmH5t8uIDukLcjNKXrkjgtzwUd92+zU+a26eFWtynahLPaGIqjDqIXV
         Sj1L5rI3Q4a5wRH/g8b7jNzIH0PQeqh/l0iB0Om2s5ICRjEYANO90plIqrlPke1F5IgV
         6WKqMULMDLfhPpXjcsiL/axdbR9/L8G/u0KU1nXb0F2ZqlhWescVOWv/RZQQ6+KTx32z
         iCiw==
X-Gm-Message-State: ALoCoQkNigJO67NtCNZoy4hfMC5RU1QNqvYdiQ/JvM1RMWRPOxYw3I559cQXck/lfWMMHw28o9Qm
X-Received: by 10.50.143.73 with SMTP id sc9mr17175596igb.29.1412777259871;
 Wed, 08 Oct 2014 07:07:39 -0700 (PDT)
Received: by 10.42.198.6 with HTTP; Wed, 8 Oct 2014 07:07:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I have a Vendro-Branch setup where i store the official code in my own
repository. Next to that i have a Delta-Branch where i store only the
changed files different to the Vendor-Branch.

I have two problems with this setup:

1)
When updating the Vendor-Branch (File A, B, C), the file A which is
also present in the Delta-Branch, is not automatically updated in
Delta. I cannot merge Vendor into Delta because thousands of other
files would be added thus destroying the purpos of the Delta branch.
Checking out Delta after updating Vendor will load the file from
Delta. Can't i just merge the files already present in Delta from
Vendor to Delta?

2)
After upgrading Vendor and merging Delta to Vendor older files in
Delta get ignored and not Merged. File A for example is newer in
Vendor, but i need the changes from Delta. -X theirs does not work
eigther. What i want is the merge-window.

Merge Strategy "theirs" does not work. I get "Already up-to-date" each time.

Any sugestions how i could get this to work? Or maybe there is a more
logical setup?

Regards,

Adrian Stern
unchained - web solutions

adrian.stern@unchained.ch
+41 79 292 83 47
