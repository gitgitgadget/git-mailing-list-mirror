From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 3/3] remote-helpers: export GIT_DIR variable to helpers
Date: Wed, 13 Jul 2011 19:36:16 +0200
Message-ID: <CAGdFq_gAyjz+WCpK5qW7xcyGxSx4gg-A7Ju-AaHQ2o9mM_=pvQ@mail.gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com> <1310577055-6347-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 19:37:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh3Ms-0003a7-Pk
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 19:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907Ab1GMRg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 13:36:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40686 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab1GMRg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 13:36:57 -0400
Received: by pvg12 with SMTP id 12so4902514pvg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gp+VV6Ixi9+9yOhj0Sxj5kSRpwgJaIj8GJYYX99hzPs=;
        b=q659facU2Ieo7PHFyBXFyAvlpkOqOJGcA/d1LbrHuij9F1eZ8YvvwcpBpwV/ZEjD9J
         0ANhbyvD7SbkC9MLi3ZILvKnX2G55TJGmZ3W5gVVri5Uu9UvX//leVoFbUV6wp4ls9Vt
         8Vvwzy07Ef8PRKoS8lvANGS4oBLFEZP5rJDqk=
Received: by 10.68.13.193 with SMTP id j1mr1461506pbc.384.1310578616518; Wed,
 13 Jul 2011 10:36:56 -0700 (PDT)
Received: by 10.68.49.39 with HTTP; Wed, 13 Jul 2011 10:36:16 -0700 (PDT)
In-Reply-To: <1310577055-6347-3-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177064>

Heya,

On Wed, Jul 13, 2011 at 19:10, Dmitry Ivankov <divanorama@gmail.com> wrote:
> Instead of documenting capability gitdir export GIT_DIR. Turned out
> to be quite straightforward.

But you _also_ documented the gitdir capability? I'm confused.

-- 
Cheers,

Sverre Rabbelier
