From: Michael Gaffney <mr.gaffo@gmail.com>
Subject: Re: [SCuMD]
Date: Tue, 08 Sep 2009 16:09:11 -0500
Message-ID: <4AA6C7F7.8040205@gmail.com>
References: <4A965799.6050204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Senkowski <csenkowski@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:09:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7wI-0007hx-8z
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbZIHVJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbZIHVJM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:09:12 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:25504 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbZIHVJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 17:09:11 -0400
Received: by qw-out-2122.google.com with SMTP id 9so166045qwb.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=p9IjiZn8wTmzsc0CdHc8xINq2ZCt8MQxlVcdIp3yHPk=;
        b=Hzo+Y8q4NoRYiti+OXBShrcrnhgIO3zqOpINX9My2rcpNM5zHGvAPSIYdV6NnX9gq7
         vOlyHsKc46VBqYV64kmtS9Iyzh7IvoKztIDBgokpp2sjbCnqMOrwWHSb0O7IhlyVyhdn
         7NAsNrt9dl2+JREw3VyFLqOitsYe7oLGYEw08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=beCh+7KxlV0+n0xlLQYTSlrZhmpmMb3d2yEE3PwkiBfLJas5MmD2AS7tom4GFEezs1
         7IfhdxbWYcZK1viFW7g9ILXVp3r/1MRgUVXrSZUtRTJsTAagsUHEBj+YSUOS+5EPNx2l
         8Dcb0LPjp+eB6v5u5yUGY2TTZ0+ke7EVBs6TE=
Received: by 10.224.121.66 with SMTP id g2mr10412565qar.47.1252444153834;
        Tue, 08 Sep 2009 14:09:13 -0700 (PDT)
Received: from ?192.168.11.102? (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 8sm7438qwj.18.2009.09.08.14.09.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Sep 2009 14:09:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4A965799.6050204@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128036>



Christian Senkowski wrote:
> Hi,
>
> I cloned SCuMD directly via git and started it but got following error:
>
> ~/scumd$ ./run.sh
> Exception in thread "main" java.lang.NoClassDefFoundError:
> com.asolutions.scmsshd.SCuMD
>    at gnu.java.lang.MainThread.run(libgcj.so.90)
> Caused by: java.lang.ClassNotFoundException:
> com.asolutions.scmsshd.SCuMD not found in
> gnu.gcj.runtime.SystemClassLoader{urls=[file:depend/lib/jgit.jar,file:depend/lib/minasshd.jar,file:lib/aopalliance-1.0.jar,file:lib/bcprov-jdk15-140.jar,file:lib/commons-io-1.4.jar,file:lib/commons-logging-1.0.4.jar,file:./,file:lib/jline-0.9.1.jar,file:lib/jline-0.9.94.jar,file:lib/jpam-1.1.jar,file:lib/jsch-0.1.40.jar,file:lib/jzlib-1.0.7.jar,file:lib/log4j-1.2.13.jar,file:lib/slf4j-api-1.5.2.jar,file:lib/slf4j-log4j12-1.4.3.jar,file:lib/spring-beans-2.5.5.jar,file:lib/spring-context-2.5.5.jar,file:lib/spring-core-2.5.5.jar],
> parent=gnu.gcj.runtime.ExtensionClassLoader{urls=[], parent=null}}
>    at java.net.URLClassLoader.findClass(libgcj.so.90)
>    at gnu.gcj.runtime.SystemClassLoader.findClass(libgcj.so.90)
>    at java.lang.ClassLoader.loadClass(libgcj.so.90)
>    at java.lang.ClassLoader.loadClass(libgcj.so.90)
>    at gnu.java.lang.MainThread.run(libgcj.so.90)
>
>
> Please help me out :)
>
>
> Kind regards,
> C. Senkowski
>
>   

Christian,
  Sorry for the late reply, yes, you need java 6 for this as it depends 
on Mina2 and JGit in the bowles. You should be able to get ahold of the 
openJDK these days on most distros.

-Mike
