From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] svn-fe: use svn-fe --no-progress in remote-svn-alpha
Date: Wed, 6 Jul 2011 15:26:40 +0530
Message-ID: <CALkWK0mrpy2bho9ExHaCSenzZLoEKSo-T0K_FVDz9VtaQcY-2g@mail.gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com> <1309884350-13415-5-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 11:57:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeOqz-0005ny-0z
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab1GFJ5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 05:57:03 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57461 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab1GFJ5B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 05:57:01 -0400
Received: by wwe5 with SMTP id 5so6774648wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ohrRTuxflTDvJJzSQHAHSrilf+DrP5pRxze3vNtwRWg=;
        b=LFShOxZa5fSjPwUxITUFV9WPiuYgZMkJg6fYq5V+sq9tPHczMxzoNc2oBE7pxXDm4z
         ONilNzmP7r4F+i1klipz8Y5kb49eYLWNWXHPvcBwFwGyRpFUi6L+XMeyXeiGH2BuzrLE
         PCKvktvYHqbrt22PWL4NeUfX2hLHaSAtQ5EL4=
Received: by 10.216.60.72 with SMTP id t50mr1807306wec.92.1309946220122; Wed,
 06 Jul 2011 02:57:00 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 02:56:40 -0700 (PDT)
In-Reply-To: <1309884350-13415-5-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176674>

Hi again,

Dmitry Ivankov writes:
> svn-fe by default =C2=A0produces a progress line for each imported re=
vision.
> For large repos it stresses the terminal and a user, possibly scrolls
> away error messages.
>
> Just disable progress lines for now.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---
> =C2=A0contrib/svn-fe/git-remote-svn-alpha | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)

Perhaps squash this into the patch that introduces --[no]-progress in s=
vn-fe?

-- Ram
