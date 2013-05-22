From: Kirill Berezin <enelar@develop-project.ru>
Subject: Re: git-submodule nested subrepo bug (Segmentation fault)
Date: Thu, 23 May 2013 00:03:09 +0400
Message-ID: <CAAObgf-2sVPi=vRdv+NvQLSyxmwETEmdLJhfX6=1MCrrJ9DwWg@mail.gmail.com>
References: <CAAObgf9RNyVOYD00ki347KBqMWoFA3U7-YM3DnLK4yu62SozSQ@mail.gmail.com>
 <20130520102925.GM27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 22 22:03:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfFG3-0001kh-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 22:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab3EVUDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 16:03:31 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:53415 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3EVUDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 16:03:31 -0400
Received: by mail-ee0-f49.google.com with SMTP id d17so1380841eek.8
        for <git@vger.kernel.org>; Wed, 22 May 2013 13:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:from:date
         :message-id:subject:to:content-type:x-gm-message-state;
        bh=PoJAJG6VeUtwiMb+UXLxqKlJE6j6ZPKVzsPTZoczXYM=;
        b=bs3S6vJ+1TmRCwl7gkAVUmIMZeFoIt1QlqikrcUbimVSooUVTGe307BDhQFNpSYzNz
         RcDuzGCdHp+xB1Czx+zR2N4AODNwhdD0L0/nRu+vwqtrTsbSdD5dbbVNZyQte6Fcoa09
         aGXQ2Wd1S5zIyyjTP4kEHfQyhhJ/CKm8nlV0Qn+cnruAcb51TexT0qp93FRUZUHjqW9r
         15Qx1QUpAeq5jqLJFR4fYw4uspJJxCPBzZcsqB8F9mI/EoPNSvtnIOT05nR67Nr9om6L
         P35Mdux4mAy4d1sF+iEOszEUF61y0VbPWH8cQ3fq/JkKae88KRlNBr+792NEIUSZjVHf
         3w2g==
X-Received: by 10.15.26.6 with SMTP id m6mr23018727eeu.4.1369253009653; Wed,
 22 May 2013 13:03:29 -0700 (PDT)
Received: by 10.15.81.133 with HTTP; Wed, 22 May 2013 13:03:09 -0700 (PDT)
X-Originating-IP: [213.21.7.6]
In-Reply-To: <20130520102925.GM27005@serenity.lan>
X-Gm-Message-State: ALoCoQkskxGpJP7Inx+gc+g6jvpnLBsrMoLPTRs9baTYu4OWQGkjvHh3RbMxHhovn6sAltTKJGeo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225189>

Ok, version is: 1.8.1.msysgit.1
Segmentation fault at the git clone --recursive
http://github.com/Exsul/al_server
0 [main] mkdir 6596 open_stackdumpfile: Dumping stack trace to
mkdir.exe.stackdump
C:\Users\....\libexec\git-core\git-submodule: line 181: 6596
Segmentation fault (core dumped) mkdir -p "$ditdir_base"
fatal: Could not switch to 's:/USER/..../al_server/.git/modules/': No
such file or directory
Clone of 'https://.../Exsul/chat.git' into submodule path 'chat' failed

2013/5/20 John Keeping <john@keeping.me.uk>:
> On Mon, May 20, 2013 at 09:32:21AM +0400, Kirill Berezin wrote:
>> When you trying to add submodule, that already has submodule, it craches.
>> For example you could try: git clone --recursive
>> http://github.com/Exsul/al_server
>
> Which version of Git were you using?  I was not able to reproduce this
> with 1.8.3-rc3.
