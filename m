From: =?ISO-8859-1?Q?Daniel_Fran=E7a?= <daniel.franca@gmail.com>
Subject: Re: error commiting in Git
Date: Sat, 31 Jul 2010 19:38:41 -0300
Message-ID: <AANLkTi=ExhKbUC4yqmPudD_=SpGxxV6MUm-bhaycSJOu@mail.gmail.com>
References: <AANLkTimOZr8zq8uXdrzrpLMTDQqwJkZEyxB_zcWFEYBs@mail.gmail.com> 
	<AANLkTimqWF7gZHAXFOmz0URdDTF=CfMmjJrBwmFavUkK@mail.gmail.com> 
	<AANLkTi=n-J5rMOz0pkcxQZ7VgGs_EtXpotO=wZoDyz=C@mail.gmail.com> 
	<20100731223356.GB7490@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 00:39:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfKhx-0001af-4o
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 00:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab0GaWjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 18:39:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49030 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0GaWjB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 18:39:01 -0400
Received: by pvc7 with SMTP id 7so948625pvc.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 15:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yZ69oTJBAJMDvVvHLiidAMOS9OFYtMXmHnLVC0W+tkU=;
        b=aWHpvrUYhi46+uqWaylUc5oDaGg9M7PWaytrObFmpcO01SlAMHvoZSUkZ6gzyvPcaS
         PwvEo4uF0SCxDeUh7vjtaoXqclBlWxOuULAIG51MMc7HX+0dnmWZv2tEuB97tOPZXVwi
         oomvPpePqUhUu5iOb6p1P0apfPEqbeIR99lBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bS/xNQi+gSRVpRmvxswSSodJWIeTLtvisGozkCSbI0boaJt3y9rKdJ/XJzoicNpueZ
         hYbGLy6gBOlxliiARoRZ2UDwFMN0x1uYOvrBZ2RFAvgB2AHjWHGZh5dWnLtsdDX+aF57
         2Pc4+dOgatnbbtYsp0W4QKaojjKCFjZbHwFIk=
Received: by 10.114.131.2 with SMTP id e2mr4632923wad.43.1280615941183; Sat, 
	31 Jul 2010 15:39:01 -0700 (PDT)
Received: by 10.115.23.7 with HTTP; Sat, 31 Jul 2010 15:38:41 -0700 (PDT)
In-Reply-To: <20100731223356.GB7490@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152344>

Thanks for the fast reply
git version 1.7.2


git commit -a -m 'Teste'

Even when I try to commit using SmartGit or GitX, the same error of
commandline happen

2010/7/31 Jonathan Nieder <jrnieder@gmail.com>:
> Hi Daniel,
>
> Daniel Fran=E7a wrote:
>
>> now when I try to commito some file of my git project I get the
>> following error:
>> find: illegal option -- n
>> find: illegal option -- a
>> find: illegal option -- m
>> find: illegal option -- e
>
> Could you give the git version you use, the command you ran, and the
> exact response? =A0=93git commit=94 is not a shell script and does no=
t run
> find, so it is hard to guess what is going on from the extract you
> gave.
>
> Jonathan
>
