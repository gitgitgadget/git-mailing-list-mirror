From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [StGit PATCH] Add some tests of refreshing removed files
Date: Mon, 4 Aug 2008 10:07:45 -0400
Message-ID: <9e4733910808040707u2ef8992eha629ebca9c41730b@mail.gmail.com>
References: <9e4733910807311902nd3a02bep68c8a26a7e6303cd@mail.gmail.com>
	 <20080804134050.19457.96613.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Catalin Marinas" <catalin.marinas@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0kD-0008FR-HM
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbYHDOHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 10:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbYHDOHr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:07:47 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:9418 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbYHDOHq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 10:07:46 -0400
Received: by yx-out-2324.google.com with SMTP id 8so141487yxm.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=637LvUYQfvFywOKYXwoukBkXI9syACcgs05pl9CyNAI=;
        b=qr0zMHzc6SWkn9XXk/pQE9V2cJnF2u1i0I19RquLgeprtICTT5VwhP7gQH/2CkEoFK
         z+2lL39/SUMeITmQmRZR3EcNhpOCKg/Yd9y4DWRgbxwWw8owxv7tMvgRZXSzQsKtYchj
         ZF+tPLP1gBXO5cU5xF1qCHuYcHEinkcvt346E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=S8CWn8bOXe6JGHMBZE+LoKF7d6+qU87UGRVfnB3KG3qzSoW1bO3sXWmpnP1X+1U4wn
         UJMWIYK/2wvTwnlcNn/ue712mO7/ABPdBmNRvwvNUl/gvfC/6jh5t4IrFva972G6ZRTY
         AA12k3ws9OwmRrfVlJFfBwDAYRPvN+Cfe3pMY=
Received: by 10.151.108.20 with SMTP id k20mr1365676ybm.150.1217858865394;
        Mon, 04 Aug 2008 07:07:45 -0700 (PDT)
Received: by 10.65.214.7 with HTTP; Mon, 4 Aug 2008 07:07:45 -0700 (PDT)
In-Reply-To: <20080804134050.19457.96613.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91356>

On 8/4/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
>
>  ---
>
>  These four tests all pass on Catalin's current master. Do they fail
>  for you, or did I miss something in your problem description?

I just updated to current git and stg and retested. Tracking a remove
is working now for me. Tools were about three months old before
updating.

Not sure what changed. But I definitely couldn't get stgit to do it
and had to use git commands to generate the patch. I would remove the
file, refresh and the patch was empty.
stg status would show the file in D state.  As soon as I touched
something else and refreshed the rm would appear in the patch.

Maybe there is more to the triggering sequence than a simple rm. I'll
keep a watch out and see if I can figure out how I got into the state.

--=20
Jon Smirl
jonsmirl@gmail.com
