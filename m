From: david.hagood@gmail.com
Subject: Re: Problems with GIT under Windows - "not uptodate"
Date: Tue, 1 Sep 2009 13:25:07 -0500 (CDT)
Message-ID: <e35db8f7ac1b5b2b2f080fb47f58c20a.squirrel@localhost>
References: <a21e6af7ee05f56fd8c02d0955af1c72.squirrel@localhost>
    <2729632a0909011119l3a19447ds9d4896a27ac488c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david.hagood@gmail.com, git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 01 20:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiYOz-00031K-DQ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 20:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbZIASsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 14:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZIASsK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 14:48:10 -0400
Received: from mail-px0-f204.google.com ([209.85.216.204]:48976 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbZIASsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 14:48:09 -0400
X-Greylist: delayed 1381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2009 14:48:09 EDT
Received: by pxi42 with SMTP id 42so213321pxi.20
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:message-id
         :in-reply-to:references:date:subject:from:to:cc:user-agent
         :mime-version:content-type:content-transfer-encoding:x-priority
         :importance;
        bh=2oUJWLFp568PWQwqVhLq07F61k6DhBKAStK32S0QjTc=;
        b=UeNaA6Z//Sex57SsZuJ31EgbG826qs9M2eooD94mYV44WdluoWQQuNOhDj2g/yFL+L
         ABxX2Y1Swgt12eSDa02UFt3TX35jv+rYZITB3oM2Cj2HcCp+Q+jtc5NXmQxLXnoXz6FP
         l8RqCFWDrQyfCuM8SO0mIhX13/D/piTGCTRkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:in-reply-to:references:date:subject:from:to:cc
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-priority:importance;
        b=i8Fyxebg1dS8e0sm29IarIMoMyloj3vLmJtmAHUjBjggTZRrKv5v6F0ktHxzW6AFLK
         WInw0itJao6U2E69Scrcx8Rtc88EU9Y8D8o1vOSO1tjlyPL6ig2IvzetnP7IY5qHHb2m
         CGP9pSKQIPbZXfJHtMDaWlyKyf6ZKk3yGtfcY=
Received: by 10.114.18.33 with SMTP id 33mr4922463war.51.1251829510303;
        Tue, 01 Sep 2009 11:25:10 -0700 (PDT)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.121.34.clradsl.sktc.net [64.71.121.34])
        by mx.google.com with ESMTPS id 20sm516107pxi.8.2009.09.01.11.25.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 11:25:09 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 4CE74C7B8248;
	Tue,  1 Sep 2009 13:25:07 -0500 (CDT)
Received: from deathwish ([127.0.0.1])
        (SquirrelMail authenticated user wowbaggr)
        by localhost with HTTP;
        Tue, 1 Sep 2009 13:25:07 -0500 (CDT)
In-Reply-To: <2729632a0909011119l3a19447ds9d4896a27ac488c1@mail.gmail.com>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127548>


> It seems like you want core.autocrlf to be false or you want a
> .gitattributes file to override it on a per-file basis for the files
> you know are CRLF (i.e. the ones that are CRLF even on the Linux
> side).

That's what I've been leaning toward: a .gitattributes in that directory
like this:

*.xml -crlf diff merge

Does that sound reasonable?
