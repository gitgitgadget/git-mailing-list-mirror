From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] fast-import: notemodify (N) command
Date: Mon, 31 Jan 2011 22:19:14 +0100
Message-ID: <AANLkTikxFSa1CSujk2zgh4K8SWCuKHRrDRFVNt9JPGo0@mail.gmail.com>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
 <1255083738-23263-8-git-send-email-johan@herland.net> <20110131183350.GB31826@burratino>
 <AANLkTi=3P0xc3mJj5Tsg_P26SAXmgVfCk1VeYQ=k2UtT@mail.gmail.com> <20110131190128.GC32374@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vcs-fast-import-devs@lists.launchpad.net, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, sam@vilain.net,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	Johan Herland <johan@herland.net>, gitster@pobox.com,
	git@vger.kernel.org, Augie Fackler <durin42@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk1Pl-00051I-2X
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab1AaVfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 16:35:55 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42358 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab1AaVfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 16:35:54 -0500
Received: by yxt3 with SMTP id 3so2176369yxt.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 13:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=CHXeqlZtRq2V4pDcCjbBUugYZ+i7nOtNoj70KjiHBhM=;
        b=VLL0S51G5BEJDKsyzOvgKmlJX6COnodrWAdlyMzkdRKIvCKPyhMYGX2ELr2tsjP7qf
         Ikl1hrufIvEmR9IoqSh+ejMBCbHGAmggZ/1BJbzhbI0Jd25dcSiqesfM3zVoaCdgwbAL
         DaXmUbn+BPj/YtsIyetndS6N7swa6Irt6pXt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w9UHIlAEVs7MQLFaC0tbY4GqU8aoqtHCqJKxOUA7CMdG5WhAHCyI5Zxr7vnz4gfrTw
         sA1rzW4msaZKDsvGHEtgimSUSaPf2EqvgMM1CAvzf8weRsX8iigyabWy+VCrtdTmqWiA
         tafcT9+QTnBZLxjY4NZHrlaH3if/O2rR/r8z8=
Received: by 10.150.229.16 with SMTP id b16mr1422639ybh.226.1296509753822;
 Mon, 31 Jan 2011 13:35:53 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Mon, 31 Jan 2011 13:19:14 -0800 (PST)
In-Reply-To: <20110131190128.GC32374@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165757>

Heya,

On Mon, Jan 31, 2011 at 20:01, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Thanks, good to know. =C2=A0I suppose this definitely needs a feature=
 name,
> then (I'll send a patch to make it "feature notes").

SGTM.

> [Aside: I suspect part of the reason "git notes" adoption is not so
> great is the lack of git notes fetch/git notes push. =C2=A0Sample siz=
e
> of 1: I use notes heavily as a consumer, to dig up mailing list
> threads[1], but have put off sharing my own annotations until I can
> figure out how to make it convenient for others to use.]

That's another thing Augie mentioned that he (and I guess the hg
community at large) dislikes, the fact that they're not propagated.

--=20
Cheers,

Sverre Rabbelier
