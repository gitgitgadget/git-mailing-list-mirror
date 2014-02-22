From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Cygwin + git log = no pager!
Date: Sat, 22 Feb 2014 20:39:32 +1300
Message-ID: <53085434.4060106@gmail.com>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 22 08:44:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH7BU-0006cr-Oj
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 08:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbaBVHjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 02:39:37 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:55241 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbaBVHjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 02:39:36 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so4470396pad.28
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 23:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=WuFPuj3sb710Pqi3ZjgWVJYoikVyMRcuSFW8KCUGzGw=;
        b=xz3Qq9lOEA0XcxAx7wU7YvPZoZo0dkoXKw2iq3L9FsNrZoAGRctDB6hPJVqZKxbsfL
         ayuSea37+v4dJEB87a2n1yI/5DtLhUPxRJxIuK9AeqOQReMfcFUpUqDRgtTY2b8f9UwL
         RoCDiZxoKTQDGAuUk2eApa3sAwt5ab3agh7mFE46q6hwFG5AXfEgNck9TAd3LDvamC0k
         OSENRw6vNXYodCup7+8ivvjP/Jp6bUHBA0crmAYqn+WrwuJCwnKoVPgxvUz4al82WG4R
         nTK5Clm1j8KA2ELOsx4Wy15nLn40XXLKunUnus0KDvvuO10nTdNkKgc5RKQ2iWRrsBe1
         +0lg==
X-Received: by 10.68.130.234 with SMTP id oh10mr13726638pbb.136.1393054775748;
        Fri, 21 Feb 2014 23:39:35 -0800 (PST)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id oz7sm6110065pbc.41.2014.02.21.23.39.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 23:39:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242502>

On 22/02/14 18:18, Robert Dailey wrote:
> So it seems that the pager doesn't work by default when running `git
> log` from Cygwin like it does in msysgit for Windows.
> 
> I know I can pipe to `less` but that requires the additional typing
> obviously. Does anyone know how I can get the pager to work in Cygwin
> for git log, reflog, and other commands like it does in msysgit?
> 
> Thanks in advance.

Add GIT_PAGER=less to your environment. I don't know if you were using
the cygwin packaged git or building from source but I'm surprised the
pager is not set by default as you actually have to define the use of
something other than less.
