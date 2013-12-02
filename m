From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Please update grep in the Windows Git distro
Date: Mon, 2 Dec 2013 21:08:55 +0100
Message-ID: <CALWbr2zMfviXJfRVOUh+GgMTQZuBHAdjRdumoYG_QYmYOuUamQ@mail.gmail.com>
References: <CACAE+cGBvwVRjm8=-3e+w_xQozP1nfsphK4-ndky2yZoCoMjxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Tom Byrer <tombyrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 21:09:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnZnh-00025U-9T
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 21:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab3LBUI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 15:08:57 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64599 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123Ab3LBUIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 15:08:55 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so18727301pdi.24
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 12:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aH2hL6pD1xNUZZjOFC9024AJHMmk4uRLvzsK7bJe7Cc=;
        b=wU4nNEDVBYoLSmEt6dedx6v2imE3ehrmNT3fzQOlOOudo1io0O8QGG4HYxGbN3aYAx
         b0Aj9QHVL5N7EwIMbuHgol8/wWoCigrOu7xZo62Cjnma6BJt+a8GeHaJy7Yhdqk0y9Zi
         KWLWW0hTEnpszuizWLXrTw+wlYNawBlhI43e9DRBWk5mdIa5SIGRLX5wbhQwfAKvp9xN
         C6ERV3PrN6KbxXwUEDBykmU7hozQYPi9T0LoRkyuETwJXPHOZ0Sklt/wfl5YGnbKb283
         e8A5g1WvBNeZF3ZsNSrh0o/INfc3coc+NvC0w1yZHnGyiMpj2936AtKkjXnBlwCMVL9a
         UboA==
X-Received: by 10.68.232.3 with SMTP id tk3mr33789500pbc.121.1386014935091;
 Mon, 02 Dec 2013 12:08:55 -0800 (PST)
Received: by 10.70.93.35 with HTTP; Mon, 2 Dec 2013 12:08:55 -0800 (PST)
In-Reply-To: <CACAE+cGBvwVRjm8=-3e+w_xQozP1nfsphK4-ndky2yZoCoMjxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238650>

On Mon, Dec 2, 2013 at 8:36 PM, Tom Byrer <tombyrer@gmail.com> wrote:
> Seems that grep.exe is too outdated for some scripts:
> https://github.com/creationix/nvm/issues/75#issuecomment-13735767

-o is not an option of POSIX grep [1] and you should probably not rely
on it for portable script.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
