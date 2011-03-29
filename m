From: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>
Subject: Re: Translation inclusion criteria
Date: Tue, 29 Mar 2011 16:24:38 -0300
Message-ID: <4D9231F6.80205@gmail.com>
References: <4D889CC9.4060603@gmail.com> <1301417951.13114.7.camel@drew-northup.unet.maine.edu> <7vhbalrbwi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:25:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4eXB-0001AP-2F
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 21:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab1C2TYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 15:24:44 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34341 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab1C2TYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 15:24:43 -0400
Received: by vxi39 with SMTP id 39so439054vxi.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=e3uBY16zxvfEOaaYEF1xwCQwBs767JmgPZ6ke+pm03A=;
        b=SAW6o0hMG47638lJLGULF4H/ztgMicPJxkOz17KK/bijPE/c1fpo3B9Bt2T4aeNR8e
         8/MWowGR1JNwvGXDv9L8Vt2Pp4Nen5slbmzYG6Jj7VNc0b7mKqVGjO2iu6xIFhOx7adF
         PXneTg9P3jCFe/RGkuhn9W2JLzyqYtuSc24Do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=it8Rr9rm3OYjRw9GZZ75+Fsuu+bd8w3ZnhmPta2LPtubWM/wtqnZJYoj9tfOiqOIgQ
         pQLXh3fIRrjCT7BjuQyYWET3RwuZAard/pPHiywdjXXV9wVmpB3FrZY03a5hvDVLkNx7
         Rv40nzkzKdouBWGnSihXEcZRGsq44uqrVpu4E=
Received: by 10.52.67.146 with SMTP id n18mr245370vdt.232.1301426682777;
        Tue, 29 Mar 2011 12:24:42 -0700 (PDT)
Received: from [192.168.2.236] ([187.59.230.209])
        by mx.google.com with ESMTPS id j15sm1077149vcs.20.2011.03.29.12.24.40
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 12:24:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100918 Icedove/3.1.4
In-Reply-To: <7vhbalrbwi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170312>

  Em 29-03-2011 15:59, Junio C Hamano escreveu:
> Drew Northup<drew.northup@maine.edu>  writes:
>
>> On Tue, 2011-03-22 at 09:57 -0300, Rodrigo Rosenfeld Rosas wrote:
>>> Hi, I've followed the instructions in git-gui/po/README in 2008 but
>>> pt.po was never included in master. Now I've just updated it.
>>>
>>> Is there anything else I should do for it being merged to master? W=
hat
>>> is the criteria for including new translations?
>> ...
>> Rodrigo,
>> Internationalization of Git is very much an ongoing process. I suspe=
ct
>> that has something to do with the uptake of your contribution. =C3=86=
var may
>> have more information.
> All the git-gui changes come through Pat Thoyts these days; =C3=86var=
 has
> nothing to with git-gui i18n/l10n (except perhaps as a translator to =
his
> own language, but I don't see his name in the shortlog).
>
> Perhaps the submission was sent with wrong Cc:; I don't pay attention=
 to
> git-gui and gitk l10n patches myself.

Sorry, I think I'm missing something. From the mentioned README, it=20
seems we're supposed to push our changes to the mob branch of=20
mob@repo.or.cz:/srv/git/git-gui/git-gui-i18n.git/, which has write=20
access enabled for everyone.

That's what I've done. I couldn't find any mention in the README about=20
having to send some mail after that.

I'll wait for instructions from Pat Thoyts to understand better what=20
should be my next step...

Thanks,

Rodrigo.
