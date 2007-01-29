From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git blame --progress
Date: Mon, 29 Jan 2007 17:54:41 +0100
Message-ID: <81b0412b0701290854l52d54879l1e2edbfeb1872951@mail.gmail.com>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	 <7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	 <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	 <45BCB273.7010601@lsrfire.ath.cx>
	 <7v4pqbezo9.fsf@assigned-by-dhcp.cox.net>
	 <7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>
	 <45BD40AE.9020603@lsrfire.ath.cx>
	 <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 17:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBZmR-0003Zm-6N
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 17:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXA2Qyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 11:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbXA2Qyv
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 11:54:51 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:3422 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbXA2Qyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 11:54:49 -0500
Received: by an-out-0708.google.com with SMTP id b33so714209ana
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 08:54:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iFokpQxm75DTd/qdz6T4V4GfP1S+ru1j2BiKO8UNG5NP+X8u4TzJ8T7d/a03BW8JVe6bYjo++QgIR6ceCLXlY8uwEWxGIXQrnoGQaBbeoo1xlYn9lk6/J98s/E9uvkm3CAzK81qD4rjIaHjQQ+c/KDiS4sAE56J76nUMvrPjo8E=
Received: by 10.78.171.20 with SMTP id t20mr2065905hue.1170089681669;
        Mon, 29 Jan 2007 08:54:41 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Mon, 29 Jan 2007 08:54:41 -0800 (PST)
In-Reply-To: <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38083>

On 1/29/07, Junio C Hamano <junkio@cox.net> wrote:
> [PATCH] git blame --progress
>
> With  --progress option, the command shows a fairly useless but
> amusing eye-candy while making the user wait.
>

It is not only amusing - it also gives the user a visual
information (not precise, but interesting) about something happening,
how fast is it happening and how long to wait.
I like it, even though I seldom use git-blame myself, it's the kind of
nice thing you have a fond memories afterwards.
Like the ascii graphics :)
