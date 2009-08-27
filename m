From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 14/14] Add README and gitignore file for MSVC build
Date: Thu, 27 Aug 2009 11:26:44 -0300
Message-ID: <a4c8a6d00908270726h387520c8g69bd6e70604caf95@mail.gmail.com>
References: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
	 <54673ddb6bef681194e141e5e05e930cdfaa07bc.1250860247.git.mstormo@gmail.com>
	 <e82f1930173966ebb6b2d2815e037a26e079f969.1250860247.git.mstormo@gmail.com>
	 <a4c8a6d00908230926of0ea10bhd8f66e7d37c3b39b@mail.gmail.com>
	 <3f4fd2640908231122m34604196pc98c5871cf5925b5@mail.gmail.com>
	 <4A91917F.9000709@gmail.com>
	 <a4c8a6d00908231229v56eceeddue1b927a4e4e49ee3@mail.gmail.com>
	 <1976ea660908250732q1e1fc153g663f3a9c13f1c902@mail.gmail.com>
	 <a4c8a6d00908251024o24380f7ue409ac5f164c085e@mail.gmail.com>
	 <1976ea660908270616v543776fdv6ec167cc105337fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 16:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgfwC-0002wZ-Gk
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 16:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbZH0O0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 10:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZH0O0n
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 10:26:43 -0400
Received: from mail-yw0-f184.google.com ([209.85.211.184]:63069 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbZH0O0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 10:26:42 -0400
Received: by ywh14 with SMTP id 14so1469238ywh.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/2Go8ODacbaxyuf8LkeI+HW+JIDqB/+Be+zDTI+wDSE=;
        b=tE0kil4aRfv7GggEY6Fxaeczfhg0qGTOzYeb1MRX4tmwNXEHZvvxwhTMm0M+SnTodU
         sYM9Bv7pQ9bFq0mWl0jLzv/bDwiuPKfi5SbufQIEq4zhB6zezLv/lBfd0Ku2ezlF2Zn6
         wIi6FJSNWuichiRo8FJCQRO4FBmovGs02wvh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aJp23QhVbY1tIQI79eBWHkaFOMTtotRtjHXLoPb/nFH7EIdBza4tcmmoeGe7NzKuSx
         7E3LkpHgm76X9M+vV9+r13MiqVW2xVTmCNrvGHZ/xvm22mhZkufkvWERU6VxeWCjrpD7
         SCSiqlriGd5JerBaymN++O23Teahxd5RdTI9w=
Received: by 10.101.80.3 with SMTP id h3mr9722000anl.65.1251383204336; Thu, 27 
	Aug 2009 07:26:44 -0700 (PDT)
In-Reply-To: <1976ea660908270616v543776fdv6ec167cc105337fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127160>

Hi
On Thu, Aug 27, 2009 at 10:16 AM, Frank Li<lznuaa@gmail.com> wrote:
> I fixed this problem
> It should be ext/zlib
>
Thanks!

Now when I run 'git submodule update' I recieve this error:
'fatal: Needed a single revision
Unable to find the current revision in submodule path 'ext/OpenSSL''

If the output of 'git submodule status' help, this is:
 fdd0f73b9a3e7c1fdf15c2e2a52582c637ec96f1 ext/OpenSSL
+3136d3b72e199ad1484629e8ff4563a918cad953 ext/git (remotes/origin/vcpatch)
-c891963b1c9d2ffbf194b2c2283639d784fa3690 ext/libcurl
-62cb93cb25e2fbdbc89f90249cd8a024afad8a94 ext/zlib
