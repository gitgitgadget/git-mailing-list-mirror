From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 21:56:30 +0100
Message-ID: <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> 
	<fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com> 
	<7veil8iqnj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naxtj-0000ey-Qe
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab0A2U4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 15:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079Ab0A2U4y
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:56:54 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:45273 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab0A2U4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:56:50 -0500
Received: by pxi12 with SMTP id 12so1961969pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=R394ejTCvYAtfscjEpXzE9BkEwZ8OzEaVzzxExoimNo=;
        b=gp+dQKRYX+canpCDn2lTC0/Z1dsYFtudRMasmIdElj+1xWN8OVgSA4LwM3RDRkvO8I
         u21HUjoa0uGfQUEMMSUEfjOK2xbjqyRAqeq9ylsUwqoKuD5mCjk8bk/H3twhxOxrTfTi
         pmUNdzaaXJgC+geoPl7GKP6y0teRvdqjcuZZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sjX+gATItLvifHaAu3UbKWhdcFWNX+CWqDLoJ1uvGkWnBbFC7nb9vvtbMD22cjpEYA
         xIYx/rMMYECz1hQ8ewhmkYpO1o9z+LbjZn9a3ltbYsmmAiZNLLPfG5ztuh3+cKDMXJDd
         uETMdNGgFLn3jfONr2GP9W3yHMymtn1tUfxyg=
Received: by 10.143.25.30 with SMTP id c30mr884114wfj.270.1264798610075; Fri, 
	29 Jan 2010 12:56:50 -0800 (PST)
In-Reply-To: <7veil8iqnj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138355>

Heya,

On Fri, Jan 29, 2010 at 21:48, Junio C Hamano <gitster@pobox.com> wrote:
> I think "not a branch" is a good suggestion, whether the target of
> checkout is "master^" or "origin/topic".

Mhhh, for added clarity, do we want to change it to "branch name"? Since ...

$ git grep "branch name" Documentation/ | wc -l
58

... suggests that we use that in other places as well?

-- 
Cheers,

Sverre Rabbelier
