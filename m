From: Dany <nessup@gmail.com>
Subject: Feature request: prevent push -f from pushing all branches at once
Date: Wed, 3 Jul 2013 16:30:27 -0700
Message-ID: <ADE9FE42-FC10-4976-8E6A-290B101DD17A@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 01:30:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuWVZ-0003qO-3y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 01:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696Ab3GCXaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 19:30:30 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:64454 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3GCXa3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 19:30:29 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so715785pab.6
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version:x-mailer;
        bh=LyfAl2+VzysVcCtR5vlV7Nb+Cn0vtir3U357LlN9BDM=;
        b=jPtAeb8K+tUq7RMVDsUrU0+rPNe2rr8M+PyloHjrFZH7v8hDMsAJZNwF5b5k/WJBHk
         XpmPQb2oKDh7OSlmOkbxH5vC9RH8EG88H/k3oA6tKOnPsBBvw0KvZpxEyndOHauW5EAp
         XZebajfeDfQ27pUxh1jX4pZHpqN7un3P2GjvFbBhRwNeb33tDkOLdEwJ5ldWigTaE436
         aQaqX8yuNWM1vBfvNxF+PKAxNBEw8fMIMaji/sN/UvDaqvXHOndHvxyV/gusEawYeZ5A
         d9PMJfWgxBfNiJrsNrssNZ3MFEMLuVUjHvkbjXUHlRGVAfy1wqh7TpwmsZRpWxE4iOqu
         hZug==
X-Received: by 10.68.137.8 with SMTP id qe8mr2975612pbb.100.1372894229364;
        Wed, 03 Jul 2013 16:30:29 -0700 (PDT)
Received: from [192.168.1.20] (c-76-102-3-186.hsd1.ca.comcast.net. [76.102.3.186])
        by mx.google.com with ESMTPSA id vb8sm268244pbc.11.2013.07.03.16.30.28
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 16:30:28 -0700 (PDT)
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229546>

Hi,

I had a pretty sucky thing happen to me today: while remote tracking a non-master branch, I force pushed. This had the intended effect of force pushing the branch I was working on, but also the unintended function of force pushing all branches I wasn't on.

I'm open to anyone's thoughts about this (or even a suggestion as to how to avoid this in the future), but as far as I know, in 99% of cases, a developer does not intend to force push all branches he is remote tracking on his system when he types `git push -f`. Now I know that that's what will happen, but I wonder why git does this (and, furthermore, why git doesn't prevent force pushing multiple branches at once.)

Again, I think the case where one intends to force push many branches is certainly not as common as the case where one intends to force push one branch, so why does git's default behavior leave the user in the position of fscking himself over pretty badly?

Would love any thoughts or suggestions on this.

Thanks,
--Dany.
