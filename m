From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Wed, 30 Nov 2011 19:44:22 +0000
Message-ID: <CAOpHH-XQdvdPtj=bCpyFVOLOCPf6+YnEUvk2pLh4sVp0XfvLTw@mail.gmail.com>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
 <loom.20111130T155409-599@post.gmane.org> <4ED6809A.9020703@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Nov 30 20:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVq5T-0002Cc-BK
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 20:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab1K3Toy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 14:44:54 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38063 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab1K3Toy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 14:44:54 -0500
Received: by ggnr5 with SMTP id r5so986939ggn.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6F881Y5lxj6mD73jbq9UPMUkcQ/KYUi6I4bWi4Q1f7Y=;
        b=GAhbp3K+eCdMgmEWtLzn6rVoizU+0YzSFNfjAx1iE9Fmy+1C9FFVrHBc48yiBnuyFX
         0td3aG+n2cuGLm32UBwv/tMNkfPjvDzwqLtYanXiCZvA1XEZMGJ/WL4VkEZEO9X4/aSr
         x00mdg4rMoQStXoSIU8oYx4lkPLf/H0F455Fo=
Received: by 10.50.135.40 with SMTP id pp8mr4399679igb.1.1322682293359; Wed,
 30 Nov 2011 11:44:53 -0800 (PST)
Received: by 10.50.197.197 with HTTP; Wed, 30 Nov 2011 11:44:22 -0800 (PST)
In-Reply-To: <4ED6809A.9020703@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186140>

On Wed, Nov 30, 2011 at 7:14 PM, Luke Diamand <luke@diamand.org> wrote:
> OK, if you can help me understand what's going on...
>
> The label-detection bug that I've described, on further investigation, looks
> to be a fundamental limitation.
>
> With perforce, I can check out the head revision, and then tag just a single
> file. If I then check out on that tag, I get just that one file.
>
> I think I can't do that with git; certainly fast-import can't do it.
>
> So the code in git-p4 that is checking the file vs label counts (git-p4
> around line 1496) is actually trying to say "this label can't be imported
> into git".
>
> If my understanding is correct, I can then fix my test and update the docs
> and the code to explain this.
>
> As an aside, git-p4.txt currently has quite good information on the config
> variables, but nothing on the command line variables. Possibly that should
> be fixed.

Hey Luke,

I did not have any success in the few times I tried to import labels.
Since you were updating some of that code I was hoping you could
extend git-p4.txt such that I would be able to understand it. This to
say: I can't help you much with my current expertise level on how
labels are implemented. Will need to look into that later.

-- 
Vitor Antunes
