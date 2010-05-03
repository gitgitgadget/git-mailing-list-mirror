From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: What's cooking in git.git (May 2010, #01; Sun, 2)
Date: Mon, 03 May 2010 19:54:35 +0100
Message-ID: <1272912875.3537.6.camel@dreddbeard>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 03 20:55:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O90ne-0008DG-Cw
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 20:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326Ab0ECSym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 14:54:42 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46882 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173Ab0ECSyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 14:54:39 -0400
Received: by wwb34 with SMTP id 34so1942356wwb.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=JIy8guIpj86DLAzN5edNADAFv/8y0JEwYzegD3EwYK8=;
        b=Asfg4Qcg2Uvsz+VNBS4JVNigOJauXmsz/3Ps37BNYEv1TyA0LhdG+xQ+9rVukKea+F
         g/vMuGaaMTJnzbBvA+W7JOKPmj2Ots62fqGbBQVdwU67sTLEqF+hxG4Vb1yQkhVlU/SH
         TagWYDiX8VRC9G/SodPB3b/1of++DR/9644Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=jZXgrpdVZqENJWtCZweEZAXjLkxQ/LE6i4upjlZy3Pq7Qg01GNnsIdQiX/FAkYKdUD
         GjH0NRtwlwwGEDD4iiEmhPdBCX5miNkKC3904hsPUJmTxSUFmFeJ+gnmKlF8nzM4hP+B
         sokBOp2WIkWkZDgKhTw292noI8+KZa3pwe+CQ=
Received: by 10.227.145.200 with SMTP id e8mr179926wbv.221.1272912877698;
        Mon, 03 May 2010 11:54:37 -0700 (PDT)
Received: from [192.168.0.129] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm43677973wbs.4.2010.05.03.11.54.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 11:54:36 -0700 (PDT)
In-Reply-To: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146250>

On Sun, 2010-05-02 at 09:12 -0700, Junio C Hamano wrote:
> This seems to cause intermittent test failure for me especially when run
> under "make -j4".
> 
> * wp/pretty-enhancement (2010-04-30) 5 commits
>  - pretty: add aliases for pretty formats
>  - pretty: add infrastructure to allow format aliases
>  - pretty: make it easier to add new formats
>  - pretty: make %H/%h/etc respect --abbrev[-commit]
>  - pretty: add conditional %C?colorname placeholders

Does it still happen with the latest (3-commit) series? I suspect the
most-likely to cause test failures would be the --abbrev[-commit]
changes, though I suppose "intermittent" could point to a memory
problem, which is more likely to be from "make it easier to add new
formats" or "add infrastructure..."

Haven't been able to reproduce here (just running make -m4 in a
while-loop all night) Any specific tests failing?

-- 
-- Will
