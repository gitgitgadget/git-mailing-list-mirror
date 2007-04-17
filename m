From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git pickaxe - more confusion
Date: Wed, 18 Apr 2007 11:42:35 +1200
Message-ID: <46a038f90704171642h2c6ce7e1hdcc33443656bd8d7@mail.gmail.com>
References: <46a038f90704171631k3f8acb5aoc4337ab8a8639aaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 01:42:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdxJo-0004uZ-4t
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 01:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031299AbXDQXmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 19:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031301AbXDQXmh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 19:42:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:62718 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031299AbXDQXmg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 19:42:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2229501wxd
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 16:42:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TTJi7cfTzOrPu40QbipAhG2aqMHun2FU2lVhejc7qlnRgKfeeH6pRfjBnBHLao3MqyjSixyV8dWAzWqdAmYFytVTSVGye3RbtvV9AINn+1JN+Wv7S6InPHjNkIUy1yDPNifKhr0V6B4dmmpfVPX7fQWJbIak7gsk6XZquexjzhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CBXKkbAz28HkCgze2RgcW6RtOfm2YhGFKbJVxLEs/pbRLVUSf0nO2ZeqA4qT3zuVh0Q2sHwvnxvzrAFhWBH7ZSoHxI2OhL/ZPMxs+ry3WSxAhK7Tbl8MlW9ZMLknmhp9ruz2UlAE04dTc/cKPUAnKfqd0tl7f6OE91gtLaC5SZQ=
Received: by 10.90.25.3 with SMTP id 3mr7124531agy.1176853355862;
        Tue, 17 Apr 2007 16:42:35 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Tue, 17 Apr 2007 16:42:35 -0700 (PDT)
In-Reply-To: <46a038f90704171631k3f8acb5aoc4337ab8a8639aaf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44841>

On 4/18/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> In short,
>
>      git pickaxe -L '/CURLOPT_SSL/' origin/cvshead -- mnet lib/mnet
>
> doesn't want to play with me. I initially tried with -S but the new

And I was trying the new pickaxe because oldstyle git-whatchanged was
messing up with my head because the space after the -S parameter is
not valid syntax.

Doesn't work:
        git whatchanged -p -S 'CURLOPT_' cvshead -- mnet lib/mnet

Works:
        git whatchanged -p -S'CURLOPT_' cvshead -- mnet lib/mnet

So -- I'm sorted with this but it's not actually described anywhere I
can see :-/ -- I only realised that reading Linus' old posts showing
off pickaxe there was no space after the -S and gave it a go.

Weird semantics!


martin
