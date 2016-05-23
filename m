From: Thaina Yu <thainayu@gmail.com>
Subject: Please add http REST api in addition to command line
Date: Mon, 23 May 2016 11:55:26 +0700
Message-ID: <CADeMgjCQBpBLb8b98FxCNi+M9wgJJzVSoYYvYYaYVY+tbWYT=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 06:56:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4hua-0007oj-SH
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 06:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbcEWE4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 00:56:08 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33774 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcEWE4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 00:56:07 -0400
Received: by mail-oi0-f50.google.com with SMTP id k23so53926522oih.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 21:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+4LSWRtnKos2n7bE2hyivQj+CRhPBlfFzM044C8EXb4=;
        b=B+YbCA05JOkEQELa1NyLWTkvgsAWl/qpLic6ByQx8JVYoRnQyZJ5gJRabZT5WUBMIy
         ctNM+awS7H4WKm5K8DuD7EVOCVxEv07HOtl+zbb5F2zmBZhLab5H/G0d7vpGWIAq0aB/
         9+pu0LpvnUUtF3Aopp0viXc/M449Y89KMWWdAzAMX/VElzHcb4ssti/d2Xeo1o7mqFH5
         rWK/yemqwvxKj5Aj9nGWdwxSDwIGT3/JqU4SY5nnneBZk4wcZX0ByqG2JQmGXtRUnnSa
         eGWqMN5Sw5mB1otqq74yUiK/PP19sI29HtZAWoe3v1nPS0H5NQNQT6r1vANhHtM/GMX4
         LeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+4LSWRtnKos2n7bE2hyivQj+CRhPBlfFzM044C8EXb4=;
        b=YLRvKNIt9hfFayiSD95bgG7gAyMQMJ5ewCO/gIabXbzZ42Pw9yfdwXS6mQ+uRscpux
         bqYrGv+c/ct8gxutIPhKdq6mZb2cS+ocsqqjDPCDZsp+VkWs8cKxgfZyVBaq8oKKJL4i
         mMrHZdZ9Rgt4pG6A5+ubvZI3Ht04gYmtSGYiFct6j5nLipalAktHq4GI4MW39ke0tSIj
         zzgauhJ00DscfIRPiTr40eNnjD1vlJJHXnvhobFdhx/1fGTpBCstz6EJAvAawvKKuHDP
         TTuFe2K/oOaL3ShTz5RENESfgZoDIV502PZExeA1HmokpY1Orkm3qDzNlYzbPSF5TXnV
         PPlw==
X-Gm-Message-State: AOPr4FV2AKHw1Sd3yg3aGm5iuIUAlm9f1WDJS2TfpF0EtBEAUS/bs0FMuDvHFra2WIKLiGhpBGB06MWBE/WM2g==
X-Received: by 10.157.5.100 with SMTP id 91mr9251863otw.38.1463979365968; Sun,
 22 May 2016 21:56:05 -0700 (PDT)
Received: by 10.157.38.147 with HTTP; Sun, 22 May 2016 21:55:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295310>

git should have REST api and able to work with command from remote
place (and also localhost)
