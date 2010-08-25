From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 07/32] tree.c: find_subtree() to search for a tree
Date: Wed, 25 Aug 2010 13:43:58 +1000
Message-ID: <AANLkTinAzJHt3Bc9R0t50dUWqYqP5PGKG6-5Vj3sM=pA@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-8-git-send-email-pclouds@gmail.com>
	<AANLkTi=5OoRWXND4x7YJKTU2kPaBAiUwYMFRocB8RC4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 05:44:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo6uM-0002Ss-9E
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 05:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065Ab0HYDoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 23:44:01 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39314 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab0HYDoA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 23:44:00 -0400
Received: by wwb34 with SMTP id 34so277012wwb.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AgOAIgoOyrOdfwMlMZdh34awejzGAgr2u5yCKE8ForQ=;
        b=goBuLUxeF20th/umHtalFkdswEtZHPYhYfa4gWw/kWJt22Nz1X0bcmGdfKorFBk4lL
         L7K+UW8bDW1hKbBV6/N19yzhzs8eWKLQSP76iwz1LFfKD5BN8ErKJd5Y7jZCvy3NoFSl
         SUyW1v+qTAKrGq4XB7OVno1cEMJMJYyF5xQ3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sZvylONpmvSRTarrgxyWfMX+PDo1KOfMHFgqlHlkwypne5vjP7D7v5vJ8rymeufj+/
         VjQi54QyrwYDR4FOADOgJu449JZh+YkwH9radmXXAfiZpYzA/m7zi7PvEj/ENRSgVYwm
         Cqv41Q4j/3RU+G49Jsrmj0v/wX3IllAIjWrx8=
Received: by 10.216.236.149 with SMTP id w21mr6799144weq.65.1282707838400;
 Tue, 24 Aug 2010 20:43:58 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 20:43:58 -0700 (PDT)
In-Reply-To: <AANLkTi=5OoRWXND4x7YJKTU2kPaBAiUwYMFRocB8RC4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154406>

On Wed, Aug 25, 2010 at 1:35 PM, Elijah Newren <newren@gmail.com> wrote=
:
> 2010/8/24 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
> <snip>
>> +int find_tree(const unsigned char *sha1, unsigned char *newsha1, co=
nst
>> char *path)
>
> Trivial nit: Subject doesn't match the name of the function in the co=
de.
> =C2=A0;-)

Yeah. Been busy fixing code than commit messages..

> Also, when trying to apply your series locally on master, it seems to
> die on this patch. =C2=A0What commit is your series based on?

c11969de, master at Aug 19.
--=20
Duy
