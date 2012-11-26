From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 13:10:41 +0000
Message-ID: <1353935441-ner-9639@calvin>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Igor Lautar <igor.lautar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 14:11:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcyT0-0001ta-Ld
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab2KZNLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:11:03 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62047 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab2KZNLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:11:01 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so4454215eek.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=VF1b0Qv4CKv299srUSjM6++6hrzBEEC6PjGV/Q3mo0s=;
        b=tpqIOneEWe/eHtOkzjVxF5juEz/Xvax0Hf2LJA02AJoVZmSnh0nqFBbGaPmTiocWwV
         DuEzpJ2Sh7E+gSotGDM76Vsp1NZyVPC1yTpucvgVK/C9XujbS+xXSTS1nFFUxqmF5dsZ
         FCKrituwXL2WKVoTQk0ExYIn3f62ViI3izuiMrtq4evcc01sJczEYQ4yZlndeMM8R5N6
         mBH2JesxucUZ4awd6QbGW4ufvK5mYvMyuT4ByJ7OHxK4/wE+M9zImcWoI+dgGa1H1U+K
         zC3wBqYhbMfLnjwmSHHWOG6WIAoyEZkXsDUGSI0NE9j21S8ReSHuHyMR5iNnt0MJ6ENq
         gycw==
Received: by 10.14.208.137 with SMTP id q9mr35385480eeo.28.1353935459124;
        Mon, 26 Nov 2012 05:10:59 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id d44sm34066813eeo.10.2012.11.26.05.10.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Nov 2012 05:10:57 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id ECD0FC219C; Mon, 26 Nov 2012 13:10:41 +0000 (UTC)
In-Reply-To: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210439>

On Mon, 26 Nov 2012 14:06:09 +0100, Igor Lautar <igor.lautar@gmail.com> wrote:
> git log <file modified by commit>
>  - commit NOT shown in file history any more and file does not have this change

does `git log --full-history <file modified by commit>` show the commit?
