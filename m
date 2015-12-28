From: Niek van der Kooy <niekvanderkooy@gmail.com>
Subject: Issue when changing staged files in a pre-commit hook
Date: Mon, 28 Dec 2015 13:17:27 +0100
Message-ID: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 13:17:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDWkK-0007SY-IO
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 13:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbbL1MRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 07:17:50 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36951 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbL1MRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 07:17:48 -0500
Received: by mail-wm0-f48.google.com with SMTP id f206so5934228wmf.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 04:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Y5w3uQTBxE0a30m353inB+SJyqt6/O7o8yweB/nud34=;
        b=TXZHfKzSZ7Vn7RNW313w9G51MWSPmGkKm9ZEkq9OPWc4w+IyB4F915UhX6NhoMRGCZ
         J2HOxBRkMizV14WodjycYTLGczl3t04JKNYA8hohdfaZRKCKDR0HoQJjR8W57FTD2g3U
         UnLQP5wk0qra01gCNjmKOJYT2M+BNNNV5AKkQHaI2R+Vj0n7MLH59FqUsyU5/ZRoi/Iq
         RH1HU7Ruuy+ZazQsahAOfn5evWes33g4+szQGyTn0SAopspGRQ1NMASms3n3YawbEPSW
         iGTTO7VXhbHNkLrbwotLg/6FkKFe7Cp9XNWbNK8vlpJE78vR8r20VzT/lYjroHQyTxq0
         fM4Q==
X-Received: by 10.194.86.166 with SMTP id q6mr29710779wjz.69.1451305067384;
 Mon, 28 Dec 2015 04:17:47 -0800 (PST)
Received: by 10.28.59.9 with HTTP; Mon, 28 Dec 2015 04:17:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283036>

I am having an issue where the default commit message is not changed
when adding staged files in a pre-commit hook.
Please see http://stackoverflow.com/questions/34492779/git-update-git-status-part-of-commit-message-after-pre-commit-hook
for details.

Is there a workaround / proper way to achieve what I am trying to do,
or is this a bug?

Regards,
Niek van der Kooy
