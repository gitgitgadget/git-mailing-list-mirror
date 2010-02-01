From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 5/6] revert: add --ff option to allow fast forward 
	when cherry-picking
Date: Mon, 1 Feb 2010 13:43:57 +0100
Message-ID: <c07716ae1002010443p4e0443feke14e5f877584640f@mail.gmail.com>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org>
	 <20100201075542.3929.35967.chriscool@tuxfamily.org>
	 <4B66B68C.7050505@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 13:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbvdq-0001qY-86
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 13:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab0BAMoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 07:44:01 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:33061 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab0BAMoA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2010 07:44:00 -0500
Received: by fxm20 with SMTP id 20so4174808fxm.21
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 04:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=USt5RfI7NL9u6K5DHF5X9bwkWaffI02z93luQAmaQWs=;
        b=qRsPIDcSdUIUkD0yuHPxm08hZ78nJfIfjDk+W1WxKwYhl6jiz9JawnYiWtNNx2fAI/
         fGgMgvAWd0uMhQibKmwXguEhmVoKUz04tCj9zc3JUpt/Lkw6DjLn8RipeKdLsBp/KKZB
         5NF+KJaDbUjKeTb+M8GA9pawxov52CHmCukc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qm4d6w2wwNwdoWbxzjW5XYVYXfHn82ihru6+C+t+4txcRKJayruX36O6yD7HgbtBas
         VZzlmZKFFVUwKwDzcuWRWhSx5nMW/k9j4uI52jno/j2IPSyPhnXrQ7W0By3L3SCp4/Dh
         xFL/E5W0FP5TbR0WrCIpDsi8lxlwEQ0hjswBQ=
Received: by 10.102.214.19 with SMTP id m19mr2223604mug.96.1265028237841; Mon, 
	01 Feb 2010 04:43:57 -0800 (PST)
In-Reply-To: <4B66B68C.7050505@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138606>

On Mon, Feb 1, 2010 at 12:10 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OPT_BOOLEAN(0, "ff",&ff_ok, "allow fas=
t forward"),
>
> Why should this not be the default?

Maybe it could be the default, but in this case it should be made
compatible with -n option
(and perhaps other options) for backward compatibility, and this would
probably need more
involved changes.

Thanks,
Christian.

> Instead, you'd add --no-ff. =A0This would
> simplify 6/6 further, like
>
> =A0eval sha1=3D\$$#
> =A0...
> =A0output git cherry-pick "$@"
>
> Paolo
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
