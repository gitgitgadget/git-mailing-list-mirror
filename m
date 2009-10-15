From: bill lam <cbill.lam@gmail.com>
Subject: unrelated file conflict during rebase
Date: Thu, 15 Oct 2009 18:35:26 +0800
Message-ID: <20091015103525.GI27040@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 12:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyNi1-0003q5-Ut
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 12:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761339AbZJOKgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 06:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761295AbZJOKgJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 06:36:09 -0400
Received: from mail-px0-f187.google.com ([209.85.216.187]:61181 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760736AbZJOKgI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 06:36:08 -0400
Received: by pxi17 with SMTP id 17so805501pxi.21
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=IL7hJB5HSxx7L1JbBQiiJbjINjoHUnkClLcM/z1hLNw=;
        b=xAs6MXy8PpUAdH1ov2lJQ00p9nafhPgEevOd5bFNLPGa33UdeDcp8r57LXh9G/3qVi
         YeRmbHZV3Z8acCzYKWXnoOIYngkx3bjjNnBGBGFFz8vg4ZX0HtQe4S4UWz+3fL+3UpSY
         NzpGg2ykr+8CgNZorNxRPwFaRDw9OggHiAEC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=GWJBJJJdiD2bBPpfJY3eZmxJvubNI7VGBK/ibH29Vlry4Gbtrgw9juI+8E/A2+dkLG
         iGLXJH6UMWrLwjyD2PeirNTLbmFlgvqMnkcgLHuCrjr8UsN4N0gnQiLh1PD+2odCfCqy
         l7zQqZB8a1tPtyBjC3eUkieX6FqHL8xrSP67U=
Received: by 10.115.101.20 with SMTP id d20mr17481317wam.192.1255602932349;
        Thu, 15 Oct 2009 03:35:32 -0700 (PDT)
Received: from localhost (n218103234139.netvigator.com [218.103.234.139])
        by mx.google.com with ESMTPS id 21sm14623pzk.3.2009.10.15.03.35.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 03:35:31 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130385>

Something I change a file in rebase -i.  During the process, for some
commits, git said some other apparently unrelated files (not that I
had changed) caused merged conflicts usually both modified.  Why did
this happen?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
