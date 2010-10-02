From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree function
Date: Sat, 2 Oct 2010 10:07:17 +0530
Message-ID: <AANLkTim7dB45mn7FqjeEpeSBM0LFp1+E3JuuQwfp5w1X@mail.gmail.com>
References: <AANLkTi=91-TJ=C1dUKRXKYWYShWZ-LuLFG3hq1Ms+C+Y@mail.gmail.com> <1285993980-28037-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 02 06:37:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1tqx-0004Sk-ME
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 06:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215Ab0JBEhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 00:37:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63452 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab0JBEhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 00:37:38 -0400
Received: by qwh6 with SMTP id 6so1907136qwh.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 21:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=QfLNhFePbnDT8IHxLtyCUvxtvQeTslSjKjaCU9j+WeQ=;
        b=OdngTbgRmnGlJR6IVlhte4BIf4FS3Cz9+vNdW8YQcur6rAvOwtr2IjxnnHVzg8lZqw
         045EV3VHG36QCh/MtEJf9UKq10OrPW3x64EVJvFD9dwTWPXjfGQGTphHN6pregpfMm5T
         N/zVW/MmBaAxfrzub9otRH3eEB9f7Xid5bcrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=wl84Sa5oEFFXmvh4mlsbkp4wTZ7lqgDr0eGrWaBKLQz5zbCMZNUn/u05yiBtkXJDPP
         oxsWbgBUvQ2prOqL3GZMHR3a2T91xdo0AWFYxRuj7CHHhfBwqWkOCv9JxoqHYejg902G
         BoZsx41z/Ug5yRo6VXBHA98f6CYuY5GYrJnPA=
Received: by 10.229.89.15 with SMTP id c15mr4602804qcm.202.1285994257491; Fri,
 01 Oct 2010 21:37:37 -0700 (PDT)
Received: by 10.229.219.85 with HTTP; Fri, 1 Oct 2010 21:37:17 -0700 (PDT)
In-Reply-To: <1285993980-28037-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157791>

Oops, please ignore the previous email- sent by mistake.

On Sat, Oct 2, 2010 at 10:02 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Write a new require_clean_work_tree function to error out when
> unstaged changes are present in the working tree and (optionally)
> uncommitted changes in the index.
>
> Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

I'll post a new revision of this patch shortly. Will post the patch to
SubmittingPatches now.

-- Ram
