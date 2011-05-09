From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: git rebase --interactive commits order
Date: Mon, 9 May 2011 11:30:14 +0200
Message-ID: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 11:30:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJMnr-0001Iq-BG
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 11:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074Ab1EIJay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 05:30:54 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49153 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1EIJax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 05:30:53 -0400
Received: by qyk7 with SMTP id 7so792120qyk.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=fL39+pASVTaXR4jZR8d0KcA1TnoyS2xz60dVzPBlczI=;
        b=bIKZHYRsT6HhfFucfpPLnugol0SnO6V3v5wuEsVJhxHFQfhpfK2TvDY8E3PUHP6D8E
         b3kxDThzfGT6hZ4y7HqcOOgOvWZN17Gl0QWYFukEQBSOt77QR354E1BJWxr3azK2CdXi
         gtXaVhCS1ELSBZ+O1VYsWV/cCpkzf/VJl37CU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=XPArj/lMvYN4p2dNUMZEnFhKn3lyJI/Sl3ZJOZlnNEcvNceSlm4XVslBJSjR9TfiJp
         xA71Kd5Pp5xMVR54GXWBsu+MbQDHa2Rpne2iYSWKFe9ywlQ5bxiYPY+XuBZHc4mMCBZ+
         8eCjNk/dUNjYq0rgHIpQi8TtN9Sm8Mi1IZUrI=
Received: by 10.229.67.142 with SMTP id r14mr4785455qci.209.1304933453289;
 Mon, 09 May 2011 02:30:53 -0700 (PDT)
Received: by 10.229.234.15 with HTTP; Mon, 9 May 2011 02:30:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173213>

Hello,

I did try to find a similar topic in the archive, but couldn't so here I ask.

Is there an option or would it be possible to make it so that `git
rebase -i` lists commits in reverse chronological order, like it does
for `git log` ?

Almost every git commands I use lists events in reverse chronological
order (reflog, log, gitk) and then you do an interactive rebase and it
always takes me a second or two to switch mindsets and start reading
them in chronological order. I asked around and I'm far from being the
only one who think this is counter-intuitive. I understand there's an
implementation simplicity reason for it to be that way, and also that
it is somewhat logical to show the commits to be applied in order, but
as your mind is trained to read them in reverse chronological order
with the other commands I'd find it more consistant if rebase also
followed that.

Philippe
