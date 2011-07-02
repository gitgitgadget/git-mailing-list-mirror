From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 01/13] advice: Introduce error_resolve_conflict
Date: Sat, 2 Jul 2011 15:14:24 +0530
Message-ID: <BANLkTik2A7K84dbeL5XkaGv8nbske=EmCA@mail.gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-2-git-send-email-artagnon@gmail.com> <20110621155555.GF15461@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 11:44:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcwkt-000343-BU
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 11:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab1GBJoq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 05:44:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40068 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab1GBJop convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 05:44:45 -0400
Received: by wwe5 with SMTP id 5so3862150wwe.1
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mj0k4gmSz8wfb8NT8xeFsTG4FkFNBXThHRPt8u30yGE=;
        b=XjhYZQO6/wYj9WLMBfZ/jAOWU5qFj4c1As3Fw404CXUsZUzSrl41OMyZE5AOrSpw/0
         ylXAIhjG0nDdW9+GfhE3kQRkQ00i3rc0oKO4Ew4ViZmflMJ13DwUCHimbOaI3V9S5Dd7
         TTlMK88yxG9jl5dYnkZwGmy6LEZ6AC3l73n2Y=
Received: by 10.216.233.211 with SMTP id p61mr3452556weq.107.1309599884085;
 Sat, 02 Jul 2011 02:44:44 -0700 (PDT)
Received: by 10.216.134.194 with HTTP; Sat, 2 Jul 2011 02:44:24 -0700 (PDT)
In-Reply-To: <20110621155555.GF15461@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176546>

Hi,

Jonathan Nieder writes:
> =C2=A02. The change is from
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: 'commit' is not possible because yo=
u have unmerged files.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Please, fix them up in the work tree ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... etc, etc ...
>
> =C2=A0 =C2=A0to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: 'commit' is not ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: Please, fix them up...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... etc, etc ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: Exiting because of an unresolved co=
nflict.

> Notice that after writing the above, a little detail jumps out:
> namely, the second "error:" line is giving advice, so it might make
> sense to make it say "hint:" instead.

How do I do this correctly?  Changing the "return error" statement to
"fprintf(stderr, "hint: Please fix them up ...")" doesn't feel right.

--- Ram
