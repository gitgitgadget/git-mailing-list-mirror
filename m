From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 14:53:54 +0100
Message-ID: <AANLkTims3F997XrCDN+rRnSPb=LFCU1_CCqTRj6oZyAg@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 15:54:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrAEv-0007im-Vi
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 15:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab0IBNx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 09:53:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38000 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab0IBNx4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 09:53:56 -0400
Received: by pzk9 with SMTP id 9so82046pzk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1q3zXu5Z1dIufrLXhMLLiFuwIlAF57gDP0BPGBHG3JA=;
        b=OTmrMANX34MYllutpXPhxxzwnInbVMMjAsmRxyt/aDssUOaqFp31N7rEWWgytSzq9u
         Bu/1nvMFFSX9KYQZRBl6WYimDzld5JAsN6luNvESDSBHiq8oDSddyQcePQnkoyBNPbJy
         ISHXXTUp0gNJSVhvcT6R+DU7FYl98Ma58RB+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F5jIFf1Levcbxnng3Jmu5+b09TzSnXiDPJF8JPSk7I/5JMtn/5d8Iq7UbTkujzDV1G
         ++byTGkp1fm3MTxxYJavkhSU15YWhlVKG6pw5AEvdylrMYkDKRt4lJiuHLfrXmyRJAny
         VGiEtyJGoNn+30WDHc3Jh8/ZN6ggDP/tpetJE=
Received: by 10.143.33.9 with SMTP id l9mr8157811wfj.18.1283435635100; Thu, 02
 Sep 2010 06:53:55 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 06:53:54 -0700 (PDT)
In-Reply-To: <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155128>

>> one of the reason "commit reel" was introduced.
>
> =C2=A0ah _ha_. =C2=A0i need to look that up. =C2=A0will get back to y=
ou.
>
> =C2=A0l.
>

http://www.mail-archive.com/gittorrent@lists.utsl.gen.nz/msg00032.html

=2E... nnnope.  don't understand it.  at all.  there's no context.

http://www.mail-archive.com/gittorrent@lists.utsl.gen.nz/msg00003.html =
-->

http://gittorrent.utsl.gen.nz/rfc.html#anchor7

"Service Not Available".

greeat.

http://www.mail-archive.com/gittorrent@lists.utsl.gen.nz/msg00023.html

ah HA!
+<t hangText=3D"References:">
+
+       The References are the Git refs of the repository being shared.
+
+</t>
+<t hangText=3D"Commit reel offset:">
+
+       An offset into the list of all revisions sorted by their natura=
l
+       topological order, their commit date and their SHA-1.
+
+</t>
+<t hangText=3D"Commit reel:">
+
+       A commit reel consists of two commit reel offsets, and all the =
objects
+       that are reachable from the revisions between the two offsets, =
but
+       not the revisions after the second offset.  In Git terms, a com=
mit
+       reel is a bundle.
+
+</t>
+<t hangText=3D"Block:">
+
+       A block is the actual content of a commit reel, i.e. the object=
s.
+       In Git terms, it is a pack.
+
+</t>

oh - right.... so, translating that: the concern is not that the git
pack-objects might be different (could someone pleaaaase confirm
that!) - the concern is that the order of _unpacking_ *has* to be done
in the specific order in which they were (originally) committed.

 if that's all it is, then yes, i thought that that was plainly
obvious, and had taken it into consideration already, by creating a
virtual file which contains the order of the commits.  this is
achieved merely by making the contents of "git rev-list" available.
voila, dead-simple: you now have enough information to be able to
apply the pack objects in the right order.

l.
