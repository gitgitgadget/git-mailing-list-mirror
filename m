From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 3 Jun 2013 20:23:20 +0700
Message-ID: <CACsJy8DBLkU4h3-YAiXz-18YMmTChnRmPJFpEAEJEHhk4b-Uaw@mail.gmail.com>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 15:23:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjUjs-0006cY-29
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 15:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757761Ab3FCNXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 09:23:52 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:57401 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757615Ab3FCNXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 09:23:51 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so7107209obc.26
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h9WiuZvgm/WAccuWle9h2xymAcw9a7dwg5wi5WK0Y5s=;
        b=HOuvp5fCZ73/WA+00bjqrSxi0auJA8DDK6BkfLEHwGiQ2FuHmiyydhjX67pWQgkeQg
         aCPiZ4n4jsyAzxyS/v4E/wKOg9ROTVKJStw6YgJDYjMz9d1PF52Yqjt5XCJdcnaIB7TO
         nDTTjon/ZjF4X1NIxg3oWh7/RV/HnGYb3yzp5uaLIDuE39jJv97e/+zJnb0PDq+3J90P
         KWb46hTkVQtKVOU2qyjlG5L67SUIFLhaq4qNthm3nREeJdIo0b8v8DTmQ3mdejsa66CI
         +lNLogfihN/R8ZZd8OMBexBBnR442Vgs/JKzFQ6xbyw5QHlRDoDOho1XZmgVeVUWvWnG
         XkhA==
X-Received: by 10.60.99.10 with SMTP id em10mr9807854oeb.58.1370265830953;
 Mon, 03 Jun 2013 06:23:50 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Mon, 3 Jun 2013 06:23:20 -0700 (PDT)
In-Reply-To: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226217>

On Mon, Jun 3, 2013 at 6:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [Graduated to "master"]
> * tr/line-log (2013-04-22) 13 commits
>   (merged to 'next' on 2013-04-22 at 8f2c1de)

Should I resend nd/magic-pathspecs again now that all three topics
that cause a lot of conflicts with it have graduated? Some conflicts
(again) with pu but should be easy to resolve. The biggest one is
jc/add-2.0-ignore-removal but that's basically a code deletion, I
think you can handle it.
--
Duy
