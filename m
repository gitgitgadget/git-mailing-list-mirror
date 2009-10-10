From: eduard stefan <eduard.stefan@gmail.com>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http protocol
Date: Sat, 10 Oct 2009 19:52:27 +0300
Message-ID: <4AD0BBCB.8000306@gmail.com>
References: <4ACF7296.3010809@gmail.com>	 <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com>	 <4AD09F5E.9090304@gmail.com>	 <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com>	 <4AD0AE84.1070500@gmail.com> <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 10 18:55:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwfEO-0004ui-Mr
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 18:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934680AbZJJQxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934671AbZJJQxq
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 12:53:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:10234 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934667AbZJJQxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 12:53:45 -0400
Received: by qw-out-2122.google.com with SMTP id 9so234300qwb.37
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=q+gnOoJnNoVbg2rB94cdZ2OAK/qkSL5XuRcgcFiG6Hg=;
        b=IjZh8UEPRgobtn0ljdOcUd/0P/rh3apEPthJ1Yj+R3HR5w8tEFWunIzRS9A4UeQ6Vd
         7SpCxUFbhJX7GPe3pw2v658bFlSbsm7xUbMuo6iiMjVDyCKFgw/+oytfPp1dm9D4voAD
         /q2evVkJzE8S63SyQ/MLBuqyaAuJdCFUR5n6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=h2HvVFYtW4p4jGeA22PQy5KfQG1d03QLejftEaNXIX5oVRe5Xcb0UQe1T9AP9kTycs
         AwHhqWbhP0DzSxjq8LuGdKap/gxSkwf6yVgUcpjIMSA3tXcPQR5+vTxnKyBsENwdX/d8
         NiWQ63zebw5fLjbNeWbiabiGrhL7x9S1VxQGg=
Received: by 10.224.70.202 with SMTP id e10mr3689620qaj.16.1255193558238;
        Sat, 10 Oct 2009 09:52:38 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id 2sm1663704qwi.39.2009.10.10.09.52.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 09:52:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129891>

Tay Ray Chuan wrote:
> I suspect, as you do, it's got to do with remote-curl.
> 
> Could you try this command?
> 
>   echo list | git remote-curl http://github.com/loudej/spark.git

Inside an empty repository it crashes the same way,
without any additional information.
"git remote-curl" crashes in the same way,
but "git remote-curl --help" tries to launch the browser.

Is there any way to obtain more information from this crash?
Some debug mode?

Have a nice day,
  A.
