From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: 'git add' regression in git-1.7?
Date: Thu, 18 Feb 2010 23:42:48 -0500
Message-ID: <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
References: <hll45t$50o$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 05:43:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiKhw-0001u9-1R
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 05:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab0BSEnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 23:43:11 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:61353 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0BSEnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 23:43:08 -0500
Received: by ywh35 with SMTP id 35so1747464ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 20:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BDksRzTFvzwDnepiWdFYRjeXulB995dTZpkzdsb/V6g=;
        b=o7IQdQgeWc4oKfvxj5/rZ/DR0qbiQlg9Vnl8I96c6BhTxTYsk/ONjTwtLJZTnDwetR
         3v1Hcbx/c8/PU4sUkjGfNj9kHXoTy655esj+jhB4zHxDSeqYT0iPsHJZ3ASBOeXWGmnS
         5+LuHzBoaUkCyH6Qau+CK2nLydZNtpEB1ANSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eyUvtD7UuU0w8ePvdvx54BphcLC7dEnmgtFqIxbfPw/sOV4DyYecZPlAbByZ/l+Dh2
         EcLC2zXH+NZdNPvCsi5Fx70a+/tS32D4yjNJWeCBGsbhOaIsG/lNP/ema3p0IKglcMKd
         p+KpE1kLXvhKYqYuWA/V/dzTOTIWiJRgR4vz4=
Received: by 10.150.251.7 with SMTP id y7mr1582422ybh.89.1266554588125; Thu, 
	18 Feb 2010 20:43:08 -0800 (PST)
In-Reply-To: <hll45t$50o$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140406>

On Thu, Feb 18, 2010 at 11:30 PM, SungHyun Nam <goweol@gmail.com> wrote=
:
> 'git add' does NOT add files in ignored path.
>
> When the .gitignore file contains:
> =A0 =A0tmp/
> If I do:
> =A0 =A0git add tmp/test.txt
> Nothing happens.

Try using:
     git add -f tmp/test.txt

Avery
