From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t0001: check syntax of sample hooks
Date: Mon, 19 Apr 2010 16:09:50 -0500
Message-ID: <20100419210950.GA30284@progeny.tock>
References: <20100419084132.GA25901@progeny.tock>
 <7v633nqi6i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 23:10:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3yEP-0002p8-FY
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 23:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab0DSVJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 17:09:41 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59075 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab0DSVJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 17:09:39 -0400
Received: by vws5 with SMTP id 5so2452915vws.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Jg4NLD9nCgsGOKw+7yBo6RBt++6pLUyQHS3kgZ7b6DU=;
        b=Q+9GjyV8424NPq8ZKdUXAeagsWcsGzkXpCTkl4hnkybFu5SSIaskJdOzTJmOcPIVW6
         C/SB2O3KDxJftuVbrTJ1GzC7uxWwX0Is7BnAnBSqV6AIspr2YiUEOyCbC+XGavlvwCsn
         8vQ+6WMumnqAu5PWXT2OTzl/zK/uUsXUHFJNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CAUyTNGibQLk+DIW5kejHS1iKJuTdG/9IeFmG6YZNq3A1Z5jUmfoysj8HfPa2kdBcZ
         bM2RR8La3n/Kxf2mQzbSdBVK/eh4JDc/wrlNILVySAB+ytz8/nKam4qNDUY0ZGdJ1qz7
         FPOp6orie2SdZkIA/WINQvNaGj5ptdxfEFITY=
Received: by 10.220.108.228 with SMTP id g36mr3945803vcp.146.1271711378388;
        Mon, 19 Apr 2010 14:09:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 7sm1688164ywc.49.2010.04.19.14.09.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 14:09:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v633nqi6i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145330>

Junio C Hamano wrote:

> "#!/Program  Files/bin/shell"???

=E2=80=9C#!/usr/bin/env sh=E2=80=9D?

I will think a little more about this and look at what msysgit does.

>> +cat <<\EOF
>
> No need to meow here; just say ":" instead.

Makes sense.

Thanks,
Jonathan
