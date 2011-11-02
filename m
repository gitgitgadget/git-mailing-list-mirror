From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: long fsck time
Date: Wed, 2 Nov 2011 19:06:42 +0700
Message-ID: <CACsJy8D04Hw0_OoV01g2xtNK2d6fmZD_+YNEOR3A8aMUTpG5Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 02 13:07:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLZbD-0002ot-B2
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 13:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab1KBMHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 08:07:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42397 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811Ab1KBMHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 08:07:13 -0400
Received: by bke11 with SMTP id 11so70497bke.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=g3m6q97Dkt6Aw/RdoJL0wPwc4WGKSfQSRf1gWAFKpQU=;
        b=dj+53VZ/Jv/b4T01Xp/roRG6Gpe0g6UUkOzQs0KC/F9AKB3hBJfUvjykwpiM4Q2VyF
         IJno86avSgOaqsy4MtF33Jk2qpp6Q5wA2WJc0wt6Nl5LzGsNMo7zjczuOYSLXy/Vzg3C
         JtB4f2OBxlGfIHvVdccviD3lDem+hkwYjIWgw=
Received: by 10.204.16.67 with SMTP id n3mr3512983bka.6.1320235632157; Wed, 02
 Nov 2011 05:07:12 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Wed, 2 Nov 2011 05:06:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184629>

On git.git

$ /usr/bin/time git fsck
333.25user 4.28system 5:37.59elapsed 99%CPU (0avgtext+0avgdata
420080maxresident)k
0inputs+0outputs (0major+726560minor)pagefaults 0swaps

That's really long time, perhaps we should print progress so users
know it's still running?
-- 
Duy
