From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2] git-rebase--interactive.sh: add config option for custom instruction format
Date: Mon,  8 Jun 2015 17:00:01 -0400
Message-ID: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 08 23:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z249d-0007jo-ND
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 23:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbbFHVAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 17:00:11 -0400
Received: from mail-vn0-f49.google.com ([209.85.216.49]:33494 "EHLO
	mail-vn0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbFHVAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 17:00:10 -0400
Received: by vnbf190 with SMTP id f190so19623878vnb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QPj9nNxhpA+g/JpkDLTh7/UZ/qtLvH0Bem5h3H5tE9A=;
        b=ez6dJ9r/2Pa+09MN6fcFh2wdWjd9LzMUMLFHnfhh7NqmH8e76dlYVQ12lYcAMDrKG/
         pehauepod6y8vZ3TFpsiQui+85U/ZSoQ6N0YEy+ZG5tLDFF6+GzZDfyg7LqjCmhXjnNP
         M8EmRmAC222TnHXmepSOC2m2PMMMN/I5YmRWK8TLxUy0Hme7Z5x2GyA0+agNuB5MLlKT
         wOW213w0X6Zkg4KeH1vbfO9O3I5O8sarehmN79f4sYwzkhwWzwfils/Qd5E9XwaRJDRz
         sPbVQkzzaDGkcFfRt3CfbN6m+tiGhoTWGBKuLsrNXnBD1m4H3MFSkukFTBXWl3RyS+oy
         2vXw==
X-Received: by 10.52.30.201 with SMTP id u9mr1850429vdh.95.1433797209773;
        Mon, 08 Jun 2015 14:00:09 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-4572900c.dyn.optonline.net. [69.114.144.12])
        by mx.google.com with ESMTPSA id st8sm4320277vdb.4.2015.06.08.14.00.08
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2015 14:00:08 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271131>

Difference between v1 and v2 of this patch:

    - Fixed indentation from spaces to match the existing style
    - Changed the prepended sha1 from short (%h) to long (%H)
    - Used bash variable default when the config option is not present

Michael Rappazzo (1):
  git-rebase--interactive.sh: add config option for custom instruction
    format

 git-rebase--interactive.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.4.2
