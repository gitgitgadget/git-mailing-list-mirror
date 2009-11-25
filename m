From: Mike Jarmy <mjarmy@gmail.com>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 11:47:54 -0500
Message-ID: <6b4a562b0911250847x59116687iba1d1640ca6c3887@mail.gmail.com>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
	 <76c5b8580911250838x361ae081n271fcee2d1234703@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 17:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDL28-0007YL-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 17:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796AbZKYQru convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 11:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbZKYQru
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 11:47:50 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:41229 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbZKYQrt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 11:47:49 -0500
Received: by gv-out-0910.google.com with SMTP id r4so753332gve.37
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 08:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jJFGDWwJH1KiVHplsJF85NtGyXj+sTWhd9fxTTBqGYA=;
        b=mofR9spRePQEYGJfQRAT+eib7xICms9duzHlqHGCKTyzgUAHQ7alGIcRe587E0pPJw
         wx6Sd9D0Vck5mgisR3vOgMWhJwTutnm+Ned7nRR58XwJ7o4nb6AQkTwYcXVtZsillAav
         FHTHyHHaT2/rDER/ofAarcYBEfrUQxb52/9C0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uHKCH83BmJVyJtT+tjBC0Ad0Pftzf2RhPEtyWukjoq9XPxLjz9MGaovz8z5BRVcbt9
         gQnzYOT4Le/o+had+yjm84Ho/0no/Xkj2CSE09IwV5GjU6Z+uFL+DmUrKGHzk7iarhfB
         ZUhW6qr2xZHeYh2JnW15iz+biAvQta5WAcumY=
Received: by 10.102.235.5 with SMTP id i5mr3467407muh.36.1259167674055; Wed, 
	25 Nov 2009 08:47:54 -0800 (PST)
In-Reply-To: <76c5b8580911250838x361ae081n271fcee2d1234703@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133650>

On Wed, Nov 25, 2009 at 11:38 AM, Eugene Sajine <euguess@gmail.com> wro=
te:
>>
>> Suppose that I checkout the v3 branch, and fix the bug by editing
>> several different files. =A0(Lets assume for now that the files in
>> question have not diverged between any of the 3 branches, even thoug=
h
>> tons of other files have changed). =A0How do I commit the bugfix int=
o
>> all of v3, v4 and v5? =A0Clearly, merging the branches together woul=
d be
>> bad. =A0So I think what I should do is perform 3 different commits, =
but
>> I'm not quite sure how to juggle the git index (or stash or whatever=
)
>> to accomplish this. =A0This may be a really obvious question, but I'=
m a
>> confused git newbie.
>
> It as not as clear for me why you think merge will be bad?
> If you commit your changes to the v3, then merging to v4 and v5 (whic=
h
> are not changed) should be very simple fast forward merge. Which mean=
s
> just move the pointer to the last commit from v3
>
> Am i missing something?

I guess I didn't explain it too well, I made it sound like v3, v4 and
v5 were still more-or-less the same.  What I'm thinking about here is
a case where we have switched to git a while back, and then done a lot
of work on the various different branches, so that v3, v4 and v5 have
diverged very far from each other.  In that case, we would never want
to merge them together.
