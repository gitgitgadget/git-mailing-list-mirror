From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: push problem with anonymous access
Date: Sat, 2 Jul 2011 23:19:36 +0800
Message-ID: <CALUzUxpXFb_zPw0uBXdeGk2rAWMJ+K1518EO16rjFc3kCpkU5Q@mail.gmail.com>
References: <9490CEEB-485B-4EC0-B75B-8ED8F0833712@math.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michele Marcionelli <michele.marcionelli@math.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 02 17:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd1yx-0002Tn-2b
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 17:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab1GBPTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 11:19:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36359 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab1GBPTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 11:19:37 -0400
Received: by ewy4 with SMTP id 4so1396028ewy.19
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3m9sAEAkEJr3LvYO7ARpu69NqYvzuthPSnDTWdoMCXs=;
        b=vs+9GTQ8bgYHaYPC/BDBxLNOrKC3zcwByNCZl8KeuuSe0XWcPVJJY2hKnkCt7q2dxW
         GejqlwTiNnBZBBKJxdYCwalcP0jJ6F6ggqyOXoKvMqdDOHuwmgNaNxPDFWZkG7OycH/t
         Z8KFIdkhRODTouyTAVXsks6+kGOr1/Xc5Loeg=
Received: by 10.14.15.78 with SMTP id e54mr1411263eee.32.1309619976074; Sat,
 02 Jul 2011 08:19:36 -0700 (PDT)
Received: by 10.14.127.66 with HTTP; Sat, 2 Jul 2011 08:19:36 -0700 (PDT)
In-Reply-To: <9490CEEB-485B-4EC0-B75B-8ED8F0833712@math.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176560>

On Sat, Jul 2, 2011 at 6:32 AM, Michele Marcionelli
<michele.marcionelli@math.ethz.ch> wrote:
> ==> /var/log/httpd/git-ssl.access_log <==
> 85.1.201.213 - - [02/Jul/2011:00:13:32 +0200] "GET /git/math/public_test.git/info/refs?service=git-receive-pack HTTP/1.1" 403 - "-" "git/1.7.5.4"

Try

  $ git clone https://<user>:<pwd>@git.math.ethz.ch/git/math/public_test.git

or put it in ~/.netrc.

-- 
Cheers,
Ray Chuan
