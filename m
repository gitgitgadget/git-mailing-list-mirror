From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Sun, 17 Aug 2008 16:46:34 +0100
Message-ID: <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com>
References: <20080808211318.GA4396@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 17 17:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUkTj-0007dA-Kh
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 17:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYHQPqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 11:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbYHQPqg
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 11:46:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:33055 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbYHQPqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 11:46:35 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1090223waf.23
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lcY0uQvjefDyH/3yM8GfbPTdB3Pnt04MlirY6PxdtOE=;
        b=oq8m7VCGAgXUtevJsUynUND3cmGifKfSZJINjruDGWt9PNWHauS/th3zX4w8vht+kr
         7U4GXlDmlfhGL+lfvMJmCtSGodU21f+Gni2cQQs+YhXYV5TlxOz8Nw6t4Tig1rPcckCb
         CVthtgi0DdYetyhY1R1NwTgyTSrTT1E0gMZdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SwIUWrQAwBnfupGeit5H47JsNGV2SzLvnb+vd7shTsltu7F5UCucA4U8KfxzOTSVNI
         i9a8tsaS11EXBwRVEdLnF8moHIOd9vqNDbi6aK8a2rpyz4xsj9Wx9A7hCLEwisy2s2Io
         Va0/tZ+DZk4ZSrIC1VACi2VqXeO/hg+H7gY2c=
Received: by 10.115.76.5 with SMTP id d5mr4249173wal.191.1218987994978;
        Sun, 17 Aug 2008 08:46:34 -0700 (PDT)
Received: by 10.114.174.5 with HTTP; Sun, 17 Aug 2008 08:46:34 -0700 (PDT)
In-Reply-To: <20080808211318.GA4396@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92613>

On Fri, Aug 8, 2008 at 10:13 PM, Jan Hudec <bulb@ucw.cz> wrote:

>
> I've already done the later (have patch series ready), but I am now thinking
> that I should probably redo it the first way. What do you think. Does it make
> sense to do that?
>

Could you please post somewhere the patches ?

Better yet to fork from http://repo.or.cz/w/qgit4.git and set up your
tree on http://repo.or.cz/ host (it's easy and fast, thanks Peter :-)

I can check that and eventually pulling from that.

As a general rule if you have already done a good chunk of work with
unit test patches I would avoid to ask you to redo in a different way,
so I would say it does not make a lot of sense to me at least before
looking at the code.


Marco

P.S: I have played a bit with qmake some time ago (to set-up the
double build environment Windows/Linux) so perhaps I could help you in
finding some useful trick to avoid the cons regarding .pro files you
posted. But of course I first need to see the patches.
