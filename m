From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2012, #08; Thu, 26)
Date: Fri, 27 Jul 2012 09:10:51 -0700
Message-ID: <CAOeW2eFy__AaPWBBST3rj4FTAzvew7-BWPLhnAM7UxtcbBspLQ@mail.gmail.com>
References: <7vy5m520s1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 18:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sun7y-0004vb-Fk
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 18:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974Ab2G0QKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 12:10:53 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44553 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab2G0QKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 12:10:52 -0400
Received: by pbbrp8 with SMTP id rp8so5210625pbb.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N8sf2N82C08K5iG/6czKws/6Nb8dtoyfP+h202xisqo=;
        b=OgOxHmhlBPL4orgHwhyEPAgynOCbf5/cjAIxCiFpEzmVpdWH67Td/9zEBHrfTrvkKb
         IVm1nK6Md3rsR5Mh+oUj0oo/NIEN8sUdV4b1O3pbb5u9Kn+1wGPpSltZVZv4FnlXwknW
         YeNI3kExjcQ8U5TuNrA0sVL7LyfXk3LkcRNTEU4ZPWAfZiTG41F1k2WaPubgSn+feisU
         xIMjlrz6nq3KX8oUeBQetQi+ChZZ9IRysRLaWIQgKjxV0AhFBcEww+ibyIvXMWB1IIvb
         djQ6QT7YP0WkOD7ywoOIEhl+vrlfw4Ci8QXBL8rljfoXOqdiLAK2aTNX1CZVXn4o3G8u
         nc3Q==
Received: by 10.68.234.6 with SMTP id ua6mr15137605pbc.117.1343405451880; Fri,
 27 Jul 2012 09:10:51 -0700 (PDT)
Received: by 10.68.42.164 with HTTP; Fri, 27 Jul 2012 09:10:51 -0700 (PDT)
In-Reply-To: <7vy5m520s1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202358>

On Thu, Jul 26, 2012 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * mz/rebase-range (2012-07-18) 7 commits
>  - rebase (without -p): correctly calculate patches to rebase
>  - rebase -p: don't request --left-right only to ignore left side
>  - rebase -p: use --cherry-mark for todo file
>  - git-rebase--interactive.sh: look up subject in add_pick_line
>  - git-rebase--interactive: group all $preserve_merges code
>  - git-rebase--interactive.sh: extract function for adding "pick" line
>  - git-rebase--am.sh: avoid special-casing --keep-empty
>
> Expecting a reroll.

Yep, will try to get some time for this soon. Will probably try using
patch-id as you suggested.
