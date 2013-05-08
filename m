From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] completion: zsh wrapper cleanups
Date: Wed,  8 May 2013 02:36:59 -0500
Message-ID: <1367998621-12582-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 09:38:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZyxL-0004Ui-FE
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 09:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab3EHHi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 03:38:27 -0400
Received: from mail-ye0-f179.google.com ([209.85.213.179]:56527 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3EHHi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 03:38:26 -0400
Received: by mail-ye0-f179.google.com with SMTP id l14so340992yen.38
        for <git@vger.kernel.org>; Wed, 08 May 2013 00:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jnabXE7q6QLJTz6h2aGwqk/a+ZpZy2Y0JsP4pX0nXJs=;
        b=aTjnqZJlbaNUlIlq2UBB64Xa40Y9lUxaEd/nmqCoU7G/lxxm0XPjCLLUO4O+liVClx
         iZAifbN/RXAvJZO+K4SYBKsqA7ugqzMkthgHUefjM2Bnu+a+f0OwHuptTX7Ck3zpcKwq
         HIiKZTeK9JU/EyuH0G5km1tnT40GXbW1nVGPefct40HjkRPbTQ/NfWD1VybTk/U7IFl0
         kt9ki+oGrySIWwEHzRj/sdEb5VvXPRKssjgwCWMiwRC1RTIfYRQf5kqDhGHRCFm3GGdW
         PuLA1dkTmmi5qtwTbkgtU12NUA7oG/IDo9SBZIwEJtzZt3MB/GAUI7CHA7qKJDlbnQ8F
         5/UA==
X-Received: by 10.236.121.172 with SMTP id r32mr5141834yhh.2.1367998705689;
        Wed, 08 May 2013 00:38:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id a24sm24080234yho.24.2013.05.08.00.38.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 00:38:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223646>

Hi,

Nothing fancy, just some cleanups for the minimal zsh backup wrapper in bash's
completion code.

Felipe Contreras (2):
  completion: cleanup zsh wrapper
  completion: synchronize zsh wrapper

 contrib/completion/git-completion.bash | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

-- 
1.8.3.rc1.553.gac13664
