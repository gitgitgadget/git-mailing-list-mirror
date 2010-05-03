From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to push to remote(dropbox) when submit automatically?
Date: Mon, 3 May 2010 17:06:12 -0400
Message-ID: <r2w32541b131005031406p465f0acbg8c5850a7a851eeed@mail.gmail.com>
References: <4BDB870B.8080503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: David Lee <zhushenli2@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 23:06:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O92qd-0006zo-B0
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 23:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab0ECVGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 17:06:34 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:50105 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0ECVGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 17:06:33 -0400
Received: by iwn40 with SMTP id 40so3815233iwn.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=D/Al6h+ODTuIKG5Dp6D33AdeBxN0qXoam062lJiFxmE=;
        b=nNnwWi8IvDhd3u4oe7HnIQIpDXro6m5eNKdbTZ69D+5BYY3KYb4FaPz2kIaW+RfkIN
         bIL4uTBIkuSbtgjBfoLI7vx8DQ1hEEqD5/vXnpOEZ1pvcuUi11YD/MzQPEW+uJt3PNBr
         6i3j8c8DGK3/ZLuaNSSf0BIoj7GIIvu8LQvDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=a1m6nZNdHikpt5NRYlQJsQgzsS0fdgO0Dv6KJJD+qt9fOzze0zdXvvIEeFcbvMA82C
         R88/CbEdTMzh1nxmofcHr2AUCASc9hsbxOTsQr8uZnHnrEkwyWaPffw0g2MxVEcuk0wK
         ETekzYu5Z93Xpf9pyLur4EFISzcHYQOcdS1HY=
Received: by 10.231.160.195 with SMTP id o3mr1569695ibx.32.1272920792309; Mon, 
	03 May 2010 14:06:32 -0700 (PDT)
Received: by 10.231.154.206 with HTTP; Mon, 3 May 2010 14:06:12 -0700 (PDT)
In-Reply-To: <4BDB870B.8080503@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146259>

On Fri, Apr 30, 2010 at 9:42 PM, David Lee <zhushenli2@gmail.com> wrote:
> I am new to git and find it powerful.
>
> I build a local repository(origin) and clone it to dropbox
> directory(dropbox-git). Each time I submit to origin, I have to "git push
> dropbox-git" manually.
>
> How to push to remote when I submit automatically?

I would suggest making a simple shell script for this.  Then run it
instead of 'git push'.

Avery
