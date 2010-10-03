From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: remote-bzr status
Date: Mon, 4 Oct 2010 00:37:25 +0200
Message-ID: <AANLkTimbsxUJbZsadCxiw9MpicaND5g3db6fx=QtzaEY@mail.gmail.com>
References: <4CA8F2F1.5090407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 00:38:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2XCO-0001v2-KP
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 00:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab0JCWhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 18:37:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50639 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab0JCWhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 18:37:46 -0400
Received: by iwn5 with SMTP id 5so6142813iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=jt34cDLsE/Iw1c625jn1TKCqvSDH7OR14QWNvadsEyU=;
        b=UnGXGcNye5smDrPPI01ZXz7Xv+C2uTBJHs17Nk6GQ8i4E+yQ7FwrICwxHx8HCYgP3x
         0ud2DBzKD15v97Wi1AeznD7OX24/BvGnjau1fZUS9L5AJMOtsYWbZ7L6dZzD6no44TMW
         miCMPhewqDs7Q3tjcWR7VZdGDBF6Ruyz0rIXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=K1Mwn+rvjgWSOuOT/zDon96+FEE0Ku8H5Kzg2f45G0N4+LrksT1T/N4cnpsLtbHeMr
         qNEhLQ6+CiQLbIKvBxzdq2KJavC9EEO2gtR3d9AO8A3hQgdsjvCqvw/SLlvHsc+7RIg1
         wdiS7OgakOkoO00OBeh4hH8qx+PA5iGLMFwNU=
Received: by 10.231.174.65 with SMTP id s1mr9113333ibz.153.1286145465470; Sun,
 03 Oct 2010 15:37:45 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 15:37:25 -0700 (PDT)
In-Reply-To: <4CA8F2F1.5090407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157940>

Heya,

> The remote helper code was done in python (mostly based off of Sverre's
> remote-hg code) and relies on the "bzr-fastimport" tool. It can be found
> on my github repository:

Glad you found my code helpful :).

> - It is possible to push changes back _but_ only in some situations. The
> "bzr-fastimport" tool currently has bugs [1] that prevent it from doing
> what we want. I have included a patch in the remote helper repository to
> fix one issue on the fix that was proposed but the whole thing is not
> completely fixed.

I see you are not using the 'export' functionality, which is good
since it has a bug, but if you'd be interested in doing that, feel
free to ping me in #git-devel on freenode or on gchat, and we can
figure out what would be easiest.

> I have been working on the bzr-fastimport bugs but I didn't receive any
> feedback from maintainers. So I currently am wondering if I need to be
> pushing for this tool to be fixed or if I should reimplement it.

I'd recommend working on 'bzr fast-import', forking it if necessary.
Definitely preferable over creating a new tool from scratch.

> Any help and/or support would be appreciated. I'll keep posting status
> updates when I have new info or progress on the project.

Please keep up the good work, I'd love to be able to clone bzr repo's :).

-- 
Cheers,

Sverre Rabbelier
