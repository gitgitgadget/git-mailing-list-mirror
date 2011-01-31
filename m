From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Vcs-fast-import-devs] [RFC] fast-import: notemodify (N) command
Date: Mon, 31 Jan 2011 19:48:23 +0100
Message-ID: <AANLkTi=3P0xc3mJj5Tsg_P26SAXmgVfCk1VeYQ=k2UtT@mail.gmail.com>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
 <1255083738-23263-8-git-send-email-johan@herland.net> <20110131183350.GB31826@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vcs-fast-import-devs@lists.launchpad.net, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, sam@vilain.net,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	Johan Herland <johan@herland.net>, tavestbo@trolltech.com,
	gitster@pobox.com, git@vger.kernel.org,
	Augie Fackler <durin42@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 19:49:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjyoZ-0005Mw-M7
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 19:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab1AaStG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 13:49:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49274 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab1AaStE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 13:49:04 -0500
Received: by yxt3 with SMTP id 3so2108668yxt.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 10:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=y4OlkoIzuwoGHFH05Ovt+ElSXLR1kCPBD1J7Gweo4I8=;
        b=xLYcoj3GFZf/ADQyQ9dxwdSt6rxxzQih3dEpZoaozqP8CwtUIlg70q+82zBS7hGiSq
         kRyBsP+fTIpywk8MPEIQv+BfMpW0dgazn8FWcLnQsoFksgcvHeTmVyFYf9bAxaywj2Rm
         oiUOyXNUBY18K2SR8YlAhELa99rlR9pHXwYq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c6xL8pD53rmFSFLLtW+0WF/aroFdaM00rcKRa4IsOUOqj4T31E2WmLXYXXHuRvgMdZ
         +JPMxL082x+Mv5hEhhAbepf8dvf/fgPJIAYYWVfHbgJMiNgqY8hxfw6V4sQ/JjhLiGBG
         yjVj6mA22lJFPHNIMUzfJtiUR4rLheidCSgXg=
Received: by 10.151.45.17 with SMTP id x17mr8043315ybj.304.1296499743760; Mon,
 31 Jan 2011 10:49:03 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Mon, 31 Jan 2011 10:48:23 -0800 (PST)
In-Reply-To: <20110131183350.GB31826@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165740>

Heya,

On Mon, Jan 31, 2011 at 19:33, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Most DVCSes do not allow one to non-disruptively change the log
> message for a commit. =C2=A0But sometimes people want to attach infor=
mation to a
> commit after the fact:
>
> =C2=A0- whether it was tested and worked correctly
> =C2=A0- who liked or disliked the commit (Acked-by, Reviewed-by)
> =C2=A0- corresponding revision number after export to another version
> =C2=A0 control system
> =C2=A0- bug number
> =C2=A0- corresponding compiled binary

I talked with Augie Fackler (from hg) about this on IM and he says:
> We don't support anything like that at present (no demand, when we ch=
eck
> nobody really seems to use git notes for anything)
> so it doesn't seem relevant in fast-export

So at least HG doesn't (currently) have any functionality that they
could use to implement the importing of such a stream.

--=20
Cheers,

Sverre Rabbelier
