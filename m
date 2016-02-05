From: Britton Kerin <britton.kerin@gmail.com>
Subject: changing colors in the tree view in gitk
Date: Fri, 5 Feb 2016 08:24:27 -0900
Message-ID: <CAC4O8c-8cXCfu7GdCS6bx5RMfw_Y8PgPeOhH6Zb5awyi-Qt4tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 18:24:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRk7V-0004cd-C1
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 18:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbcBERY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 12:24:29 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37295 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbcBERY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 12:24:28 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so36890993wme.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 09:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ry30KSCK/e9asNd3EUYezHiOAKP9bgxRv7TABMD45xg=;
        b=t7Gda/rl1OQA4O1WnskcOtc8oRqGqU8LTQ37+EFDiec4W0RWFb5KULLr0qYeVSZYev
         h+JTlmEb31HCR9SZ3IKpP2YoO92JksONbxG3L6RTnwORrAb2K5Lzys0xADfOdLhNfa3G
         VPiOME+A/klysVsxsZld0HwUm06Dar3yk+maKBU7fnNFkLXHKLPXveN3JT2Xy25gY5Vh
         qhnIQ/bymO7C6dkwXEa0+dXaO9rHb7lwxc+AsQWoFPkypEDHCWAfve4RfFaSBtRNP6Sj
         Vi3eUsd5TmSmWxvtnGCsyAy72oIiJXtvs58bm3AK8tfkVY0pBpbnECqGRdph9PfTs54X
         aXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ry30KSCK/e9asNd3EUYezHiOAKP9bgxRv7TABMD45xg=;
        b=MuexUsIOmI6G9hBZ7IR9ohQ2wUE8mlg/KBfqK6ozxMDm9OTJ7b8q2jrmY8fTdjcxmC
         Twcj52rj1ew9PHTsnu6Xj7CXgqiAraXZsZplEzIVUmmyD2DEz6ECXoLaKHMI0sOt4oPZ
         WfsVN3XV+Czin/Ck29tI66qgnnyGCvCd6CarG2KTQMNdvF/WCo75Cdv14bpv7WjM+SzL
         pmhEeor0zW8bKbLrO+KoEUVfZAfJk5tHPPlAH7Klo9mgWUjFfNMuiJiQu0wsokTpFSDM
         6IQ48+FX5h7x28E0kJhgCz4W7+tA0ItW4RW+LgNsVRzT7szkkFm/sPaUc1ypz6BNcVCH
         0fRg==
X-Gm-Message-State: AG10YOSignWAgE9F4+7iVvmmhVviQ15PMoKmj6HGbvR6khnczUOd8NOonkeX0vmveI916HzNZlUX3Hx/DpWebg==
X-Received: by 10.194.19.164 with SMTP id g4mr15146740wje.120.1454693067458;
 Fri, 05 Feb 2016 09:24:27 -0800 (PST)
Received: by 10.194.178.161 with HTTP; Fri, 5 Feb 2016 09:24:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285589>

I upgraded from 2.5 to 2.7 and the branch names went from a light
green to dark green, the names of the tags are hard to read now.

Is it possible to configure the branch name color in the tree view?
