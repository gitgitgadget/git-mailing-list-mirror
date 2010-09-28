From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Another way to compare tools: is it possible to transfer full history?
Date: Tue, 28 Sep 2010 22:55:24 +0200
Message-ID: <AANLkTikvA-BkyGxJ14SpLerjsp1JpCDgegdc+9aT929x@mail.gmail.com>
References: <loom.20100928T153519-936@post.gmane.org> <4CA20169.2040606@dbservice.com>
 <AANLkTi=oRv4NnG0yWCpmj+AVXijGU-EK5rAHUZ4dZLQV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tomas Carnecky <tom@dbservice.com>, Tuomo <tuo.tie@gmail.com>,
	git@vger.kernel.org, Rocco Rutte <pdmef@gmx.net>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 22:55:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hDL-0001GX-7q
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 22:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab0I1Uzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 16:55:46 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51184 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab0I1Uzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 16:55:45 -0400
Received: by gxk9 with SMTP id 9so36344gxk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=9pTveeeaj1JqSTZJenL6fLU3eMJWojtcrYWPot1JZwc=;
        b=BwkHOa41fOgKpMmGamsjLeP6+NWiR+Y0TSly+r1zppF4/a0J18brAPvQiHAD6OwUKk
         V2lqsLl/QpJKAYYe0JSU1f83sL4mLl24cs9WDlsiFAbd4hCOoXbNhluh85HnIYIwno2j
         PQU2d0Sr6EypKXZqR5ERm8leaIXsvZNQ8lBzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AvOmaRqYERtjPgzsh42PPca/VJ563xz9ACEadohrrPS5/bERtHeOf6hY3k0wz0sJYV
         OAGyC85SmmKT6ZhULoCU0AwN7b94vouoAXBJEI9g8DhZDRwbD4Jz8yhEBQtfOco7d91E
         yBf4MkhTTE1VnHaLgzMhrMuvnEvxrxF5nozj4=
Received: by 10.150.177.17 with SMTP id z17mr808477ybe.122.1285707344668; Tue,
 28 Sep 2010 13:55:44 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Tue, 28 Sep 2010 13:55:24 -0700 (PDT)
In-Reply-To: <AANLkTi=oRv4NnG0yWCpmj+AVXijGU-EK5rAHUZ4dZLQV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157470>

Heya,

On Tue, Sep 28, 2010 at 22:48, Jonathan Nieder <jrnieder@gmail.com> wrote:
> remote-hg (see git_remote_helpers/hg/ in
> http://github.com/SRabbelier/git) contains a partial hg fast-export
> implementation in exporter.py. I don't know how it compares to Rocco
> Rutte's exporter.

I wrote the exporter from scratch, I know that it works, but I haven't
compared performance against other implementations (such as Rocco
Rutte's)

The accompanying fast-import is based off the bzr one. I'll use the
new python fast-export library that's on pypi in the next iteration
though, so only the part that hooks into hg is interesting.

-- 
Cheers,

Sverre Rabbelier
