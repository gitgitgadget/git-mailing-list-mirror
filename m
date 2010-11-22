From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Mon, 22 Nov 2010 22:14:45 +0100
Message-ID: <m2fwutkqm2.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com> <4CEADA15.1020502@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Mon Nov 22 22:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKdiz-0006QZ-OR
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 22:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281Ab0KVVOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 16:14:52 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49301 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541Ab0KVVOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 16:14:51 -0500
Received: by wwi18 with SMTP id 18so61354wwi.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=ezFT29fh1x39Y2GgFRC4tDdM6M2Rzh8UEH6bgoM1zw4=;
        b=fyNADnwFEpKv/4sFTpNce5awodQaUvuSUeN9GTuGE72v+d+gjZwLCFBoeh72LReFKO
         +lTHCb5ceB9odgV7im4AnGS85s7hvd8VkmqU8Os3sdNtydZlJuMZMl3h3e0lhlX/PZXV
         eQMADDTxObUZBLoJHZ2oMNHU0mzLtL8lJAnk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=plmMTTskyqeD/Wwr6iHWrK9ayCkohSzSh6MVf5tYJgPB+NlkxJ26aiazEUAkUjarX9
         38mcceIA8r2OBocWk5aWdaMpz8zdOV1vFVBDhkcLVZVGXJbgJALQWY3DXIAngp6qZQzD
         bU5/dWX8jOdk9RGVCQ3A2LfI27/3ZsRUhUlU0=
Received: by 10.216.24.206 with SMTP id x56mr5737610wex.2.1290460489506;
        Mon, 22 Nov 2010 13:14:49 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id x12sm2510447weq.18.2010.11.22.13.14.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 13:14:48 -0800 (PST)
In-Reply-To: <4CEADA15.1020502@obry.net> (Pascal Obry's message of "Mon, 22
	Nov 2010 22:01:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161913>

Hello Pascal,

Pascal Obry <pascal@obry.net> writes:

[...]

> I had a similar problem on Cygwin at some point. The fix was to add some
> rewrite rule in the docbook catalog (/etc/xml/catalog):
>
> I had added this:
>
>   <rewriteSystem
>      systemIdStartString="http://www.oasis-open.org/docbook/xml/4.5/"
>      rewritePrefix="/usr/share/sgml/docbook/xml-dtd-4.4/"/>
>
> You may have to adjust...

Thanks for the tip but I tried to add in '/etc/xml/catalog' in a couple
of places but it still fails.

Well I guess I'll have to do some researches later.

Thanks
-- 
Francis
