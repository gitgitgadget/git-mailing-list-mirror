From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] t9501: Correctly force over max load everywhere
Date: Sat, 6 Feb 2010 20:45:50 +0100
Message-ID: <201002062045.50943.jnareb@gmail.com>
References: <201002061505.13886.jnareb@gmail.com> <1265467803-31210-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 20:46:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdqbX-0007kG-HQ
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 20:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0BFTqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 14:46:00 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:60403 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab0BFTp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 14:45:59 -0500
Received: by fxm3 with SMTP id 3so5602430fxm.39
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0cs141oTpkcJ36faLlKPc8qNhO43N6uD9n2gmR1oGCQ=;
        b=Uu+QHhLQakXO6Epvr3ethP5tSHKBsyKyYhri/A1LVWuBGVdazI+9z6dbwTC15oPKZO
         6da4zSyWqscFSMUPDkV4EzVBM06ubg7INrYL9ppTuk8Z93QGSqCsvL6Oa6wjOS4ufGVc
         GIZXxh9nAErE7G2cBIKyoLbpkyFxBC5xRQaqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OKt2177/ftqg9RZ88is2yTji96AGGho7QG5gv/OA9F19J0Eoh7iCDp8kuNuoY2MiFZ
         w2IEHmuFIaxj8fA8J1FGxHFeyxQwk54eLLIyi5frVdyPuqdhRvc/qlUsF3cdLqE4SpCp
         efIuK/kQ9yex0/AjkgYHtNkjqmyZ682nLKzSE=
Received: by 10.103.84.19 with SMTP id m19mr2899178mul.66.1265485557872;
        Sat, 06 Feb 2010 11:45:57 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id s10sm13096603muh.59.2010.02.06.11.45.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 11:45:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1265467803-31210-1-git-send-email-brian@gernhardtsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139187>

Dnia sobota 6. lutego 2010 15:50, Brian Gernhardt napisa=B3:

> The code to check for load returns 0 if it doesn't know how to find
> load.  It also checks to see if the current load is higher than the
> max load.  So to force the script to quit early by setting the maxloa=
d
> variable negative which should work for systems where we can detect
> load (which should be a positive number) and systems where we can't
> (where detected load is 0)
>=20
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

--=20
Jakub Narebski
Poland
