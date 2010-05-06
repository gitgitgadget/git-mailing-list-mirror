From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Feature request: relative paths
Date: Thu, 6 May 2010 03:31:13 -0500
Message-ID: <20100506083113.GA25993@progeny.tock>
References: <19426.23330.525936.981066@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu May 06 10:31:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9wTw-0005XT-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 10:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab0EFIap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 04:30:45 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:37973 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab0EFIam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 04:30:42 -0400
Received: by iwn35 with SMTP id 35so7586288iwn.21
        for <git@vger.kernel.org>; Thu, 06 May 2010 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LU0I8z7M2k7CzXalo+tdANGm7+RU/u7BKqANPaOOtlw=;
        b=o2HbJcPIq+3OBrBuo0M8QI/kvQ+7d0m5GRhY7APVEUq8Qe9KLMTQXAI6UdObiWmTB3
         Ua/sSdiLDz0NEKgTgWzGgRmMt+LJ4J74ofZ4FZg94I1M9dJMXbS38rMUuA6lr41E8Sra
         86xfnEoMGiJTTYPnUE7UEp+hs09h1M+BFhEEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RTfMov9ODcg8cx3bYqVv7wI0uvBX8b+85k6HuNR+KJJbDigKzlqkzPycwRNkcyQtCc
         VmdP9Jvkn6EGGhBsLVEIWvb0eaJEdpWOFALTr3xRHs4rniSQtfJKiobczJ7EPYjxr5yM
         Gqds5hKkCTN46wxe6YoQ0xSr1Qm981xPBIacc=
Received: by 10.231.60.17 with SMTP id n17mr191027ibh.24.1273134640844;
        Thu, 06 May 2010 01:30:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm614885iwn.8.2010.05.06.01.30.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 01:30:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19426.23330.525936.981066@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146458>

Eli Barzilay wrote:

> An svn feature that I used a lot is `svn cat some-file' -- and with
> git I can get close to that with `git show :some-file'

git show -- some-file

Hope that helps,
Jonathan
