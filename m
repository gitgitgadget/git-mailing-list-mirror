From: Thore Husfeldt <thore.husfeldt@gmail.com>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Sun, 24 Oct 2010 16:47:54 +0200
Message-ID: <9A09AA7C-BAE2-4571-8453-17CB3F3256D4@gmail.com>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr> <1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Oct 24 16:48:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA1rg-0001AK-6h
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 16:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914Ab0JXOr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 10:47:58 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55142 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0JXOr6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Oct 2010 10:47:58 -0400
Received: by ewy7 with SMTP id 7so3415718ewy.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=bK5JvNrj/CfUDnTj3Em6dyPRXoPcFYFhCT8U+WFghBA=;
        b=M/sWrg0ZgbvFQas6f5GVy3WSGr7ZrCH7RpcFj1O6us//yVTXsj1UuAmL4A1IoJQleg
         1YXTqSqcmIR+qOH1ZheZ+DoAwyuquE4MQGNW1pXuS9ypZOA8YR0ahhRVqoa1FmJmQjm4
         Xtrl5dSnAqe4zoWtp7gFRcBAVgACRMmuHnjmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=f5fSpScYQ+jVvUXeII6W8tMc3yiS8cYWyPaNhnu2YljqUsUv3TKx2VWjNfYMry2r5L
         HblKMosYaNkxe3kutrRJfXJrxmmgBuZg5KiQkjFjQFJOfZFWYojVt8ndM1SH0gemyrkE
         PPFXzWuV0yBuTahrvZ2GmKsDeoynWX9L//Yf4=
Received: by 10.213.13.80 with SMTP id b16mr1097848eba.89.1287931676702;
        Sun, 24 Oct 2010 07:47:56 -0700 (PDT)
Received: from [10.0.1.4] (h51baf259.k2290.dyn.perspektivbredband.net [81.186.242.89])
        by mx.google.com with ESMTPS id x54sm6188179eeh.23.2010.10.24.07.47.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 07:47:55 -0700 (PDT)
In-Reply-To: <1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159877>

On 23 Oct 2010, at 18:31, Matthieu Moy wrote:
> Documentation/user-manual.txt |    9 +++++++++
> 1 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manua=
l.txt
> index d70f3e0..02126f1 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -359,6 +359,11 @@ $ git branch -r
>   origin/todo
> ------------------------------------------------
>=20
> +In this case, "origin" is called a remote repository, or "remote" fo=
r
> +short. The branches of this repository are called "remote branches"
> +from our point of view, and Git will maintain a copy of these
> +branches, called "remote-tracking branches" in the local repository.

No. Git does not =93maintain a copy of [the remote] branches=94. It=92s=
 exactly one of the pitfalls I fell into: that Git, automagically, puts=
 the *current* state of the remote branch into remote/branchname, or at=
 least updates it behind my back whenever it gets the chance. The Pro G=
it book goes as far as saying =93they=92re moved automatically whenever=
 you do any network communication,=94 which is extremely misleading. (A=
nd then it goes on: =93Remote branches act as bookmarks to remind you w=
here the branches on your remote repositories were the last time you co=
nnected to them.=94 This is a good way of saying it, except that =93rem=
ote branches=94 should be =94remote-tracking branches,=94 and =93connec=
ted to them=94 could be more concrete.)

I appreciate that this misunderstanding looks ridiculous in hindsight=97=
it does to me, today. Luckily, I kept a copy of my old brain in thore/o=
ldbrain and try to not fetch to it.

Also note that the two following lines in user-manual.txt are plain wro=
ng (=93You cannot check out these remote-tracking branches, but you can=
 examine them on a branch of your own, just as you would a tag=94).

I realise that it would be more constructive for me to suggest a concre=
te improvement, but I=92m not quite there yet. I would really like to s=
ee a good conceptualisation, with strong, versatile verbs, of the relat=
ionships between bobsstuff bob/master and Bob=92s master.