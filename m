From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 11:02:32 -0700
Message-ID: <CA+55aFwPrjtAttsH75tTGHO=14g_2GbyOtUt4eY9LPHbtcXvcQ@mail.gmail.com>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl> <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
 <7v7gxfwpc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:03:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJqGT-00009N-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 20:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab2DPSC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 14:02:56 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35130 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab2DPSCz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 14:02:55 -0400
Received: by wibhj6 with SMTP id hj6so8935040wib.1
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=/F1Hk73ZT8B38fSD4xvc+V7PBFTz1eRCK0pUourQFJU=;
        b=CnSHwZD8EB9nFhxJhQkdufdKuFxx0f6iM7kS+pMRA4SOUl9/prjcbNtc1qi9CaJ+42
         19mmHdjpHWgiq49FD2hf/CGBOaaRY16krtkiVLI+5SgoEBn7BNwFlegJnmTM/rObk2Mr
         P7qXtgwJU761/0DgAoef3CQ8F+J6/PdB2cl0iEtMqfJOxN63EhUTQIdvHbfhsKDJlsXx
         71zJevYCeYCpaO13DnDcp73uU+wXlsL43tbn4qj+bc/EXsSJX6D9m42/InMX0SMIZsTv
         qX0S2X0GAL9e2OVWuT1JK/CUIbFlPgFcNJldtc20voy+aLpz2MJ04kfWhX0LlXonyOFv
         8Rrw==
Received: by 10.180.79.72 with SMTP id h8mr21204714wix.1.1334599374541; Mon,
 16 Apr 2012 11:02:54 -0700 (PDT)
Received: by 10.216.221.167 with HTTP; Mon, 16 Apr 2012 11:02:32 -0700 (PDT)
In-Reply-To: <7v7gxfwpc8.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: nozTCR0W5L235ZL0FXjXfHE8-4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195675>

On Mon, Apr 16, 2012 at 10:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> And it seems to break 6028 ("merge -s ours" and "merge -s subtree"
> up-to-date) X-<....

Ugh. I don't even get that far - I get to t3410, which breaks.

(This is with both Michal's and my patch applied)

Oddly, running that test in verbose mode seems to imply that it's the
*rebase* that succeeds, not the merges in that test. Maybe I'm reading
the test results wrong, I didn't really try to understand the test
itself ;(

                        Linus
