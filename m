From: "David Aguilar" <davvid@gmail.com>
Subject: Re: 'git format-patch' --interactive?
Date: Sun, 31 Aug 2008 02:32:29 -0700
Message-ID: <402731c90808310232r56f399y55216f7f7748ed42@mail.gmail.com>
References: <48BA1D9D.1070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ittay Dror" <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 11:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZjJR-0004kN-1l
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 11:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbYHaJcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 05:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbYHaJcc
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 05:32:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:15981 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbYHaJcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 05:32:31 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1424167wfd.4
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qnU76xy5K+dYQZ8k86KgP4yLRbY0aiV6pXycbet2Yk0=;
        b=lRjpZ0hYsJuXsvcfTWTq1lcmG+cy09wpLlQ2wYQFW7rFgE+KABs3927hkoWWwb6oee
         oWXQTvPahc81DoOtgFOcdyyKgh/blmqLC6KMbaceZToOI+SYBjxnwBiKT01HphKh7vhQ
         jOiS+K8RT2OyyXr0VddJVM6P300eM0wDmP0ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Nt6n3MiRahNJE/qPvNzEAKdVb84qkVHSJvUepw/FZChayw1bKMHNiaoNluCT0ib1AZ
         /MzUXnSwPfjQSPlSBzdRJcn9PvptfaFkchA6YIVOMqp0sXOgTnU5CZZ9I+KCfdRSlSb2
         W1nZVJApoFyYO/r8fwtZf3j5NcoS6/JqCEQKs=
Received: by 10.142.222.21 with SMTP id u21mr1664157wfg.244.1220175149646;
        Sun, 31 Aug 2008 02:32:29 -0700 (PDT)
Received: by 10.142.174.2 with HTTP; Sun, 31 Aug 2008 02:32:29 -0700 (PDT)
In-Reply-To: <48BA1D9D.1070003@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94468>

On Sat, Aug 30, 2008 at 9:27 PM, Ittay Dror <ittay.dror@gmail.com> wrote:
> Hi,
>
> Is there a way (tool) to allow me to interactively format a patch so that I
> can remove formatting noise or insignificant changes?
>
> Thank you,
> Ittay
>
> --
> --
> Ittay Dror <ittay.dror@gmail.com>
>

Yes -- get changes into your worktree (through e.g. "git apply") and
then use "git cola" to edit the index and/or worktree into a
commitable state
.
http://cola.tuxfamily.org/

You can undo or ignore specific changes to a file, which is what it
sounds like you're trying to do.


-- 
 David
