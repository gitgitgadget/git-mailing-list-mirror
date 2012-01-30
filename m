From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: cleanup __gitcomp*
Date: Mon, 30 Jan 2012 05:39:20 +0200
Message-ID: <CAMP44s2pUwjvLCfjoh1kjxeBYz1v3=7A19hOZMUHgfTWkP-eqg@mail.gmail.com>
References: <1327883371-25573-1-git-send-email-felipe.contreras@gmail.com>
	<20120130024242.GA15896@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 04:39:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rri5a-0002qo-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 04:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab2A3DjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jan 2012 22:39:23 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63789 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752082Ab2A3DjW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 22:39:22 -0500
Received: by lagu2 with SMTP id u2so1955208lag.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 19:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GeGkRsmjk6ci2Dotfzy3lia7p6BGqHiY/cUNhhsLvMo=;
        b=O06UR81gGiwnWlYo29aTZsFSHdmwJ7/61JHMK2LPX7MycpYsOqkUpcheGdJeZAewpp
         Qth75FabhJVvMNiTWZfc5PiIHGR3l2tU/NlD3016X3bfti+diVIwA4daCMJOzvpAVe53
         usILSDUHgGzIdbTYOqDu+3J/L6dDNPZTOUyuo=
Received: by 10.112.99.202 with SMTP id es10mr196363lbb.89.1327894760880; Sun,
 29 Jan 2012 19:39:20 -0800 (PST)
Received: by 10.112.10.169 with HTTP; Sun, 29 Jan 2012 19:39:20 -0800 (PST)
In-Reply-To: <20120130024242.GA15896@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189320>

On Mon, Jan 30, 2012 at 4:42 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> =C2=A0* ${1-} is the same as $1
>
> | $ git log -S'${1-}' contrib/completion/git-completion.bash
> | [...]
> | commit 25a31f81
> | Author: Ted Pavlic <ted@tedpavlic.com>
> | Date: =C2=A0 Thu Jan 15 11:02:21 2009 -0500
> |
> | =C2=A0 =C2=A0 bash-completion: Support running when set -u is enabl=
ed
> |
> | =C2=A0 =C2=A0 Under "set -u" semantics, it is an error to access un=
defined variables.
> | =C2=A0 =C2=A0 Some user environments may enable this setting in the=
 interactive shell.
> |
> | =C2=A0 =C2=A0 In any context where the completion functions access =
an undefined
> | =C2=A0 =C2=A0 variable, accessing a default empty string (aka "${1-=
}" instead of "$1")
> | =C2=A0 =C2=A0 is a reasonable way to code the function, as it silen=
ces the undefined
> | =C2=A0 =C2=A0 variable error while still supplying an empty string.
> |
> | =C2=A0 =C2=A0 In this patch, functions that should always take an a=
rgument still use
> | =C2=A0 =C2=A0 $1. Functions that have optional arguments use ${1-}.
> |
> | =C2=A0 =C2=A0 Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> | =C2=A0 =C2=A0 Acked-by: Shawn O. Pearce <spearce@spearce.org>
> | =C2=A0 =C2=A0 Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Hope that helps,

I see. I'll revert that then.

--=20
=46elipe Contreras
