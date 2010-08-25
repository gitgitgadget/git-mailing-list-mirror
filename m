From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 07/32] tree.c: find_subtree() to search for a tree
Date: Tue, 24 Aug 2010 21:35:05 -0600
Message-ID: <AANLkTi=5OoRWXND4x7YJKTU2kPaBAiUwYMFRocB8RC4A@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 05:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo6le-0004nR-0X
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 05:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511Ab0HYDfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 23:35:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49037 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0HYDfH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 23:35:07 -0400
Received: by fxm13 with SMTP id 13so68083fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 20:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rOlPNBXuhlYeTIkQqX7mXhtDKkIFhLko7hWZIaSL71k=;
        b=JNidecA7Fbl2UqROqDRCQq3sbBz7N3jwW1R5bggFAGiBoCueojwfRhMsNKRTprEVyl
         I6lhC+8giCDUWGsncIqILqlIcDaY0tp5VE7Q6ZEFNmqI0z+/1FBE5aHFr0XxRde/w6Qt
         khzVEnE6Nx5i5royaD9MV4rs2UD6dJAUF18Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QIKzz4y/jJUa5arbyht7eTGr2X2al4Dch5Y3CwPrskBphK+OkVQm1Jz8BB+8iD+CMk
         R9/8OUGaxgCFpoTHwLcmGM5Kokc73iTtm3a1y00euh9pOq1UOdy0T6zjpVvXB3tC0Mtu
         x7D2B1j5/rwI9GQgLyCqJbpDAUpbHSHYnHqus=
Received: by 10.223.113.12 with SMTP id y12mr6867015fap.36.1282707305276; Tue,
 24 Aug 2010 20:35:05 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 24 Aug 2010 20:35:05 -0700 (PDT)
In-Reply-To: <1282688422-7738-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154405>

2010/8/24 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
<snip>
> +int find_tree(const unsigned char *sha1, unsigned char *newsha1, con=
st char *path)

Trivial nit: Subject doesn't match the name of the function in the code=
=2E  ;-)

Also, when trying to apply your series locally on master, it seems to
die on this patch.  What commit is your series based on?
