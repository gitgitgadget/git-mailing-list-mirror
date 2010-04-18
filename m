From: Steven Michalske <smichalske@gmail.com>
Subject: Re: Multiple user.name and user.email (possible feature request)
Date: Sun, 18 Apr 2010 11:16:34 -0700
Message-ID: <F5BFE3BD-7416-4F13-AF7F-0775E3234C92@gmail.com>
References: <19402.52486.274010.66636@winooski.ccs.neu.edu>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:16:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Z3D-0001yi-25
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320Ab0DRSQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:16:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47396 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288Ab0DRSQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:16:40 -0400
Received: by gyg13 with SMTP id 13so2238354gyg.19
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=JRZxrwYyKWfrSqVP4gEgSELO9wfg5yWmpDdemR9OMe8=;
        b=DD5qCth535cTabodiztiSUw4jVFzVkmneFDE9soGC0dyJ+M5yAm8RofB4WGOxVyyEw
         R4Pq8VNSypRIUc2o5YCkIElYiaapcsXvC6SCHCik044znSXPXyvnvIbwDIN8ZlC9ZgQB
         PE4TX5I5obh0suLrMSmwPUWbfjg4Qr38OX49Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=X4kizfHjNgEpaEyyN+kmWS4TCTfOKeMFjHEHGFzS/QEx0Yru0bc5IZjAgyJ8YKGas9
         h2Jy5sqNlYWilJaSYYP5v+hjWZJXcnQFh4KicUplXgISUpnN9OL9SLtQ0fJi75FaESoa
         x+GIaEjjGDAM+P9wXdpbGOPzunOhAnao4lba8=
Received: by 10.101.6.37 with SMTP id j37mr10867931ani.182.1271614597045;
        Sun, 18 Apr 2010 11:16:37 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id 26sm37338133anx.13.2010.04.18.11.16.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Apr 2010 11:16:35 -0700 (PDT)
In-Reply-To: <19402.52486.274010.66636@winooski.ccs.neu.edu>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145225>

On Apr 18, 2010, at 2:12 AM, Eli Barzilay wrote:

> Is there a way to have *no* default or some invalid default for the
> name/email -- something that will make git refuse to create a commit?
>
> For example, I'd be happy if I could put this in my global config:
>
>  [user]
>    name = "Eli Barzilay"
>    email = "-"
>
> and then have git barf at me when I try to commit with these settings,
> since I prefer being forced to set the appropriate address for each
> repository rather than deal with the alternative confusion (or just
> accepting the limitations and always using the same name/email).


Eli,

Just set the variable in the repository, not the global config.

i.e. drop the --global flag. So, in your repository:
git config user.email "that-repos-config"

I have three different email address for different repositories on my  
computer.  I have my global config set with my most common address,  
and the repositories with the less common email set locally in the  
repository.

Steve
