From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Compiling on Windows
Date: Tue, 18 Oct 2011 18:07:20 +0200
Message-ID: <4E9DA438.2020903@gmail.com>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com> <op.v3i8rauz0aolir@keputer.lokaal> <CAH5451=VPzkFZyyUUdj+=dXDCHKQbWTTob_=JJFBCwaDsp1n7Q@mail.gmail.com> <CABPQNSZhWOa5wken4vh6Hcza8EM4VnekE3VUFJNmaEJvWME=ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 18 18:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGCEF-0003Hg-BD
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 18:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174Ab1JRQJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 12:09:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51497 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919Ab1JRQJO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 12:09:14 -0400
Received: by bkbzt19 with SMTP id zt19so960102bkb.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nFQTvzrnuselldi1heb/y9+4E/xnFfpdaNRmEzlT/DM=;
        b=AeobAHqpZYY4EhC1jrm4W0ep7LueMA75oWpua09d7/U4g9yxl1f7cqdiroxOoEZE5o
         VpK7NF14gsGeTLu96YUyZR220G29Tb+hCuRLkL6/Vvzfd11p9PitFZr4Mih7SkKcdws5
         SHMWyPbknHJdp6NQhank/JQcwXED6VzyQqEXw=
Received: by 10.204.143.90 with SMTP id t26mr2337164bku.7.1318954153184;
        Tue, 18 Oct 2011 09:09:13 -0700 (PDT)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id r12sm2726615bkw.5.2011.10.18.09.09.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 09:09:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CABPQNSZhWOa5wken4vh6Hcza8EM4VnekE3VUFJNmaEJvWME=ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183885>

On 18.10.2011 16:02, Erik Faye-Lund wrote:

>> there. Foolishly, I had glossed over the msysgit installers on the
>> project home (I think I thought they were Git for Windows installers).
> 
> Yeah, the installer sets up a fully self-contained MSYS-based
> development environment to hack on Git for Windows.

I keep advertizing my mingwGitDevEnv [1] project which aims to become an alternative to the current msysGit net installer [2]. The advantage of mingwGitDevEnv will be that it comes with an mingw-get based environment, i.e. you can very easily update / add new MinGW / MSYS tools directly from upstream.

Just today I reached a state were mingwGitDevEnv can successfully build git.exe, but git-gui etc. are still missing due to a lack of mingw-get compatible Tcl/Tk packages.

[1] https://github.com/sschuberth/mingwGitDevEnv
[2] http://msysgit.googlecode.com/files/msysGit-netinstall-1.7.7-preview20111014.exe

-- 
Sebastian Schuberth
