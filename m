From: Danny Lin <danny0838@gmail.com>
Subject: --squash has no effect in git subtree push?
Date: Mon, 4 May 2015 21:58:00 +0800
Message-ID: <CAMbsUu5g=r867_WOhLCySG3caKj1jhmQgfzBxK4TYV27+nUpsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 15:58:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpGsq-0003OS-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 15:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbbEDN6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 09:58:04 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35681 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbEDN6B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 09:58:01 -0400
Received: by qkhg7 with SMTP id g7so84933277qkh.2
        for <git@vger.kernel.org>; Mon, 04 May 2015 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=NIKFVfAlNuteuFCDvwfStW3edxDAhy27PkBwXmIMsJI=;
        b=T+Jqfaq6ac8DANMuROj7ZyN8iH0JpYnhHomM509eV8dUV+rQAbVkSOZ7liPvauGPXA
         WRxJa5dXTYa2DTAjtKkdQRi151Fd77xyGPUvo3gq23be1QdPR7HVBBF2ggTongTlWxit
         GoMalNXhqq807GfoCUhYzIeVDsQk3A5DJ+c92xCrEA8LPxl1c9TnFJAe2ZVOkBTBHb+O
         sVnZsCm0WgoA2gmL26VIE+IvkHrwwbnqHNn5sxPNilRlwYJMqGE9hYB6FHxxi4SLmakw
         13qKsctLdeacbSVwf1WXW9sBWGEeGD4Hp5hJ/0D0NGEX1eNrgKMkjRetEMYwPml66Q3A
         ZB+w==
X-Received: by 10.229.19.67 with SMTP id z3mr28793698qca.2.1430747880647; Mon,
 04 May 2015 06:58:00 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Mon, 4 May 2015 06:58:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268327>

The document says that --squash is for 'add', 'merge', 'pull' and 'push'.

However, it seems that --squash has no effect for push. Am I doing
something wrong or is the document outdated?

git version 2.3.7.windows.1
