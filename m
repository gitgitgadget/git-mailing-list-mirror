From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: git-p4 move/delete errors
Date: Fri, 9 Jul 2010 17:05:26 +0200
Message-ID: <AANLkTikPHJuf5JUe096BWTWO_oF9u3gNlVNuw7Ik32WQ@mail.gmail.com>
References: <AANLkTinN0Av1CO7mZU-QKeApq43UmEykUV093eyTtKQN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Lance Linder <llinder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 17:05:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXF8x-0001Kn-BE
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 17:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135Ab0GIPF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 11:05:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32817 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899Ab0GIPF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 11:05:29 -0400
Received: by wyf23 with SMTP id 23so1605282wyf.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=CfZWMVGc9mY4oh+mDQFKGQQGNdTGC3D5v71sjf0o4GA=;
        b=vN+/Q0QSxqYRkexBbqE4p8uuNYL6f9xwx5QR7Bvdyg5+doRuMiRzo2dqFGSvdoHQou
         9dJ9VQwoeC1KKQBtqS2ltEBKtP2jhlwjPKZWLnWkfF0t2k+fKlmBnscPt6VBt4CY2zMl
         /C3ipTJ15Hr7bLUrmSzpgxGv8PvZijHXiSrGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qBKT9PpP88L+Qw16RLHGa41f9l1QcejDUw2jG0vQt6wDM04WcL/uxhsf8+PuJPWZ+d
         a+5ZvAkTMAgPNAOShNnUkYas3HBMBgPkDyCMxNqvHkW0BnMBGu2jGxp2K5y/9vOWPvlw
         3w78EyvnV2ItsTbfIV8W0OL0V3XFHXxWKxWJ8=
Received: by 10.216.81.195 with SMTP id m45mr4340654wee.23.1278687926961; Fri, 
	09 Jul 2010 08:05:26 -0700 (PDT)
Received: by 10.216.55.197 with HTTP; Fri, 9 Jul 2010 08:05:26 -0700 (PDT)
In-Reply-To: <AANLkTinN0Av1CO7mZU-QKeApq43UmEykUV093eyTtKQN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150674>

Hi,

On Fri, May 28, 2010 at 2:30 AM, Lance Linder <llinder@gmail.com> wrote:
> Until recently I have been successfully using git-p4 with much joy and
> happiness. Then suddenly git-p4 submit started throwing "Command
> failed: p4 diff -du ..." when ever I delete or move a file.
>
> We recently upgraded our perforce server ( Rev.
> P4D/NTX86/2009.2/238357 (2010/03/15) ). It was about this time that
> the problem came up. First thing I did of course was upgrade to the
> latest version of git ( now on 1.7.1 ) but the problem still persists.
> Next I updated my p4 client ( Rev. P4/MACOSX104U/2009.2/238357
> (2010/03/15) ) but still same problem. All other submits work fine as
> long as there are not any deletions or moves.
[...]
>
> Anyone else seeing these issues?


Indeed, we just upgraded our Perforce server too, and now I'm getting
this exact error. Did you find a solution to the problem?

If not I'm very interested in solving it. Seems like the p4 diff
command has changed behaviour and broken the git-p4 script.

Cheers,
Thomas
