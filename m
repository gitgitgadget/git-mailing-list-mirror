From: Rob Aldred <raldred@gmail.com>
Subject: Re: Issue with git rebase
Date: Tue, 14 Sep 2010 14:10:06 +0100
Message-ID: <AANLkTikVNUOC+ZfzsAJeSnxeXK_KzAnOuRPhVbmtZq2V@mail.gmail.com>
References: <AANLkTikWPkJ+8DJn5KZXfVw460HRY3Ui-xDZ_TR1X_Xg@mail.gmail.com>
 <AANLkTikUE1q-MrOsc3QOc1x0UHdLJn6nf7yGJZ=q_qqP@mail.gmail.com> <AANLkTikA7WpyiZCq43+vdUBri5X9pi3odkfRYd4jMXwR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 15:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVHR-0000Ka-2a
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab0INNK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:10:27 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51378 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab0INNK0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 09:10:26 -0400
Received: by qwh6 with SMTP id 6so4321022qwh.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3oL05cMIey88Z3tS28xYTpnGJER6l2wRrbkMyoLAYKU=;
        b=G4Aq0sr5JuT5EkavS4UCQIwmqBT2mO+H/N6dFwsWfW8YPicJ8UMVdoMBbHRbVK0Gdw
         In/3l25IKm5tyYBOH6fJXTzSYztMyfRGflOcAeGsPIocV2DalCPkXt/cqLv4arnchg9d
         vgzBvkxZt7q+yYwBootLbQeOcDjm+Lw/I/AyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MpYF2lfXJVTzapswTBJhGUEWhwTDwMZWChj1YbZCV8l5vbCXLiQDx3gK1GekExH6JU
         fx/tAwfmosccgXY4TTCIMs1o3Su8+J5E3y4ozbwOZO80ti4RnnlkGIPN65Mw83GeD6iJ
         i1gfwQw2Jm6uNWujFZ5nk4k9fm1cb2RomerdY=
Received: by 10.229.229.83 with SMTP id jh19mr4420124qcb.76.1284469826121;
 Tue, 14 Sep 2010 06:10:26 -0700 (PDT)
Received: by 10.229.72.135 with HTTP; Tue, 14 Sep 2010 06:10:06 -0700 (PDT)
In-Reply-To: <AANLkTikA7WpyiZCq43+vdUBri5X9pi3odkfRYd4jMXwR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156171>

On 14 September 2010 13:43, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail=
=2Ecom> wrote:
>
> What version of Git is this, and what does it have on git-am line 765=
?
>
> How does it look under GIT_TRACE=3D1 ?
>
> In cases like these you can extend the maximum argument list that the
> OS can take as a workaround.
>

hey, rapid reply thanks.
git version 1.7.0.3 (Mac Snow Leopard) compiled by macports
line 765 that errors is:
git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent=
 ||

hmm it seems to have worked when running it with GIT_TRACE
im sure thats didnt really fix it, very weird. it seems to have
completed successfully

Thanks for your time.


--
Rob
