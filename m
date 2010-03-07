From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: error: failed to push some refs
Date: Sun, 7 Mar 2010 12:43:20 +0300
Message-ID: <20100307094320.GD31105@dpotapov.dyndns.org>
References: <15b345f1003061815y52a4e842u9373731cecd8ec60@mail.gmail.com>
 <20100307021848.GI2529@spearce.org>
 <15b345f1003062104p67edcde9pba7cf6000d4d7a2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 10:43:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoD1G-0007eL-Hg
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 10:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab0CGJnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 04:43:25 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:61255 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab0CGJnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 04:43:24 -0500
Received: by fxm19 with SMTP id 19so5455670fxm.21
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Pj7D45Qns0ycGtdfVuJ/nw8MGTBmCRp0NiJwYq8vuDI=;
        b=TbmI5rgN4FNhJNbx8fumnmIADfptZJxPK8n3H3KI46aii0GyU4z3UiWNKjjbVIqqPJ
         /T1Bm1k8bG9kl/T7qhfbIpzu3ciKPKvPdom93mp0LmwHuRY/iAdQzrUIdYLlRKcREOvO
         wm/zQQhXeGRakOCY1rTaf7sG6IIyyWJAKpPtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tMPn8NUc8hxrNpz/dkLS2YyapsYt1Utnt7dVxC4FWqzEn+TtbOZZreejjpp37ODusf
         8Qda9GQkIh29A068W1wzbmjfn8zDttcYfGfPi9Gew6Babt+bV49tayGVDUFgYNSX8JrH
         /6RXNHwxGMIRFQhbjOElvVEDAf+eTjsN70mww=
Received: by 10.87.70.29 with SMTP id x29mr4237569fgk.61.1267955002781;
        Sun, 07 Mar 2010 01:43:22 -0800 (PST)
Received: from localhost (ppp91-77-225-63.pppoe.mtu-net.ru [91.77.225.63])
        by mx.google.com with ESMTPS id 12sm1193855fgg.14.2010.03.07.01.43.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 01:43:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <15b345f1003062104p67edcde9pba7cf6000d4d7a2c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141619>

On Sat, Mar 06, 2010 at 11:04:03PM -0600, Thomas Anderson wrote:
> 
> How do I do "git pull" with Git Gui?

I don't know much about Git Gui, but "git pull" is an equivalent of
"git fetch" and "git merge", and it seems Git Gui got both Fetch
and Merge in its menu...

> And in any event, if there's a
> conflict, I wouldn't want to overwrite my code with the code on the
> server - I'd want to view a diff so that I might resolve the conflict
> by hand.

"git pull" (or "git merge") will produce this conflict in your working
tree, which you should resolve then and commit. (Git automatically
creates a merge commit if there was no conflicts.)


Dmitry
