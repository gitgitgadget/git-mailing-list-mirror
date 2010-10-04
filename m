From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: remote-bzr status
Date: Mon, 4 Oct 2010 20:07:01 +0200
Message-ID: <AANLkTin_ziCLfsHOeqwzCSaAGWwxwUPi=1=4Hdhz7uSk@mail.gmail.com>
References: <4CA8F2F1.5090407@gmail.com> <20101004061104.GH24884@burratino> <4CAA16F8.4050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:07:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pRj-0006We-Rx
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399Ab0JDSHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:07:24 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34519 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab0JDSHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:07:23 -0400
Received: by gxk9 with SMTP id 9so1724367gxk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ha7s1zdtzQT0RfeDFOinPpPI0E3kaquxgWOdMo42Oto=;
        b=S3HndwLXfhJnvqVdulpKaYoP9qe5tsqvQKKf0YdmHvwZZgXd5cSDjJfUxTnKlFBu5X
         9IdyhQhMTd2y7XHXsmj3+cDy4f09ppvd9c+eF/1x88k9f/PqrMHVJdAuyJfgucrtzB1k
         xZM6AuptnRqc1xOcayF01ia84dbI0SrJxe35E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jpS/WLTMoO7b7Vyhuk/1dVKh3xXceiclmeRdvgz0jyFhBGTgKLg4D5NodXxOx6AnTk
         UGQH2U/84gli+0gggzcDW/6heFisbCxXPDdQJIXYHprqI8w79p+KvsuvCCaxU8m8YdUx
         rAnz5zHPZUy2l4dRqreoT7uLfRO5cKO8uODk4=
Received: by 10.90.29.4 with SMTP id c4mr4729776agc.27.1286215642400; Mon, 04
 Oct 2010 11:07:22 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Mon, 4 Oct 2010 11:07:01 -0700 (PDT)
In-Reply-To: <4CAA16F8.4050705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158078>

Heya,

On Mon, Oct 4, 2010 at 20:03, Gabriel Filion <lelutin@gmail.com> wrote:
> yes I would (after review from the community, and when the code reaches
> better functionality and testing.) It would mean greater visibility for
> the code, added functionality to git and the possibility for more
> maintainers to help ;)
>
> My original plan was to try and make the helper work both ways, and then
> to incorporate it into git.git to build patches on top of master (since
> it's a new feature that should be working on the current master).

It would be great if you could make it work by adding a bzr directory
to git_remote_helpers and a git-remote-bzr.py to the root directory!

-- 
Cheers,

Sverre Rabbelier
