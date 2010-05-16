From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add git format-patch produced patches to .gitignore
Date: Sun, 16 May 2010 02:52:45 -0500
Message-ID: <20100516075244.GA9010@progeny.tock>
References: <1273958566-7328-1-git-send-email-avarab@gmail.com>
 <AANLkTinSJTzYOk_MRp2ddlLnbd5dC65q-c4zQbv8Oubj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 09:52:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODYeV-0003w8-Nu
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 09:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab0EPHwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 03:52:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34127 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab0EPHwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 03:52:42 -0400
Received: by gyg13 with SMTP id 13so1676634gyg.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9diKgIetlgoKW5IXDtvog4gJpivoKsypGTru+OzFUqw=;
        b=ciTEPNDtjuW5QsyU4Cdi/Vs84P9BojjucUmwFwPhImpVka+PLgzpAxQkdor79Iej+k
         Z1uGMqV7EHP8x2zLqQm/Yv7nKjuCixK6pq6eHLrxAMO42jW/6sY5S49Bsn6KBteUOWaN
         k6QeOtbb9vPRbSnnjw4z4iaOPjG/qaSUw6unM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tYWL9zdks8KQhvuhDBJxPPD9QVwtbWcUy/4pmeNd9STdDAL4B01hdF68vcfyv4S6j2
         pKmD2AW0Q/vKRmpnSJiCdsqoBWfZNIupPmW9kRMcioyfU3qb0r7nHgw1cZOIIqPO+6Hv
         ZkQLzJ+q1D3WD301MmwT05KES6nJPpEKD2y9s=
Received: by 10.150.117.20 with SMTP id p20mr4389211ybc.31.1273996360174;
        Sun, 16 May 2010 00:52:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id s17sm35134446ybc.21.2010.05.16.00.52.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 00:52:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinSJTzYOk_MRp2ddlLnbd5dC65q-c4zQbv8Oubj@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147178>

Pavan Kumar Sunkara wrote:
> =C6var Arnfj=F6r=F0 Bjarmason wrote:

>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -203,3 +203,4 @@
>> =A0*.pdb
>> =A0/Debug/
>> =A0/Release/
>> +[0-9][0-9][0-9][0-9]-*.patch
[...]
> git format-patch -M origin/master -o outgoing/
>=20
> So, my patches will be in subdirectory outgoing.
> But the regex rule in this patch won't be able to hide them.
>=20
> What do u want to do in that case ?

Try it out.

In fact, I was worried that this patch would trigger a similar
problem: maybe some test data directory contains format-patch
output?  In fact none do, so I like the patch.

Thanks,
Jonathan
