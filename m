From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Definition of working directory
Date: Wed, 28 Mar 2012 15:10:52 +0530
Message-ID: <CAH-tXsCG5c-z_P-Uw7h72847e0ThfFREFVKkqcG77LuF4fQoTA@mail.gmail.com>
References: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl>
 <7vd37yj7h2.fsf@alter.siamese.dyndns.org> <BLU0-SMTP4376CA011AD4D79C1BAB727B14A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:41:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCpNt-0003ow-3M
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 11:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab2C1Jle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 05:41:34 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42823 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab2C1Jle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 05:41:34 -0400
Received: by wibhq7 with SMTP id hq7so771851wib.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9ypzXWLbSt1W0j7yyBKdr7d59Jx+Zoio3gIA3XXYm8Y=;
        b=xohkTw/cgVpVwWoiAbVdYoKw2hfLLLWY9iXE592Z+PW+PKW+lZcj1KJMUJJUB9JoFF
         7X0Uoqi49G5T04Rj2o7svVO9cTmG36dPm3jaGCbdupt+qs5LracgJMNW7G8uqCB2Y3gZ
         IoYRmeqY1OtCWsoZgMe/NVi2Pe0NSMhQySlnrMzuSC7MINd+yur7yJZsPZSHMtGCHSH2
         PsvPX/GlR2pZ898fyq1VN9GVR8ykt6BQ6i0yIYBoZixKGklDxxH/NsgZo00U/ro2KTVn
         8sC6V2b3ALeLZZjyQ0wzMbVRlg/gGr3A6cxvB4zfIo3Zbtw4UTWjk/1CgoYGOZ6+JkJp
         pkPg==
Received: by 10.216.196.29 with SMTP id q29mr4552241wen.12.1332927693049; Wed,
 28 Mar 2012 02:41:33 -0700 (PDT)
Received: by 10.227.155.6 with HTTP; Wed, 28 Mar 2012 02:40:52 -0700 (PDT)
In-Reply-To: <BLU0-SMTP4376CA011AD4D79C1BAB727B14A0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194114>

On Wed, Mar 28, 2012 at 2:56 AM, Anjib Mulepati <anjibcs@hotmail.com> wrote:
>
> So if I have a project called MyProject and inside that I have two
> sub-directories dir1 and dir2. Does that mean working directory is *ALWAYS*
> MyProject.

Yes. It is MyProject.

> Also if i create some file in dir1 and do git status without git add then
> it display untracked files as ../dir1/
> It doesn't display the untracked file name but after I do git add when I
> did git status it does give me file under changes to be committed. Why
> didn't it shows file with name as untracked in first case?

Often there will be build folders with too many unwanted files to
ignore. Unless at least a single file in a directory is tracked, git
will ignore the folder. This is afaik a good feature and not a
problem.

PS: I am not really a git expert. Please correct me if I'm wrong.

--
Jaseem Abid
+91 8891 72 43 72
S6 CSE student
National Institute of Technology , Calicut.
