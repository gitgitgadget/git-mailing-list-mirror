From: Jim Kinsman <jakinsman@gmail.com>
Subject: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 11:39:31 -0500
Message-ID: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 17:40:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtOK-0000ZY-2m
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab3C0Qjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:39:32 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:39039 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3C0Qjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:39:31 -0400
Received: by mail-ob0-f179.google.com with SMTP id un3so8325331obb.38
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=k7vXHPtQLjBdOWl+hzieJw5Przoaj9U7+QKJ+iSOGwA=;
        b=EK6x5N7q4asFiUPlieNHJUGxAPpAb6zLmYrf9s8crkGdscp2x1Nue7xSr494DML3eW
         IsOA/6XIdPTIuBQate9dLGpYfYddO4DHoLBA6MrTwYmh//n1zziehpPiwp8ooXU3AVtR
         x81oGkI9MCPUz5rqKoiXia1G11rsrk0OiYEXRh3zayq0CLxx0G0VP1UZjrrbML49t0AU
         anomcyMav6cvbr1ZxfGsJ+QAAAP0CxnaW1yfMDW9MxyYTx5zXs0grQTTpLtb6I142bfI
         iqqXZ29iQljvMPi0wuECcxERsNl9M1MaFtA4ivWskF1B0Vtjvu30h6CJGjtPJacFeL7P
         nQJQ==
X-Received: by 10.182.46.228 with SMTP id y4mr4163542obm.13.1364402371349;
 Wed, 27 Mar 2013 09:39:31 -0700 (PDT)
Received: by 10.182.250.133 with HTTP; Wed, 27 Mar 2013 09:39:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219273>

git status takes 30 seconds on Windows 7. Here are some stats:
git ls-files | wc -l
27330

git ls-files -o | wc -l
4

$ git diff --name-only | xargs du -chs
68K     update_import_contacts.php
68K     total

What can I do??? This is so slow it is unbearable.
By the way i've done git gc several times and nothing changed.
