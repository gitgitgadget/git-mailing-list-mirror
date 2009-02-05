From: James Pickens <jepicken@gmail.com>
Subject: [BUG] 'git log --quiet' doesn't suppress the output
Date: Wed, 4 Feb 2009 19:19:28 -0700
Message-ID: <885649360902041819k4a168407wc57017e6a1c7d00a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 03:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUtrM-0004Bw-3y
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 03:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451AbZBECTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 21:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756287AbZBECT3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 21:19:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:37079 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbZBECT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 21:19:28 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1643wah.21
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 18:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=58IpmLYdZYu+lZfqeqGlQu3ab8FBd2/yoC/5dTw9Ttc=;
        b=INtBC0iwnqLv22dr/RlIDI1ljn4PsDrInw3h+OmJIvfpbgwOsuiO2+i54LeUL8svrr
         u2gsMqpTkM06VA801BMBhEKywHo7Em0RRVoaCUSNUvIlnUNfghTofj9E/zIdSErnDkGs
         Thfvrxmhu61d2Fy6cdgPRD+rab2UDTXr/GUYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=WxTaRM8VGEs4Arb7bNTkXLHu5wqlie+Oa1F0KJKaP1jTB9At5fnH14z+EabNKWkTxH
         61Mnl5xR+nUrxfQcWR/SqWr/Q2AoGv6g2mHMFSg4fJyAI/uUjh0fvn1qeNtOsknuuCGZ
         YzURcyVSlMiNTb9hUC1m6zWvUAt7CKAtldkRM=
Received: by 10.114.13.10 with SMTP id 10mr4872406wam.219.1233800368067; Wed, 
	04 Feb 2009 18:19:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108493>

The --quiet switch to 'git log' doesn't suppress the output.  It only
does the same as --exit-code.

Tested with version 1.6.1.2.

James
