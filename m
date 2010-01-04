From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: RFC: display dirty submodule working directory in git gui and 
	gitk
Date: Tue, 5 Jan 2010 00:51:36 +0700
Message-ID: <fcaeb9bf1001040951r3f797750o5ebd25e93c0272ea@mail.gmail.com>
References: <4B3F6742.6060402@web.de>
	 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 18:51:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRr5i-0004Yt-Sg
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 18:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab0ADRvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 12:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130Ab0ADRvh
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 12:51:37 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:35495 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab0ADRvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 12:51:37 -0500
Received: by pxi4 with SMTP id 4so11198480pxi.33
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=J0Ez/n7zhyR8um9kjgiakqDJP8oHlxlgF9KqBM1SFDg=;
        b=gbqhMkEKq0DrSI3WsaT/GIEA6uFe19e3xK4i34I+D5tO8ptSy10Mk5Lpn9N//Tkw4J
         8mP4aBkv5Ya8sfRK+5HQsB6X/upfdfRLCI6HUFPj5oDfXB5S4irQHNTpJSg1965ECZeD
         0x7z9T89z9gt/ZYyo8ZLr6zmNMyRbofhPVxlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qxP+cvtvy0PPIgAbPPmrNMjP0Tr1/M+2UGRWYm22Rbm5hPYwVAQ+JUzK8wwyVPIpeV
         ZHif0+w+QytYBKqa9vlfi8jhbps6htW8i2SyHK5e2/KhywiZWv2wkvizWsAobGCNsNIG
         GIGqhyZtduzUKId2lCFnHcgHjU/Bn3utjZOqc=
Received: by 10.114.214.33 with SMTP id m33mr607175wag.203.1262627496655; Mon, 
	04 Jan 2010 09:51:36 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136132>

On 1/4/10, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> The real problem is that submodules in the current form are not very well
>  designed.  For example, a submodule being at a different commit than in
>  the superproject's index is not as fatal as the submodule having changes.
>
>  So in the long run, IMHO a proper redesign of the submodules would not
>  make only a little sense (it does not help, though, that those who
>  implemented and furthered the current approach over other discussed
>  approaches do not use submodules themselves -- not even now).
>
>  In ths short run, we can paper over the shortcomings of the submodules by
>  introducing a command line option "--include-submodules" to
>  update-refresh, diff-files and diff-index, though.

Incidentally I was just drafting git-super.sh it see how far it goes.
The goal was to implement some cross-module operations over time. "git
super status", "git super commit" and others could be handy.
-- 
Duy
