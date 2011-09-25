From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git for animation studio
Date: Sun, 25 Sep 2011 06:30:08 -0700 (PDT)
Message-ID: <m3sjnkpx75.fsf@localhost.localdomain>
References: <F533627C-C656-4733-8489-B4F62FE79A91@willhoag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Will Hoag <will@willhoag.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 15:30:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7on0-0005YP-KX
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 15:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab1IYNac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 09:30:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51284 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab1IYNaK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 09:30:10 -0400
Received: by fxe4 with SMTP id 4so5209888fxe.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=bKOcWmP7hcliUicO1DbrvaVSrSROE6my9x8rGQe/zNc=;
        b=J4ERzsdUfSH8ffiS1854A9Sc+7J71yL0H1c2o/ulLKj/iUEJl3d2JPDGnXCdw4y5ai
         aHZ6abDYa+XfYc9fRMe/viiMBbW55Sq67pDQqLTooW2WRAupvnK5MQvF2JQvQTVIpum9
         uY22amVIlv0/KQSSn+BLZVXPqH7czC1DnUP/M=
Received: by 10.223.48.86 with SMTP id q22mr8735310faf.127.1316957409630;
        Sun, 25 Sep 2011 06:30:09 -0700 (PDT)
Received: from localhost.localdomain (abvl230.neoplus.adsl.tpnet.pl. [83.8.209.230])
        by mx.google.com with ESMTPS id n1sm17100555fad.20.2011.09.25.06.30.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Sep 2011 06:30:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8PDTVp8021816;
	Sun, 25 Sep 2011 15:29:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8PDTJj3021812;
	Sun, 25 Sep 2011 15:29:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <F533627C-C656-4733-8489-B4F62FE79A91@willhoag.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182070>

Will Hoag <will@willhoag.com> writes:

> I'm doing researching for an online version control systems for our
> developing studio. Wondering how git could work for us in regards to
> large files, lots of data, lots of collaboration etc. I have a basic
> idea of how it works, but I'm very new to version control. Many
> thanks for your help.

What Git *might* have problems with is large un-deltable binary files;
there are however third party tools that try to deal with this
problem, like git-annex, or git-media (git-bigfiles fork is dead
IIRC).

You can [probably] find more information on tools page of Git
Wiki... when it will be up.

HTH
--=20
Jakub Nar=EAbski
