From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 06/11] column: add column.ui for default column output settings
Date: Mon, 27 Feb 2012 14:04:51 +0700
Message-ID: <CACsJy8DNiCfk44rQ-VWs6zzS7EYkO66baqwTUg5pL3WH6MK8Zw@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330170078-29353-7-git-send-email-pclouds@gmail.com> <7vvcmsbxvz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 08:05:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1ueL-0001HR-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab2B0HFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:05:23 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40985 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab2B0HFW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 02:05:22 -0500
Received: by wgbdr13 with SMTP id dr13so1388298wgb.1
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:05:21 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) client-ip=10.180.99.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.99.65])
        by 10.180.99.65 with SMTP id eo1mr15782456wib.13.1330326321314 (num_hops = 1);
        Sun, 26 Feb 2012 23:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4qTaddcaOgqmdSyabr8Uaq/lSCBCblZk4uiE5KUP3l0=;
        b=oIdR9q3VRb+qIt8IQG4mmYbGWT8ojX/CqoooWFN+lyjOumcyFFYnOPAbzm9xlpFn2I
         WKlGxqfzFVL/75z0Ac452f6OZkShqeayQyzY01k6ZKRVEu83GAndXYRUBzxXNlbKVJd1
         xJP2Z/XbzgdRGMqTCPovzncFvXL45y2YFb99U=
Received: by 10.180.99.65 with SMTP id eo1mr12425989wib.13.1330326321232; Sun,
 26 Feb 2012 23:05:21 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sun, 26 Feb 2012 23:04:51 -0800 (PST)
In-Reply-To: <7vvcmsbxvz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191602>

2012/2/27 Junio C Hamano <gitster@pobox.com>:
> I tried comparing output from
>
> =C2=A0 =C2=A0$ git help -a
> =C2=A0 =C2=A0$ git -c column.ui=3Drow help -a
>
> but did not spot differences. =C2=A0What am I doing wrong?

Config does not affect "help -a". It has always been sorted column
first. But yeah if you prefer row-first, then it should probably
follow that too.
--=20
Duy
