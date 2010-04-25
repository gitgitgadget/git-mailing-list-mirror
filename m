From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bugreport: Git responds with stderr instead of stdout
Date: Sun, 25 Apr 2010 18:24:43 +0000
Message-ID: <y2g51dd1af81004251124zc4da759dka2ceebe1d9735fd7@mail.gmail.com>
References: <20100425130607.2c92740f@pennie-farthing>
	 <v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jack Desert <jackdesert556@gmail.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 20:24:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O66Vh-00028H-ES
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 20:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab0DYSYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 14:24:46 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58605 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab0DYSYp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 14:24:45 -0400
Received: by bwz19 with SMTP id 19so13186bwz.21
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lAge4xzTHB9inngdnw0lXzkYTVEZOssxA1ZfjxKXUCY=;
        b=fBgSkUCBtQDqWVhq0kbhzqAaCzBxys0LLrW27a+zQJ9SDt2Af10L5jCYdPYgL/ykfO
         TkNJFy/XfBBE7xZIjd6Vfbv1XCg2Xkrza7nNNihQOhG2Lk+zYWA3BmUB7eMQ+13mLhbi
         bPJmQV9GMCG57xWAttvNU4kEbcEdT7cT858fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NIV7bvQGfrMll34D3nvtAGZ2au8qApU4Fx4UnE1/4/S/pbg8mQlLqGWA7AcXIj48f7
         z5ZOFA+/MJGIDN432PGgBzN2ziSpjCTQxtTZBe0G/RfEZ4pSEZrvWd14XZbjekvjtSe4
         gxAfbdoG0nOTk8EHdqUVLZJuvF+xAgb2KPla8=
Received: by 10.204.24.134 with SMTP id v6mr1832825bkb.204.1272219883865; Sun, 
	25 Apr 2010 11:24:43 -0700 (PDT)
Received: by 10.204.121.195 with HTTP; Sun, 25 Apr 2010 11:24:43 -0700 (PDT)
In-Reply-To: <v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145756>

On Sun, Apr 25, 2010 at 18:10, Jacob Helwig <jacob.helwig@gmail.com> wr=
ote:
> I can't really say if it's actually a bug, or not, but as to your
> question about where to file a bug report: You just did. =C2=A0This m=
ailing
> list is the correct place.

I've had some issues scripting `git fetch` because on error it'll
print to stdout and not stderr.

Are there some general guidelines for git's utilities that they follow
in this regard or does each tool just do its own thing?
