From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] git-grep: allow patterns starting with -
Date: Sun, 25 Jun 2006 18:47:57 +0300
Message-ID: <20060625184757.f8273820.tihirvon@gmail.com>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 17:48:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuWqF-0002C8-0A
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 17:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWFYPsD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 11:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWFYPsD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 11:48:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:15199 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751460AbWFYPsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 11:48:01 -0400
Received: by nf-out-0910.google.com with SMTP id m19so479659nfc
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 08:48:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=OeYDPMJ1CX+NhQh5NtUcVfZGuyVl05lMz6aMmfQN/oxLt4Qpy5BH0tEaONcZ3OH1dGpKgAdCPg4kBCVmqQB1dEnI+fi/qui72Q0y+l017GH20CwKspmU6hXMXu2wwbtP7/EShrQAZsKh+REeJa6TfN8wiS0xnvgNB2LTHYbe/Is=
Received: by 10.49.90.19 with SMTP id s19mr231758nfl;
        Sun, 25 Jun 2006 08:47:58 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id b1sm5125812nfe.2006.06.25.08.47.58;
        Sun, 25 Jun 2006 08:47:58 -0700 (PDT)
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FuWh7-0008Ry-HX@moooo.ath.cx>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22635>

Matthias Lederhofer <matled@gmx.net> wrote:

> Signed-off-by: Matthias Lederhofer <matled@gmx.net>
> ---
> I did not find another way to use patterns starting with -, if it is
> possible without the patch please tell me and ignore the patch :)
> example:
> % git grep -- --bla HEAD HEAD~1 -- --foo
> HEAD:--foo/bla:test --bla foo

git grep -e --bla

It's not very well documented.

-- 
http://onion.dynserv.net/~timo/
