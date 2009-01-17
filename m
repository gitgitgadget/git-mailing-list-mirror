From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 12:21:37 -0800 (PST)
Message-ID: <m3zlhpy981.fsf@localhost.localdomain>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>
	<alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de>
	<be6fef0d0901170040r7e11806et87cc5dc3c6f13a2a@mail.gmail.com>
	<7vsknh7og5.fsf@gitster.siamese.dyndns.org>
	<be6fef0d0901171155p26e14aa1t90c0d7b8ec7925f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ray Chuan" <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 21:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOHp2-0004lb-Ne
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 21:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbZAQU3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 15:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbZAQU3t
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 15:29:49 -0500
Received: from mail-ew0-f12.google.com ([209.85.219.12]:37135 "EHLO
	mail-ew0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbZAQU3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 15:29:48 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Jan 2009 15:29:47 EST
Received: by ewy5 with SMTP id 5so356535ewy.13
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 12:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=dI6TN4WPBqLZNi/UvpKC98Q3avXIs92XOabfdji67a0=;
        b=h/69FHUcOP4bUoH6taXpx6qxUKfsLZwntVFO0B9Z+8jdUoFLyifXhstV5ThTTxt0e2
         NFVBtsa6vEfqV7iJ0BLmDU1d47Enr+pLETcwoFQ3cs8VR+lKT6A30mkF8vWp1Onkjz08
         p12ljYWFmUFBHJFizf4mUPY7bEb6HvcPoLbZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=aPaPeilLOV/naUOg3uanZiHtiun9DLkG3FqKRErtDWnBu2739eBVb5MHR6t39umziO
         QGAywA6UmC7XB/JvyMrNBjIPjRCnrYl2e/COP095DqtmC7xg++FwJmfPE0f4aQy68Ylw
         dqdU3u0cKKIQW8dH44qGBYDaTRypkpKwrApBI=
Received: by 10.210.109.10 with SMTP id h10mr1079464ebc.39.1232223698834;
        Sat, 17 Jan 2009 12:21:38 -0800 (PST)
Received: from localhost.localdomain (abwy228.neoplus.adsl.tpnet.pl [83.8.248.228])
        by mx.google.com with ESMTPS id 7sm5038843eyg.52.2009.01.17.12.21.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Jan 2009 12:21:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0HKLaP9010757;
	Sat, 17 Jan 2009 21:21:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0HKLZPw010754;
	Sat, 17 Jan 2009 21:21:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <be6fef0d0901171155p26e14aa1t90c0d7b8ec7925f3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106104>

"Ray Chuan" <rctay89@gmail.com> writes:

>>>>> -     git push &&
>>>>> -     [ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
> 
> i modified the push arguments as there was no remote ref/branch
> specified. With a fixed "git push", that line says:
> 
>   No refs in common and none specified; doing nothing.
> 
> i'd like to take this chance to inquire, what does the -f, plus square
> brackets, really mean? i assumed it was to force push to go ahead even
> if "a remote ref that is not an ancestor of the local ref used to
> overwrite it" check fails.

Errr...

  git push &&
  [ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]

means, do "git push", and if it succeeds test (which should really be
written as 'test <cond>' and not '[ <cond> ]' I think) if the file
does exists and is regular file ('help test' or 'man test').

-- 
Jakub Narebski
Poland
ShadeHawk on #git
