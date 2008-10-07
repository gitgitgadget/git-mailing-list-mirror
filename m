From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT PATCH] Add safeguards to Git::userInfo()
Date: Tue, 7 Oct 2008 19:28:55 +0100
Message-ID: <e5bfff550810071128r41634ac3r947c194f3749f9ca@mail.gmail.com>
References: <48EB10C8.4070009@lyx.org>
	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
	 <48EB49B3.1090509@lyx.org>
	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
	 <48EB5FAF.4080303@lyx.org>
	 <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com>
	 <e5bfff550810070955o5ea20e90jf52faf31a0ada013@mail.gmail.com>
	 <48EB9EB1.7080302@lyx.org>
	 <e5bfff550810071103j52ce2617iae2f77b9bd3fba93@mail.gmail.com>
	 <48EBA854.1020205@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:33:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnHK4-0002V9-OJ
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 20:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbYJGS26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 14:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbYJGS26
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 14:28:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:19056 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbYJGS25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 14:28:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2414436fgg.17
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8mjLtVyAUm7kBhZRjawIo/7RyKSBEBik/fFPaA42El0=;
        b=nyA3KSLiGwdMkxQPp5zLMl/ZneUseBTcL/nNHdJkcyw76BaHoEPSQ0ziHIFS//aXrx
         sk7JgOGQcVwSB97zX/QSwq9fZ0zb0mjtQl+NOZ8ykYMNctYrRwQAopRXxBz1An4JV3yJ
         CVFpyK5sBpfNpDXEmo+MT+obuaN3OPdoG/Ft4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GaZhw+GlTF84kbCPhg81c3PDg2//Eajni1LuM28TnSARcfq4Dlz84z4/OI5ohRa6ZH
         4TSLZCPouxIg0kJybPu92BA8rbKOBePupRDdTw50Ihho7e6zmgRxGxakjHt4OAzSu+gy
         gDtMQz8xYiUi4IGpltHcC/2saubp9tbWZma9U=
Received: by 10.180.224.4 with SMTP id w4mr5320486bkg.51.1223404135798;
        Tue, 07 Oct 2008 11:28:55 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 11:28:55 -0700 (PDT)
In-Reply-To: <48EBA854.1020205@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97741>

On Tue, Oct 7, 2008 at 7:20 PM, Abdelrazak Younes <younes@lyx.org> wrote:
>
> So I guess this was set by msysgit at installation time. But I see this
> variable only at the console (after typing 'set'), I don't see it in the
> user environment variable nor in the system one. So I guess the fix would be
> for msysgit to create this entry?
>

Browsing git-config docs I would think that this variable is needed so
that git-config knows where to look for the git global configs file
that is under user $HOME directory, see the [FILES] section in git
config docs.

Thanks
Marco
