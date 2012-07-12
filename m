From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Git Garbage Collect Error.
Date: Thu, 12 Jul 2012 14:34:30 +0200
Message-ID: <CAGK7Mr5aAkQOu_LxvW7q13dup5GYpfBQUcUEeWsyYM+9cTYX=g@mail.gmail.com>
References: <4FD86AF8.1050100@zuken.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Lucas <toml@zuken.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 12 14:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpIbv-0007XW-4y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 14:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759177Ab2GLMfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 08:35:03 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:43431 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2GLMfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 08:35:01 -0400
Received: by ghrr11 with SMTP id r11so2321495ghr.19
        for <git@vger.kernel.org>; Thu, 12 Jul 2012 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=70ej0BYKgaFLfPVU9w3+xUykAvujNcyuRiu0eBFCV9c=;
        b=HT8PxHwQypsPFQVGnpbJCYQm5BoliJDj4ESFp10vPk0ecWvaz7+K68EfESO75GCptQ
         FEnezXK47n60Y2G5/nQ6tYuZ5aE6GoTCVmMXhywTIps/07pSE9yS7JyRBDnyaF4ega4T
         ATf71TiCin/UF1QZbUeq9yXDeLiRy60PHabUDxQHQ3gkYN1gLRHfNZa2onyXhpcEc3hT
         P+cbglio2mhRn7zzMQ5hpD0w1ZP5O9qIEX/NgJSOUmZF0+TQUU1ygp0aALF7t9p7Z3Hc
         OXy8VL6kIJjSnKxnmVL4vOKXsGEi/dR45E6pTA7sqvMVWhxZTunG69NnXuAJFgzscWJ6
         /T4w==
Received: by 10.50.149.225 with SMTP id ud1mr17294500igb.74.1342096500347;
 Thu, 12 Jul 2012 05:35:00 -0700 (PDT)
Received: by 10.50.99.10 with HTTP; Thu, 12 Jul 2012 05:34:30 -0700 (PDT)
In-Reply-To: <4FD86AF8.1050100@zuken.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201358>

> At the moment the bare repository is about 4Gb in size and about 2/3rds the way through fetching.

That's a big repo. Lots of binary files in it?
Does git fsck run normally? Does it report a lot of dangling blogs/commits/etc?

Philippe
