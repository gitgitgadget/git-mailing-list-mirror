From: eduard stefan <eduard.stefan@gmail.com>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http protocol
Date: Mon, 12 Oct 2009 00:12:38 +0300
Message-ID: <4AD24A46.5020705@gmail.com>
References: <4ACF7296.3010809@gmail.com>	 <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com>	 <4AD09F5E.9090304@gmail.com>	 <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com>	 <4AD0AE84.1070500@gmail.com>	 <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com>	 <4AD0BBCB.8000306@gmail.com> <be6fef0d0910101554p53d5532cp17768d2c95e9dbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 23:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5nN-00046Q-3W
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 23:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbZJKVNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbZJKVNV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 17:13:21 -0400
Received: from mail-qy0-f172.google.com ([209.85.221.172]:44230 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbZJKVNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 17:13:21 -0400
Received: by qyk2 with SMTP id 2so7639433qyk.21
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ph8eDlS5QwajlqZK5pZT7BplE5ETh9gWLvjEnjHJwr8=;
        b=LAv3O8zGrUigl+l0n0V7z3FK7MwJZE8M+u7sZcvNi0a/J0aabUZnJXz4RXLApFq2zX
         8e+gDyTPGqveP2p0w78a5kJJc/qn0jYcQE52Jd0ptN29gz4crg32QESyC+5ptMecgsFz
         W7D4+1EWqS4JVBbDt1vklEGWSgF3qIkRDgpLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MSjjtSyxB6Ek0nZAaLys5TZbUur8NAlzHzCCuCnPVqCrtokdDu9I7XG2/Qnfh6N/9j
         Yip3Pmp4gDz1scBuPAoUIPevtMvsYSxxETZANsn5E97s3kWLQZqnw2KOvL9mmyVyQSxb
         iT/5GlGCRpqPdufIE9XgMO8Pv/FqcyuxP6mV0=
Received: by 10.224.72.209 with SMTP id n17mr490594qaj.138.1255295564826;
        Sun, 11 Oct 2009 14:12:44 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id 5sm2253510qwg.50.2009.10.11.14.12.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 14:12:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <be6fef0d0910101554p53d5532cp17768d2c95e9dbf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129961>

Tay Ray Chuan wrote:

> just to check, running
> 
>   echo list | git remote-curl http://github.com/loudej/spark.git
> 
> and
> 
>   git clone http://github.com/loudej/spark.git
> 
> both gives the same error message:
> 
>   An unhandled win32 exception occurred in git-remote-curl.exe [5820].
>   Just-In-Time debugging this exception failed with the following
>   error: No installed debugger has Just-In-Time debugging enabled. In
>   Visual Studio, Just-In-Time debugging can be enabled from
>   Tools/Options/Debugging/Just-In-Time.
> 
>   Check the documentation index for 'Just-in-time debugging, errors'
>   for more information.
> 
> in a dialog?
> 
>> Is there any way to obtain more information from this crash?
>> Some debug mode?
> 
> I'm assuming you're using the Microsoft Visual Studio development
> tools to compile git from the source. I'm cc'ing this to the msysgit
> mailing list, perhaps someone familiar with them can advise you
> further.
> 

Git was compiled with msysGit, the errors are generated inside msysGit shell,
and VS2008 debugger gives this message:

"Unhandled exception at 0x00420354 in git-remote-curl.exe:
 0xC0000005: Access violation reading location 0x00000000."

Have a nice day,
  Eduard
