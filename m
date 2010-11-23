From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 20:26:34 +0700
Message-ID: <AANLkTim72VK6SjtXSK7vAYxAS2p12=Nz73zJy+zEGCnP@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
 <AANLkTinFMn4V3c3yV6j72eqj5=v4jW7Uh3fmNDOyYjnT@mail.gmail.com>
 <AANLkTinj3ryChGKV8c6fHSD=aickmz0TMos4k0RYGKvo@mail.gmail.com>
 <AANLkTikxMXRiCYE=ny1tfrS64P0ywAHP_9eLJJzNUG3Q@mail.gmail.com> <AANLkTi=FaZ4MhJ2gDFZGiJVHsuY9jtNGgdWxX3Dq4BY6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VGFyZWsgWmlhZMOp?= <ziade.tarek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 14:27:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKstu-0006oL-3H
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab0KWN1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 08:27:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50209 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab0KWN1H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 08:27:07 -0500
Received: by gxk24 with SMTP id 24so285569gxk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 05:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zImSvdy7MVtmiN6hmExu60VN5XDirvjkkzvEfc5EgKY=;
        b=oU/t4esUzlNiPhY+NxLyr2vIcTW51UXO/1SfsF9U16chP8iTMWvhz+SD8nAJngUMXY
         yenQfHaiToPs1PpDAB6yiBXhacHnTH03Jx3ZAv0uu7w45qzUbJn/sWwXSvLJ2k7wdXCk
         Kb8m47DVx63bJ7aNssRei43BPag2RCSJ4ouB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oXm6YdaOuVYb4I0pt2lJJ7HU1Ziprpz74yW4CjPyd3db8BCkeSejzbrsVKLmGO2xi+
         Kh41HWBRmkff5eWvHx91DyOauLmuhqWRyHMBgImEv7+/58g1I3owziBwb+5p7jgr/8t8
         w7kIjWcXj06kHVH0Zdh0nFZW1s7E3lbSc2JLY=
Received: by 10.216.175.73 with SMTP id y51mr6622965wel.41.1290518825585; Tue,
 23 Nov 2010 05:27:05 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Tue, 23 Nov 2010 05:26:34 -0800 (PST)
In-Reply-To: <AANLkTi=FaZ4MhJ2gDFZGiJVHsuY9jtNGgdWxX3Dq4BY6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161960>

On Tue, Nov 23, 2010 at 8:18 PM, Tarek Ziad=C3=A9 <ziade.tarek@gmail.co=
m> wrote:
> Right. =C2=A0Overall, I guess it's just a cultural thing. Using mainl=
y
> Mercurial, "st" means for me "status" so I was surprised not to find
> it as a suggestion.

Git does not have a standard set of aliases like others,
unfortunately. You may want to set default aliases in ~/.gitconfig
like st, ci, co, di, br.. Also look around for fancy aliases like
git-lol [1]

[1] http://blog.kfish.org/2010/04/git-lola.html
--=20
Duy
