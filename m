From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] Fix a bunch of pointer declarations (codestyle)
Date: Sun, 11 Oct 2009 23:56:51 +0300
Message-ID: <94a0d4530910111356x35dbb340o7779f63e7a0d0ff7@mail.gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
	 <a4c8a6d00910111353r20de1fb6u2289999491a9310a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 23:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5YS-00072k-50
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 23:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbZJKU53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 16:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbZJKU53
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:57:29 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:52529 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbZJKU52 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 16:57:28 -0400
Received: by fxm27 with SMTP id 27so8443320fxm.17
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zVKL0ErHw7c9ywZUCGwANbD6S5k4Kta7Jv7LWegpxbo=;
        b=KIVyD+qUuv1vZE3iVh/zRI8tbrlhYX/mDQyggO5D02UFSyKUIMR4lX1PVsQ/c7lCxZ
         RMV4N7HWf8qDmUf+imWbDaMRA6TeBCYNWAF2vZMkmru/5epBjP9OCND7rVlpcvCP7uYm
         CB7mA0HunIJSdYYIMl9RREpuDWWCIsmoirK0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eW0s9fHdyZXdbzL5R1OiserMcX8QF+CMfFo+Jz7PU7N8e+gTGP5rVwBnWEGKUqjwVw
         hv1bhy+455JlVa98Md6+A0YVoEvpHY/N9Wqaz1g2Z4uGkrd60tj4Qvmhkm6O/5qblRk+
         vMhxDXeX7dVKQ9MdINkLpvz/7WbEGQMzrHx14=
Received: by 10.86.227.27 with SMTP id z27mr4592341fgg.66.1255294611631; Sun, 
	11 Oct 2009 13:56:51 -0700 (PDT)
In-Reply-To: <a4c8a6d00910111353r20de1fb6u2289999491a9310a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129958>

On Sun, Oct 11, 2009 at 11:53 PM, Thiago Farina <tfransosi@gmail.com> w=
rote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
> =C2=A0"Fix a bunch of pointer declarations".
>
> But in this patch you fixed *only* one pointer declaration:
> struct diffstat_t* data -> struct diffstat_t *data

Yeah, it's a remainder of a patch I sent some time ago. I don't know
why that didn't got picked up =3D/

--=20
=46elipe Contreras
