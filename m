From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Thu, 20 May 2010 19:01:49 +0100
Message-ID: <201005201901.49853.andyparkins@gmail.com>
References: <ht3194$1vc$1@dough.gmane.org> <ht3sda$cvo$1@dough.gmane.org> <4BF57635.9090409@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 20 20:04:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFA6F-0001fL-HZ
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 20:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab0ETSAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 14:00:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51830 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab0ETSAS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 14:00:18 -0400
Received: by wyg36 with SMTP id 36so68613wyg.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=fdgZpwpa5XHf0+vpbwwKt+9Tt1SZluqod7wnU7g+Tos=;
        b=fmzKTHaLe3DL8oZ6HO1bBtFdx4YP4fTpzg6eNFEU5Xt96+V8jbw+3EttS+b2WjVnhh
         VDeIepgemkFInRZMqt7+f2/daijYPU2/GPoy2ae+5+DFlZ8Ck8zo+8Ov1Hg609XOxRH+
         EAVIBkg5lt+OALU6zLgwJTfCdGZl2YQto3HnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=ZDaoQ1vGN6HsK1X8Nj/1WgjqQnpG3tYvZk20UzerZNEFoBIg0l+QCI5VT+PDOBzMsJ
         3a0eJFm4jayhz0rCLCKU9GCQg4k+13WZaLymP+vSNfqFfOKtzjgN4ZklOe1nv+w2fXsw
         2CkdUkxhs6fhSkNVeTS2BzZnc8MpjrzC50G+4=
Received: by 10.227.128.81 with SMTP id j17mr252757wbs.149.1274378416939;
        Thu, 20 May 2010 11:00:16 -0700 (PDT)
Received: from grissom.localnet ([91.84.15.31])
        by mx.google.com with ESMTPS id h22sm915552wbh.9.2010.05.20.11.00.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 11:00:14 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.32-trunk-686; KDE/4.4.3; i686; ; )
In-Reply-To: <4BF57635.9090409@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147404>

On Thursday 20 May 2010 18:49:41 Jens Lehmann wrote:
> Am 20.05.2010 19:45, schrieb Andy Parkins:
> > (Most of my
> > personal use of submodule is embedding large projects that I want to be
> > able to guarantee are at a particular version, but I don't really
> > change them)
> 
> But to guarantee they are at a particular version they have to be checked
> for local modifications (no matter if they happened accidentally or on
> purpose), no?

A valid point.

Surely though in my own .git/config I can be allowed to tell git that I 
don't care about that risk?

I've got a top level module that used to diff/status instantly; now git 
scans an entire Linux kernel checkout and an entire ffmpeg checkout.  
Painful.  I fully accept that it was my own choice to arrange my repository 
in this way, but in my defence, it was fine last week :-)



Andy

-- 
Dr Andy Parkins
andyparkins@gmail.com
