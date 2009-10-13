From: eduard stefan <eduard.stefan@gmail.com>
Subject: Re: Git 1.6.5 git clone unhandled exception using http protocol
Date: Tue, 13 Oct 2009 06:36:27 +0300
Message-ID: <4AD3F5BB.1050308@gmail.com>
References: <4ACF7296.3010809@gmail.com>	 <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com>	 <4AD09F5E.9090304@gmail.com>	 <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com>	 <4AD0AE84.1070500@gmail.com>	 <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com>	 <4AD0BBCB.8000306@gmail.com> <be6fef0d0910101554p53d5532cp17768d2c95e9dbf@mail.gmail.com> <4AD24A46.5020705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Oct 13 05:42:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxYH4-0001pe-86
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 05:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758898AbZJMDhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 23:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758882AbZJMDhl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 23:37:41 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:10816 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758851AbZJMDhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 23:37:40 -0400
Received: by qw-out-2122.google.com with SMTP id 9so756585qwb.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=kdfDW2YaMqs66XbKMEBCibyhmtsJ3okpGoqeAFJLgGg=;
        b=dHYD9uIyJItj/2wcpLpRVwwyWUR/YpT6QLZLg12beoDCnnvo3CCdtqNqoQIVLMlLa5
         8wIphO/prSKoc+1m8JR4Q6BmLfP+Pa9gYryzH6cjqnBm6dc5KuN+GuxpcdGZk4taJwJb
         bDrXwd9/GcX11px90AZKUst6ew+g+PWkXdc+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=JHdkqTBtz7hIZZE7iCloUjL5sKnSISIKbKIGCVF1k4X/txLjLZEsdSzglY0rwwjOID
         vIHDyxzWnFxjKkgemoSCRE8WtxGxszDmVkQKfkolzoBwWtStQ07g26FyGneKBQk11w8i
         WKKQXXxbwcO6sA80fKPAFrEOUL6XLPymrkuNk=
Received: by 10.224.59.130 with SMTP id l2mr5370516qah.73.1255404992859;
        Mon, 12 Oct 2009 20:36:32 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id 2sm1992673qwi.9.2009.10.12.20.36.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 20:36:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AD24A46.5020705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130121>

> Git was compiled with msysGit, the errors are generated inside msysGit shell,
> and VS2008 debugger gives this message:
> 
> "Unhandled exception at 0x00420354 in git-remote-curl.exe:
>  0xC0000005: Access violation reading location 0x00000000."

As a sidenote, 1.6.5 release crashes the same way.

After applying Shawn O. Pearce "Return of smart HTTP" patch series,
it no longer crashes, and "git clone http://github.com/loudej/spark.git" returns
"error: Unable to get pack file
http://github.com/loudej/spark.git/objects/pack/
pack-1bc121e71e2847622f814603ddb34444bfc6a16c.pack
The requested URL returned error: 502"
which seems to be more like a GitHub problem.

OTOH, cloning a local repositor serverd with mongoose works as expected:
"git clone http://192.168.194.24/test.git/"

Have a nice day,
  Eduard
