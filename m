From: Leif Gruenwoldt <leifer@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Sat, 10 Dec 2011 10:27:28 -0500
Message-ID: <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 16:28:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZOqP-0005Jy-BC
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 16:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab1LJP2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 10:28:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62918 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab1LJP2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 10:28:00 -0500
Received: by iaeh11 with SMTP id h11so349432iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vAm5f7VQtEycCpGCTG3AlshqCAMS1scH3wg4uEh7bKg=;
        b=s166zRwZLJoj6fDvsndv4OyAtucdQLXggQ++W6X7llfhmyHfeClNeVR+W0WuPj8UEz
         ysMe41JpqBXkaK77JfFfZvM5L2Yk7+IeOlPHknGGQdVZ9SZno9O9jf8RMp66wvReWXIv
         dY3f+an6Xkz0A/0BEIE1G2Qf0p8AgEoINTcdc=
Received: by 10.42.159.195 with SMTP id m3mr6305813icx.33.1323530879538; Sat,
 10 Dec 2011 07:27:59 -0800 (PST)
Received: by 10.231.1.32 with HTTP; Sat, 10 Dec 2011 07:27:28 -0800 (PST)
In-Reply-To: <7vborhaqgw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186781>

On Sat, Dec 10, 2011 at 1:30 AM, Junio C Hamano <gitster@pobox.com> wrote:

> So that use case does not sound like a good rationale to require addition
> of floating submodules.

Ok I will try another scenario :)

Imagine again products A, B and C and a common library. The products are in
a stable state of development and track a stable branch of the common lib.
Then imagine an important security fix gets made to the common library. On
the next pull of products A, B, and C they get this fix for free
because they were
floating. They didn't need to communicate with the maintainer of the common
repo to know this. In fact they don't really care. They just want the
latest stable
code for that release branch.

This is how package management on many linux systems works. Dependencies
get updated and all products reap the benefit (or catastrophe) automatically.
