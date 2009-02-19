From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH 1/6] Modify description file to say what this file is
Date: Thu, 19 Feb 2009 10:18:33 +0000
Message-ID: <43d8ce650902190218v513b8f58n8338086af41b79d9@mail.gmail.com>
References: <200902190736.00462.johnflux@gmail.com>
	 <7vy6w2n3cz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La60i-0003zf-Er
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbZBSKSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbZBSKSf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:18:35 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:30692 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbZBSKSe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:18:34 -0500
Received: by yx-out-2324.google.com with SMTP id 8so124444yxm.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 02:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ipsETJdfG+AMCssvndzaQ4l+OZ04oWuQR2U/aOwztzk=;
        b=LosXpCwYn7h/uEbtA1Rg3wXlFjFGJb1crEDykbTA49YMtYHPYY1bca+xX5ytMgonpF
         7K5F7fnL3t7aUxcrB9X4L/Ff8ubP6br5A+3uiHVa70RgW1wdkG89VKplE5MyHcP23YBH
         jH+koiv+HTK9B/O6PR8OiPD/3C0Y65DXF+xAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aHeFlmjRDrZka5F6oXJP2xTU4NGmRin1jm7JMN6qgf/nwd/fB31jDlxVQyuMJwBBEo
         H+mxDMVFP/H2HOzMAUI7xDgpMKEUKmgzwgEWaKpXMgpCap8Bhd9hC0O4v915ANxBMF7c
         BAJDH0QGFb3vBFtb23Y7tjvASdy8kSCwaLFms=
Received: by 10.150.11.14 with SMTP id 14mr824027ybk.180.1235038713519; Thu, 
	19 Feb 2009 02:18:33 -0800 (PST)
In-Reply-To: <7vy6w2n3cz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110667>

2009/2/19 Junio C Hamano <gitster@pobox.com>:
> [PATCH 1/6] Modify description file to say what this file is
>
> Looks good.
>
> [PATCH 2/6] Google has renamed the imap folder
>
> Jeff already pointed out an obvious thinko; I could fix-up locally (just
> ask).
>
> [PATCH 3/6] Improve error message for branching an existing branch
>
> The extra sentence is useless noise to annoy users and make them shout
> "none of your business!" back to git.
>
> I would probably get this error message "already exists." more from
> forgetting to say "-f" in this sequence:
>
>    $ git branch -f pu next
>    $ git checkout pu
>    $ sh rebuild-pu-script
>
> to rebuild pu on top of updated next, and "did you mean to checkout?"
> misses the mark by a kilometer.
>
> [PATCH 4/6] Improve error message for git-filter-branch
>
> Looks good, with Sverre's rewording would be better, which I could locally
> squash in.  Needs signoff, which I could locally forge (just ask to fix-up
> and forge).
>
> [PATCH 5/6] Change output "error: " to "Error: " etc
>
> Jeff is right, and the patch is wrong.
>
> [PATCH 6/6] Mention to the user that they can reorder commits
>
> The placement of the new message does not feel right, as adding anything
> near "If you remove ... WILL BE LOST" will cloud out that message which is
> more important.
>
> I think it should come near or perhaps even before Commands, if we were to
> add anything here.
>
> But I am afraid that the proposed new message will hurt the clueless users
> more than it would help them.
>
> The cheat-sheet at the top is not for learning what the command can do for
> the first time.  It is there to remind people (who already have general
> idea on what can be done) how exactly the commands are spelled.  If
> somebody does not even know that the purpose of rebase-i is to amend and
> resequence, he will more likely destroy his history by blindly using the
> command without knowing what is going on, than making a lucky guess.
>
> For that reason, a more appropriate line to add, if we were to add
> anything, might be:
>
>  #  s, squash = use commit, but meld into previous commit
>  #
> +# If you do not know what is going on, remove everything and exit the editor!
> +#
>  # If you remove a line here THAT COMMIT WILL BE LOST.
>  # However, if you remove everything, the rebase will be aborted.
>
>

Junio,

  Thanks - I like everything you said.  Could you go ahead and commit
the accepted ones, with all the fix ups mentioned?

Thanks!

JohnFlux
