From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Mon, 22 Jul 2013 03:15:53 -0400
Message-ID: <CAPig+cQFpddEgkBWYb7fUtijPHCPhtjDu_=wd4br3+qXqLemjg@mail.gmail.com>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 09:16:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1ALz-0001gA-S7
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 09:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab3GVHQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 03:16:14 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36396 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752Ab3GVHPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 03:15:55 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so4893083lbh.7
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=/crUNMJK/7DFEcloqkQYS9GE1mUQ2I01C9wB1yBdbBI=;
        b=xLSQqw7ttLGcFMcR6pjoox7L9EPbgXky1pqf6wDWNY851ZSda6Gq/k0BRx5vpYzemH
         0+gPby/FLUh+ACih5Vq2kKOQXiBVldsWW6udqeCZgWbS0uGz8HQfgfOL5LJx5YLwPOPM
         kOueQ4QaZmfx+C4m9wkXElB/gr7E85mixgMZjyDPvOal17W9vbjV/NyLZU4xrhZABDTT
         r1CoNATRyyUpjJV8MWCMSVkFlFaG184x4X1hnJC7+P0wciipqBnSAUYA6B+0iZIBgdpq
         ky/p+IG2Iu6kteeepht653LF9i36YITKlnehixa+yWBnYlGF94KwMITOZqg0kxByU/wZ
         ZSZQ==
X-Received: by 10.152.87.172 with SMTP id az12mr12122138lab.24.1374477353958;
 Mon, 22 Jul 2013 00:15:53 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Mon, 22 Jul 2013 00:15:53 -0700 (PDT)
In-Reply-To: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: amc8xoVc5RgbmiETCdURpDmh8Kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230963>

On Mon, Jul 22, 2013 at 2:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * es/contacts (2013-07-21) 5 commits
>  - contrib: contacts: add documentation
>  - contrib: contacts: add mailmap support
>  - contrib: contacts: interpret committish akin to format-patch
>  - contrib: contacts: add ability to parse from committish
>  - contrib: add git-contacts helper
>  (this branch uses es/check-mailmap.)
>
>  A helper to read from a set of format-patch output files or a range
>  of commits and find those who may have insights to the code that
>  the changes touch by running a series of "git blame" commands.
>
>  Still needs to add mailmap support and other niceties but the

Trivial correction: mailmap support has been added, so "Still could
use some niceties..."

>  basics already look sound, and the enhancements can be done
>  in-tree. Assuming that "git contact" is something we may want to
>  have as a member of the official set of commands someday, that is.
>
>  Will merge to 'next'.
