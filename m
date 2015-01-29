From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Re* git loses commits on git pull --rebase with Dictator and
 Lieutenants Workflow
Date: Thu, 29 Jan 2015 15:58:37 -0500
Message-ID: <CAPig+cTvBs3Dq3EWEJ6wYEnMJx5CRLxtDUaLZgExOUT9gtw5_A@mail.gmail.com>
References: <loom.20150128T203924-608@post.gmane.org>
	<xmqqlhkle64d.fsf@gitster.dls.corp.google.com>
	<loom.20150129T205443-493@post.gmane.org>
	<xmqqegqde3ku.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Dick <dick@mrns.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 21:58:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGwAk-0002cs-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 21:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbbA2U6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 15:58:38 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:37929 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbA2U6i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 15:58:38 -0500
Received: by mail-yk0-f179.google.com with SMTP id 142so15324015ykq.10
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 12:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RZz3xbjUXJxPcMKHwgRz9yhVPVtfiX1uaeqefxDqQ0Y=;
        b=iyapL0gklSBd1CxbWLClI8SaODYlgdDCLU5nR+YlH5ME1QKMCHAnHElD+YvPeqLJMV
         bjxcXEygmurNblm6cLbUjzNZhH0uPOZ9sqGxAkN3tXcbzynNM7wLS+YlR3vQfXsM//Hs
         G5UjgoIb3fGCOGbdoBcFlvDytPgdhRwahXUN4uY7Wu1MdR0B1hU1ScO3oJqctgSXZ2/C
         fiOIORs0TLVD4V5ki0OwFmsHdvNQNrb28Pyirf8SMSHF170VQ3GSpak+qwlSaDgH6vrX
         CtldJ3ha9rgKCfSSoV3ItDvOLj0NMet/V3kdZjbxs7vIeoJ7eLHbHhZcBHmu3ocN/p6e
         MmpA==
X-Received: by 10.236.63.6 with SMTP id z6mr1280458yhc.65.1422565117556; Thu,
 29 Jan 2015 12:58:37 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Thu, 29 Jan 2015 12:58:37 -0800 (PST)
In-Reply-To: <xmqqegqde3ku.fsf_-_@gitster.dls.corp.google.com>
X-Google-Sender-Auth: p2x8x5BejCVD8YiVlEClOXg5C-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263162>

On Thu, Jan 29, 2015 at 3:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: Documentation/git-remote.txt: stress that set-url is not for triangular
>
> It seems to be a common mistake to try using a single remote
> (e.g. 'origin') to fetch from one place (i.e. upstream) while
> pushing to another (i.e. your publishing point).  That will never
> work satisfactory.  Think about what refs/remotes/origin/* would

s/satisfactory/satisfactorily/

> mean in such a world---it fundamentally cannot reflect the reality.
> If it follows the state of your upstream, it cannot match what you
> have published, and vice versa.
>
> Some low-quality websites may be spreading misinformation.  Let's
> counter them by adding a few words to our documentation.
>
>  - The description was referring to <oldurl> and <newurl>, but never
>    mentioned <name> argument you give from the command line.  By
>    mentioning "remote <name>", stress the fact that it is configuring
>    a single remote.
>
>  - Add a reminder that explicitly states that this is about a single
>    remote, which the triangular workflow is not about.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
