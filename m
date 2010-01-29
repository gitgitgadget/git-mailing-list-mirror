From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:21:55 +0100
Message-ID: <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> 
	<fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com> 
	<7veil8iqnj.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayII-0003SZ-My
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab0A2VWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 16:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183Ab0A2VWR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:22:17 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:43139 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab0A2VWQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 16:22:16 -0500
Received: by pzk28 with SMTP id 28so1874655pzk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GSTvowFWPZ6FFtvdcWO5aTyKGHRtjIkem6SYrVhmz9U=;
        b=vYtBOBVAq/doMgLdZga9OR0iT+L/3Mx8frhV3XYaAgHKakrZe9jhXl2Hjs/z71qjDD
         iLQgtTN6BS0O6qaI21Vkf2od1kUC61l7ZXsQtTokwEEkznvwFaziiTGOMGVK21LcpM29
         bOtK1asa8KUs0wFa8uu75xk4riZ9FZsvirmRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KvdLG4NcF9/x7p9+LmC6gVwuOP9N7p/Fg+iM6xGz7NmflEhBWY/C/1jEnw5NjpbX8T
         EuHQyWO+pzQeG9F5tFl9Z0pa5v53QUotUcVK5liUtSFLHB3e8CbxMpWXZ1n0kXZPUxNH
         8SKHjJsAi2QGwNUSwD0nHc2gdWneiKnqVCRwo=
Received: by 10.142.247.38 with SMTP id u38mr902150wfh.277.1264800135095; Fri, 
	29 Jan 2010 13:22:15 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138362>

Heya,

On Fri, Jan 29, 2010 at 22:20, Nicolas Pitre <nico@fluxnic.net> wrote:
> With all due respects, I don't share Dscho's sentiment about Git's
> alleged non user-friendliness. =A0And I always praised Git's ability =
to
> use a detached head to check out a remote branch, and never had any
> problem teaching this concept to people. =A0So the above is not a UI
> improvement at all to me.

I think 'git checkout origin/master^0' still works?

--=20
Cheers,

Sverre Rabbelier
