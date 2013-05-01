From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #10; Mon, 29)
Date: Tue, 30 Apr 2013 20:48:39 -0500
Message-ID: <CAMP44s0AWOH+X5oBV0fY1zh5m+nXJknjOMJpmjJK0=7BGteb3A@mail.gmail.com>
References: <7vppxdgife.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 03:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXMAC-00089Q-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934000Ab3EABsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:48:42 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:42582 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833Ab3EABsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:48:41 -0400
Received: by mail-la0-f47.google.com with SMTP id em20so999591lab.34
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mk0C8N723BEEmTGURbgO92v3VNrjq7h3udLPJg7sdg4=;
        b=NKD2aS3VB8mf++E3tDQC4rVemPTVumgscliSB3DpFKJVrWja5tpAOzdxx+AeQrQh98
         cIF32wci4dxrDxkwGjA/PA/0Bdy7UYDsckUg2QnVDB3IxWB166nEPBk9ZLkcJ8vq5guw
         gJHP3G9SfWfBs+m4q6kpHkO1za04fdcFuQSa4Nm0ck853ThDZlbVng5N8UUwEEjFzjGZ
         BjlnJGJtieQZwSJyBYJaCqXaPchmDSjZfVplUKYEMuW5/kSYOQbP2KoHwV/MeR3ylTYh
         1wbBJXQ4Nh4IaKbNgNtwD+WxRObQ/G8HTDiEu2rjm7nlspS6zDc6UdDLy4AHFr758WHm
         cs6A==
X-Received: by 10.112.135.70 with SMTP id pq6mr493036lbb.82.1367372919951;
 Tue, 30 Apr 2013 18:48:39 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 18:48:39 -0700 (PDT)
In-Reply-To: <7vppxdgife.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223063>

On Mon, Apr 29, 2013 at 4:01 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/transport-helper-error-reporting (2013-04-25) 10 commits
>   (merged to 'next' on 2013-04-25 at 3358f1a)
>  + t5801: "VAR=VAL shell_func args" is forbidden
>   (merged to 'next' on 2013-04-22 at 5ba6467)
>  + transport-helper: update remote helper namespace
>  + transport-helper: trivial code shuffle
>  + transport-helper: warn when refspec is not used
>  + transport-helper: clarify pushing without refspecs
>  + transport-helper: update refspec documentation
>  + transport-helper: clarify *:* refspec

>  + transport-helper: improve push messages

I wish this commit wasn't blobbed with all these others, it has
nothing to do with them, and in fact, it probably has enough merits to
be in 'maint', since without it, each and every fetch from remote
helpers will show up as 'new branch' for the user.

>  + transport-helper: mention helper name when it dies
>  + transport-helper: report errors properly
>  (this branch is used by js/transport-helper-error-reporting-fix.)
>
>  Update transport helper to report errors and maintain ref hierarchy
>  used to keep track of remote helper state better.
>
>  Will cook in 'next', but may be 1.8.3 material depending on how things go.

-- 
Felipe Contreras
