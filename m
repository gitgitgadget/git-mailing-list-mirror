From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: is there an easier way to do this ?
Date: Mon, 29 Dec 2008 19:46:14 -0800
Message-ID: <8c9a060812291946w5a38d1a1iefa28679e24347bf@mail.gmail.com>
References: <gjc52u$ehc$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 04:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHVZx-00077g-PD
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 04:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYL3DqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 22:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbYL3DqQ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 22:46:16 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:26406 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYL3DqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 22:46:16 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3977434qwe.37
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 19:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bC9t5ljUi/nG7WnWFqu+YNmKXLPe2Ce73VOOX/rLyC4=;
        b=LoSxwNWEFCR1dopFMoO6sg+vrA3DK0kwOq5sMCx1z2bPnUNjR/9+1wrOFzAg2qKReu
         4NaFjgOSkGrqIamzwHlzE+kMzHKoPEFO+ucj1kGlKIVtVs1jTBPQr1OrNfQrnSejwgOg
         HQpuiE3pJgm1g9D4Oj3IzacgePvBaw0mluHhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ln87AU733o+h79XmDeQIaVWm9Vn381QjRmdGEqdEmmz+NhEMNaYgqqsy0GAeBjVWIz
         WmFLUx4Y39ACiaNta0E/nyYzvmSXMcvstB2V4ruAbg56QFhvJTs8t81tRGiixBR/P9XE
         NYbt5fuexdaswi1mlLCQUJfmu3DjokMMxe+yU=
Received: by 10.214.78.19 with SMTP id a19mr11932844qab.268.1230608774838;
        Mon, 29 Dec 2008 19:46:14 -0800 (PST)
Received: by 10.214.216.7 with HTTP; Mon, 29 Dec 2008 19:46:14 -0800 (PST)
In-Reply-To: <gjc52u$ehc$4@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104150>

On Mon, Dec 29, 2008 at 19:37, Zorba <cr@altmore.co.uk> wrote:
> ok, now I'm in this for real, archiving versions of our website project (5k
> files approx)
>
> so here is the workflow:
>
> - copy version 1 files into GIT dir
>
> - open git bash
>
> $ git init
>
> $ git add .
>
> $ git commit -m "version1"
>
> all vanilla ? cool
> next job = store version 2, so delete version 1 files from GIT dir, copy in
> version 2
> version2 has different files from 1 - which ones? Out of 5k files could be
> 1% = 50 new ones, and same amount removed. Why should I care, with such a
> powerful friend as git around, n'est pas?
> THIS TIME we are going to be CLEVER and use "-a" flag on commit to pick up
> any files that have been REMOVED (or "deleted" in git-speak)
>
> $ git commit -a -m "version2"
>
> BUT this does not pick up any new ones that have been added,
>
> and when we run
>
> $ git status > ../git_status.txt
>
> these are referred to as "untracked files"
> only problem there are 50 ish
> is there not another flag on git commit to treat any untracked file as a new
> file ?
> (would save me typing or creating a list out of these untracked ones and
> feeding them into git add)
>
> I know, I realise now I should have looked up git-commit in the manual - in
> case its not there, pls enlighten me !
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

git help add

Look at -A
