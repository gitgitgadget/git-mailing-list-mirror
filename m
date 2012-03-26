From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Finding list of commit object
Date: Mon, 26 Mar 2012 09:03:17 -0700
Message-ID: <CAJo=hJsjRLZ4H7HU1DZrNSX5ouP73BJUkxtQm_7HaV8Xg07zzg@mail.gmail.com>
References: <BLU0-SMTP344C6638261C23F2023DD72B1450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 18:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCCOW-000146-Hc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 18:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805Ab2CZQDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 12:03:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36434 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab2CZQDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 12:03:38 -0400
Received: by pbcun15 with SMTP id un15so6137808pbc.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ij7B7nEHMHmCr8o+yNVEW/Rq3IbWgbs8Opi2F/uPaQI=;
        b=MWHNun4Rf/bnW5arKeVHWRp35NxghABoj+YCooKLD257ilZVkxMZpWDAQomOv7pKU6
         Xbj1wz+s7E7L6qY9n5ypBurWFih0XmF8SCOR3Obk4TDNWTUxZVJwYlvZMGJO9Dh7AsxZ
         nN8lAL6fQvX4dJ0/GJFTNPI8kkDZRF3Jy8iOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=ij7B7nEHMHmCr8o+yNVEW/Rq3IbWgbs8Opi2F/uPaQI=;
        b=d3nakpWi0aLCZsgXBIQW6Q8gIPvNvp3V95ZJjHKY7kWGd/E3X+gtHheAY2BCaGZLs7
         63TBAFaLfdox7v2OyIEErPBrkrGQGKw5Az9VfwLPyEhIgLnJtUOKFmmsq4/y/pJSLpbH
         CHLKm0X2Ax1N+4mVVWgwvS6BQPYH9w1P3AV2b0vdtriEEV/gW2g4fiYsuyevIqERTiY+
         Ieh5NxLFLbjeoMojm3qhZeFoHb3fLv//7RAQAEyYMhChph4KgbwXcHe64e5jndWSnlNU
         fEuD7qL6zZglxnLZtEcIH5CKtW4U1WaqR1YcGt49ev3GN3HJs95TJXbPaEb2Tcqy1r0n
         M4TA==
Received: by 10.68.226.227 with SMTP id rv3mr54026746pbc.65.1332777817704;
 Mon, 26 Mar 2012 09:03:37 -0700 (PDT)
Received: by 10.68.237.201 with HTTP; Mon, 26 Mar 2012 09:03:17 -0700 (PDT)
In-Reply-To: <BLU0-SMTP344C6638261C23F2023DD72B1450@phx.gbl>
X-Gm-Message-State: ALoCoQkQTZkOOjc2pMKxp9CtOYGpXSqeeS85xEYFBLWJaLn9Kjxnl5HuLRTQIgmgBDsaL/xDlxc7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193920>

On Mon, Mar 26, 2012 at 08:22, Anjib Mulepati <anjibcs@hotmail.com> wrote:
> I was doing some research on git objects. I understand that each object is
> represented with hash code and we can find the type of object with git cat
> command. I was wondering is there any command we can give to find the list
> of commit object (or any other object type) in current project without doing
> cat on each and every object inside .git/objects/

git rev-list --all

That will list all commits, starting from each current branch or tag
and walking backwards through history.
