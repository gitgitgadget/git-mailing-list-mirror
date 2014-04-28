From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 07/12] MINGW: config.mak.uname: reorganize MINGW settings
Date: Mon, 28 Apr 2014 16:58:11 +0200
Message-ID: <CABPQNSb_+hrm-avwx4Y1749C_Ak4VN5KKvso3LeFcdDPcbqS5w@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-8-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:59:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wen1L-0007Is-Cj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 16:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524AbaD1O6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 10:58:55 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:55253 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498AbaD1O6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 10:58:52 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so3305724ieb.13
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZVnYuq94jp6AfQ8W0mkfnH+yc7OY6ty0KE+ylZZe/3k=;
        b=09QIZMsSlRDiOpyI5RMNDcKta4WKL7GLTQvf6Z4Bigr06uqTvjnwhPAxAd0DCr13YY
         JOexgP8zvLAhAtN3S922jipB8GFeYlZVvCP01vOTKfKG/YLOrPuUnhtqELlH6mvrRLJk
         wr8NZLQy0gnKICT0jsIGLSP56+bgO7qKCBdnoSNJKdL1UlJnoubwetpqppQi3JhqV6A7
         VpMMkl6MU2YSCUBQmePH6CpzhhM8CIPO8VWEsjA2oMJgfdzPN04BfQmSDV/axP3GkI8n
         ww37roB+ZsbS0FV0/i1EW0AqzoTQmAY8Y1JyeQiMOXc73JRmNVkkjmXkKiQ6ZLYyXOjM
         Dc7g==
X-Received: by 10.50.85.37 with SMTP id e5mr24554250igz.43.1398697132549; Mon,
 28 Apr 2014 07:58:52 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 07:58:11 -0700 (PDT)
In-Reply-To: <1398693097-24651-8-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247349>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> HAVE_LIBCHARSET_H and NO_R_TO_GCC_LINKER are not specific to
> msysGit, they're general MinGW settings.

Actually, HAVE_LIBCHARSET_H is. It's only present because we have
libiconv installed.
