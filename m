From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [QUERY] Why do we have git-completion.zsh?
Date: Sat, 20 Apr 2013 11:45:39 -0700
Message-ID: <20130420184539.GA8586@elie.Belkin>
References: <CALkWK0=NrJ-9mxSkOBw=kJ0CTJLUFNWBoGdqGcHEU6YqR-foFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 20:45:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTcnL-0006Yf-Rr
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 20:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab3DTSpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 14:45:52 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:64097 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab3DTSpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 14:45:51 -0400
Received: by mail-pd0-f171.google.com with SMTP id t12so683239pdi.2
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=e2prTBMzb5FXHLmHx/sZ0IDYN4tA3mMmnE+gy9V9ju8=;
        b=GHDDELttWCzx+LKqn4d1pwR8d0thdzWw8FNIjwfE/NDA4Ea+FOu8bjVwDZMmAgpr6y
         HkOq9MwRy35+Q3vpf6RQF2w1nPlxi77XiaCrpGeyd4Tf+5RT9rwQx60/Vn0zs7jljjFu
         u/qZ7ZH5MvhMcUvazuNrFjX1j/74eudXJAKStPme1K5WMPXnPLBGkLGMKTNevL9FZ9K5
         C5y6Lz6C+houX0Df8nFDEZlTUd1td2GpZMOWn3guZPYEzDG9NCbz0QvCrSVldP+P2asm
         C5NVdUs0fQWWKkluYvmWP72q40FBDUassrhuEEDEvGXnZdT1HUn3N+jl8S4fUO1FDKpl
         YjfQ==
X-Received: by 10.66.250.230 with SMTP id zf6mr8535868pac.153.1366483551030;
        Sat, 20 Apr 2013 11:45:51 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id t16sm18101554pbs.32.2013.04.20.11.45.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 11:45:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=NrJ-9mxSkOBw=kJ0CTJLUFNWBoGdqGcHEU6YqR-foFg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221871>

Hi,

Ramkumar Ramachandra wrote:

>                             However, I don't understand why we
> maintain it, because there's a comprehensive first-class completer in
> ZSH core [1] which I use all the time.  Shouldn't the completion folks
> be contributing to this instead?

Only if they want to.

Kind regards,
Jonathan

http://thread.gmane.org/gmane.comp.version-control.git/210022/focus=210024
