From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sat, 28 Mar 2009 09:22:22 -0700
Message-ID: <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com>
References: <22756729.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jamespetts <jamespetts@yahoo.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 28 17:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnbKm-0001wu-3O
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 17:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbZC1QWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbZC1QWj
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 12:22:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:50936 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbZC1QWj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 12:22:39 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1763937rvb.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vRZxHANZyq1K40Q+ykGCocAvRCKv/LBNYGPzCiZdQTk=;
        b=mu75rxbisY7jgXTYjZ9lC03iBBRINSgq98kYT1RQ1BWpKcCbxTRs5iJiK8qmNRuE35
         5LsgZXpC8TAqXX43Dq8AemtXQuBhpMyr7MQUARUFr/vrLzQk72bb1fFXKKBxquk3++RQ
         kBM4pb+i8umls/z0oRznPpxy7/B5h/c8Kx4DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=utLhKB2XHsrPAOaV+Rc3cnN1uEBIRIz3flA10I4+rINV8nWTO7fcYj4Fn0lRkVMudO
         g/XZr/LfisO4oQGWbSt5UQAfSkkudrGXGWYjqeuXG3bBNbi0o3QLXVdSIzw2Zo/uwge4
         GLXUGw9+RLSQ+PW1SYKJyk5pAZWJ6lc3jZPEU=
In-Reply-To: <22756729.post@talk.nabble.com>
Received: by 10.142.237.19 with SMTP id k19mr1393034wfh.68.1238257357224; Sat, 
	28 Mar 2009 09:22:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114966>

I just tried cloning this repo using the command below, and it appears
to be working just fine. (Hasn't finished, yet.  Up to rev 465.)  What
is the full command you're using when it will hang?

git svn clone -s --username=3Danon --prefix=3Dsvn/ \
    svn://tron.homeunix.org/simutrans/simutrans

On Sat, Mar 28, 2009 at 06:11, jamespetts <jamespetts@yahoo.com> wrote:
>
> For some months, I have been working on a
> http://github.com/jamespetts/simutrans-experimental/tree fork =C2=A0o=
f the
> popular open source transport simulation game, =C2=A0http://www.simut=
rans.com
> Simutrans . Simutrans uses SVN as its official VCS, but I have been u=
sing
> Git, by forking an =C2=A0http://github.com/aburch/simutrans/tree/mast=
er
> unofficial mirror =C2=A0of the Simutrans SVN on Github. That has made=
 it
> extremely easy for me to merge in updates to the trunk code whilst
> continuing to work on my branch.
>
> However, last week, the unofficial mirror on Github suddenly stopped
> tracking the updates on the SVN. I have sent a message to the person =
who
> administers it, but he has not been around for a long time, and I fea=
r that
> he probably will not reply - he did not reply to a message that I sen=
t him
> some time ago. I do not really know what to do now to keep my branch
> synchronised. I have tried creating my own mirror of the SVN on Githu=
b, but
> there are two problems: (1) I cannot for the life of me get the creat=
ion of
> the mirror to work - it gets stuck permanently at "fetching authors";=
 and
> (2) even if I did succeed in creating a mirror, it would no longer be=
 the
> same as the branch from which I forked, so Git would not be able to k=
eep a
> track of which parts of the code I intend to keep different from the =
trunk,
> and which are the new updates to the trunk that I want to incorporate=
 in my
> branch.
>
> What is the best way of dealing with this mess to try to re-instate a=
n easy
> and reliable system of taking updates from the SVN and merging them i=
nto my
> branched code?
> --
> View this message in context: http://www.nabble.com/Fork-of-abandoned=
-SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp22756729p22756729.h=
tml
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
