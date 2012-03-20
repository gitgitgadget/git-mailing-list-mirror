From: Filipe Fernandes <ffernand.list@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 08:36:27 -0400
Message-ID: <CAA-BDhymmeQcjPuMatkDfgZzaV3h1ZHPs_t_grVn87oqGABB-w@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 13:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9yIl-0002A3-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 13:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758919Ab2CTMga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 08:36:30 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35885 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758847Ab2CTMg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 08:36:29 -0400
Received: by lbbgm6 with SMTP id gm6so4121785lbb.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=vfpZH/Y65A+8nhFlEyhjVmeelVjeOqq3yJ7XgUjRzPw=;
        b=jw2eBXyfa6myHbqzN3+M0fabUsx644AYY8zAiggYfnvJaJ0bm+sBr4O18Ez8qw7ZvI
         Z1DJhTPGA5zpm6A0TGOSvt6xSlVziGmQdj3CHNcAnk+k+2ooCpuWkENy3yPqcDBNR5fn
         YJ4GdUxYsvOeflDhc1kK4OzfYcPB5o+8ZMr+XMI/ZnWfKaAamylKmFsZY5vhKCz05mRn
         hEs7xOF7NYPc3OiLyy4V99wAS/KjQ3DujxDpJWBfweeAnNddiWPiSaGX/R6j+C0LI78A
         HRAXZNII0vwXGkJBJPqvWDE8vnmWFrusCH8z4EffLiFQnW+gzkXrPKn1h0o6yGuF+TUV
         OSzg==
Received: by 10.112.8.201 with SMTP id t9mr6168884lba.51.1332246987858; Tue,
 20 Mar 2012 05:36:27 -0700 (PDT)
Received: by 10.112.76.67 with HTTP; Tue, 20 Mar 2012 05:36:27 -0700 (PDT)
In-Reply-To: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193506>

On Sat, Mar 17, 2012 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> There is a proposal to change the default behaviour of 'git push' on the
> Git mailing list. The goal of this message is to encourage you to discuss
> it before it happens (or the change is aborted, depending on the outcome
> of the discussion).

+1 on changing the default to 'upstream'.

Having the same branch name on remote vs local repo shouldn't mean
they're necessarily the same branch (as what would be assumed with
'matching').  Also being explicit beforehand what remote branch the
local branch points to removes all doubt as it what 'git push' should
be doing for the owner of the local repo.

regards,
filipe
