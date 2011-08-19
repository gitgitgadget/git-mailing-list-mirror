From: Sorin Sbarnea <sorin.sbarnea@gmail.com>
Subject: Unable to build git on Lion - missing config.h from Perl header files
Date: Fri, 19 Aug 2011 17:31:39 +0100
Message-ID: <CAGDPfJr01SPXvqDkYwingJ0Vu9DZx7GXO4G2uhFFfOWPvm1Rgw@mail.gmail.com>
References: <611AB1F99D784B92B1F7278139D6EED5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 18:32:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuRzJ-0005Mk-KO
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 18:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab1HSQcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 12:32:00 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39057 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab1HSQb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 12:31:59 -0400
Received: by vxi9 with SMTP id 9so2729221vxi.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=9KfmtwR+kuJBZQubZvBs5PEHsDAClRTYVB5mGK72dxw=;
        b=wzsiFCATciPP5k8VlpwUB3VNPEzhUPIjmzI5bEkNxBlq8oliIb2pZV98/3TyGZWcWP
         pgZR3uEx3oHawaeoxy3c1RhOq4OEmEYLeulwe2Fjw7BD+Nj2xlEodQwQcRD5LnK+rX2I
         hyAjHY85WRoLwD/tiGInmWwXx7YCFzAKIFmlE=
Received: by 10.52.77.68 with SMTP id q4mr2479255vdw.40.1313771519216; Fri, 19
 Aug 2011 09:31:59 -0700 (PDT)
Received: by 10.52.116.97 with HTTP; Fri, 19 Aug 2011 09:31:39 -0700 (PDT)
In-Reply-To: <611AB1F99D784B92B1F7278139D6EED5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179709>

Hi,

I came across the following problem while trying to build git (1.7.6) on Lion
https://github.com/mxcl/homebrew/issues/7091

The only files existing in
/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/ are
libperl.dylib andperl.h.

make[2]: *** No rule to make target
`/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/config.h',
needed by `perl.mak'.  Stop.
make[1]: *** [instlibdir] Error 2

If possible it would be a good idea to continue the discussion on
homebrew bug tracker

Thanks,
-- 
Sorin Sbarnea
