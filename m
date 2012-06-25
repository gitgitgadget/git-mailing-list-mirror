From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: security flaw with smart http
Date: Mon, 25 Jun 2012 15:10:48 +0200
Message-ID: <CABPQNSYx5cz3ZadenP7xE2+KeQRVqmwq_fehe6tC6vQqyKm_tw@mail.gmail.com>
References: <87fw9ns0cp.fsf@kanis.fr> <CAJo=hJvCC8_oFFMyc5Fkweg6A6cSV6z+UxeCkvnU34KQfYx91w@mail.gmail.com>
 <7vmx3vp2co.fsf@alter.siamese.dyndns.org> <CAGK7Mr7_a0V=Tzp9FtTjARsvSn2YOa0_GbydTrsQzxg_MJf=uA@mail.gmail.com>
 <87ipef5yzr.fsf@visionobjects.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ivan Kanis <ivan.kanis@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 15:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj94o-00049f-OS
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 15:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661Ab2FYNLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 09:11:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49718 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350Ab2FYNL3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 09:11:29 -0400
Received: by pbbrp8 with SMTP id rp8so6536412pbb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4qDBv0wyqZxh7OIYsZcCpIEEL8laRLS8VSxbdBOZPQk=;
        b=T80ytj4WeyaeV2VIHJ2/d1qcGkzfHmSOn+Goi+o2jG/dr/geEVUMyQeEHbqKeHFhso
         nmcyk1Jd0U5oAR9/nCcfh+HHqQfEqXO7n/cTEnd+ccTNdD/X6bz9y+7dc/1ttvYWWAHU
         2ZM+zoAhS2mPdOdrBrnJ+EQo1R/rn/tCcXAJTBnX1dZyAVKdKo8Fvv+zRMRifdyaEoiu
         vxNYMoJQP8IARyrvmfEACNbGEyCOv+9N8rKdJms0LpCSlSKWZ4R7pjuUJekg8unx7Rp1
         gvnUSd50pv4hUEIsNTCg3Gra0V28Yy7OoSy0idWwVdoRyYmihY2U9GAELjV5R50UiURu
         AHAA==
Received: by 10.68.201.195 with SMTP id kc3mr41277818pbc.33.1340629889163;
 Mon, 25 Jun 2012 06:11:29 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Mon, 25 Jun 2012 06:10:48 -0700 (PDT)
In-Reply-To: <87ipef5yzr.fsf@visionobjects.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200578>

On Mon, Jun 25, 2012 at 2:59 PM, Ivan Kanis <ivan.kanis@googlemail.com>=
 wrote:
> Philippe Vaucher <philippe.vaucher@gmail.com> a =E9crit
>
>>> I do not recall ever releasing 1.0.7.4, nor having smart http
>>> support before v1.6.6, by the way.
>>
>> It sounds very likely that he meant 1.7.4 no?
>
> It's compiled from a 1.7.0.4 tar ball, amusingly git --version says 1=
=2E0.7.4

Could it be that there's a typo in the "version"-file of that release?
AFAICT, the tag at github looks correct (no "version"-file, but what's
in GIT-VERSION-GEN looks correct). Unfortunately, the current official
release-archive at google code
(http://code.google.com/p/git-core/downloads/list) doesn't contain
that particular release, nor does the old official release-archive
(http://www.kernel.org/pub/software/scm/git/), so it's difficult to
tell.
