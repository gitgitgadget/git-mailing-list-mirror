From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: repo permissions repair: restore --shared=group permissions
Date: Wed, 11 Aug 2010 23:55:01 +0000
Message-ID: <AANLkTik7w6rDa=dLp=cvU8JeuCn1ZjM9ateHU8m_UQkO@mail.gmail.com>
References: <i3vbho$f5j$5@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 01:55:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjL8W-0001wJ-5i
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 01:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758479Ab0HKXzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 19:55:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48455 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758458Ab0HKXzD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 19:55:03 -0400
Received: by fxm13 with SMTP id 13so514427fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IIILI8ofCvAVQbGm6xxuEA3rJJnbRf7gGrPytvHsnpA=;
        b=nz+mFNigCLIGs1ovH7PEJxceEFLBwvB0V03jc7Qmk6kEtMLjlSx4xOHhrYbikw8Xep
         IyhLXpzo95yXwBuusgUl6Cg7gakXmxE9kyBNxJVDOLFmZq9CGckP93uO8/upQqXj65q5
         FjsZdW4F/GA8dl0tq8dh/1fibZG0wNqaheoFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lcv34R6+2HurkJtPFuQBF+Y8C3D/wVRw99dcf+wNT0fxIhGETfTF5XssjgebHPR8u7
         21PaB2Doz9UFFvp6FwY3n4Ejl2y9O6yI5vGJQblcbsoggGlNKltVzLooTlhqaVxLN48g
         5X9lhuT/StIukeUfVMg5sLDcChxSm+Zc/+uqo=
Received: by 10.223.119.136 with SMTP id z8mr20870950faq.63.1281570901726; 
	Wed, 11 Aug 2010 16:55:01 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 16:55:01 -0700 (PDT)
In-Reply-To: <i3vbho$f5j$5@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153315>

On Wed, Aug 11, 2010 at 23:24, Neal Kreitzinger <neal@rsss.com> wrote:
> chmod -R 755 was inadvertantly run on all of our git repos (bare and
> non-bare). =C2=A0These repos were originally created as --shared=3Dgr=
oup. =C2=A0When I
> run git init --shared=3Dgroup it does not complain, but it also does =
not
> correct the permissions. =C2=A0Please advise on the best way restore =
the
> permissions to --shared=3Dgroup. =C2=A0Thanks!

chmod -R g+rw ?
