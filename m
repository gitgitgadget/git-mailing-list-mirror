From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: set stdout to binary mode on win32
Date: Sun, 19 May 2013 07:00:43 -0500
Message-ID: <CAMP44s32tF01P5=Go+cdh8x8m9c0c5e=SR4jpx_Zi38yQrGk7w@mail.gmail.com>
References: <1368964428-1059-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Amit Bakshi <ambakshi@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 14:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2ID-0003hc-KE
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab3ESMAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:00:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44979 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3ESMAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:00:45 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so3691914lbi.33
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=I6p7utF0Mfwksmyv3L18fUZvDzTl3RbP5ofBd2ipngA=;
        b=coxpK2diBVcpzKEVdCZeXMFDfWtvJ3U6NxNXyiDXr7LODL9J4Yr6mQge3EGJAHu6qc
         WK1msZfMLJX01lcy1pIz3CekwTtWg7q0Em2atXND+LjNCDc54YHsv8lMhh8m7F3rPW/K
         470Q0LlGyl5q1azcCREF5sdQ29J8HcN77XSBBhkS8U9jnRo4vNv0sxp7rTs0bjL/W9oi
         2ttZWz2G2vO+SDXoUY6gpEqk1zJT3DmJkMdspLtYL9bMGI50ozY5XPBrL3FFbWYhMAZg
         bdz7dG/1TdmejhHnaekIM39HcGwfLsGkyQvlXPv9ntZtFouL6p6VYtwbrZsAu9EGA7JO
         onIQ==
X-Received: by 10.152.19.39 with SMTP id b7mr5016963lae.38.1368964843717; Sun,
 19 May 2013 05:00:43 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 05:00:43 -0700 (PDT)
In-Reply-To: <1368964428-1059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224876>

On Sun, May 19, 2013 at 6:53 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> From: Amit Bakshi <ambakshi@gmail.com>
>
> git clone hangs on windows, and file.write would return errno 22 inside
> of mercurial's windows.winstdout wrapper class. This patch sets stdout's
> mode to binary, fixing both issues.

Forgot:
[fc: cleaned up]

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
