From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree issues
Date: Wed, 4 Nov 2009 14:57:06 -0500
Message-ID: <32541b130911041157i5125cc41pdceaa39fa5ceba67@mail.gmail.com>
References: <26159961.post@talk.nabble.com> <32541b130911030743i4dcd9e37q34ead6a4a9a9814c@mail.gmail.com> 
	<bdccb6a00911031019y48f1d1aax9be7b49e3463595@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Jacobs <daniel@sibblingz.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:57:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lyz-00046c-PP
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088AbZKDT5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 14:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbZKDT5V
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:57:21 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:53187 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758045AbZKDT5U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 14:57:20 -0500
Received: by ywh40 with SMTP id 40so6654212ywh.33
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IMzFluC5GLDGnAQqdna1KFqJTyEL6HG0eVIPa4XhJSI=;
        b=iMVFRAsw06uZMi/+Ak1eUFF6ydBs/nFmTZNwREuM62WRfjTwShH0/EhBTAmvAvWvb5
         66sGOPUvly/6d1vvrsEjtEZDtsRMjAc/MCEawgYwl4cx8QxFQrOX6ZROVgOaoKVm00Vu
         KFv2ny6ESZHMb08g2GgkvzhF2mXMtFEuo6YXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rV0fe/1asRhWl+EJhkw/g+wnPcEzBFPUE7wictMsyjZ2appfrp8/o0eNIb5XX0c3X9
         MP/GZVv4OZGLWmxC0QyzQkm+V/bUhVwGDqOzMNate1XdCBwjsCjpTEBbR+xaYz6/PaAK
         iPCn+v976xbWhGIvoGCafDQzgLobE2jHsumJ0=
Received: by 10.150.44.28 with SMTP id r28mr3510311ybr.36.1257364646066; Wed, 
	04 Nov 2009 11:57:26 -0800 (PST)
In-Reply-To: <bdccb6a00911031019y48f1d1aax9be7b49e3463595@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132137>

On Tue, Nov 3, 2009 at 1:19 PM, Daniel Jacobs <daniel@sibblingz.com> wr=
ote:
> Ok.. I ran the command as you suggested
> git pull -s subtree vw_extensions master
> remote: Counting objects: 5, done.
> remote: Compressing objects: 100% (3/3), done.
> remote: Total 3 (delta 2), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From git@github.com:sibblingz/vw_extensions
> =A0* branch =A0 =A0 =A0 =A0 =A0 =A0master =A0 =A0 -> FETCH_HEAD
> Already uptodate!
> Merge made by subtree.
>
> git diff --stat $(git merge-base HEAD^ FETCH_HEAD) FETCH_HEAD
> =A0README | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
> So, it knows there was a change. =A0However, when I go and vim that R=
EADME
> file, the change is not there. =A0Maybe this gives you some more info=
rmation.

This is extremely fishy.  What if you re-run the pull without the "-s
subtree" at all?  git must be trying to merge those changes in
*somewhere*...

> As an aside, I saw your git subtree tool, and it looks great, but I d=
id not
> try to use it because I could not figure out how to install it. =A0Yo=
u might
> get a few more users if you include instructions for installation som=
ewhere.
> =A0:-)

Oops, good point.  Somehow I forgot that.  Fixed.

Thanks,

Avery
