From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git commit return code
Date: Mon, 9 Aug 2010 16:13:11 +0000
Message-ID: <AANLkTi=HKBjT6=_RUNwPWJO-KsqgkjWUsxT_ontdvj6a@mail.gmail.com>
References: <4C601F9B.6040102@puffy.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tomasz Pajor <nikon@puffy.pl>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiUyV-0001fb-LQ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011Ab0HIQNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 12:13:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39506 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636Ab0HIQNM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 12:13:12 -0400
Received: by gyg10 with SMTP id 10so3454703gyg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=s/z5k4p7VoczZJz+c73RUZwCNYOsQP5UI+T7opv5Rtw=;
        b=vWDRgyXoQt/MijypNwfiKzqVzcyNlT9ONUEhdnrjCcuybk8crbKG19mhIzMNoNSbzx
         vDMWeC+3XIyYWNpCak3zoq1iLf298LPdQth9Lr7WTG6icCSoZWliNKKOx5Fa7C0viCHW
         Glvo32ye4HNF+MN6OhJRPa/rHy1CqXe8r5hNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XxcFmUz+dNKvcbrivAdeFVfgFzU7yO5kQHfzc12PT6CVqmemfJ+nVo5aNU67fuDlds
         aGNXzz/nGXmg6i8mqd9Y0IkRLAraITGyt1CmnT1cnxjokr4Cd6ZOrwxED5GTpVamq7jU
         ofG64EcaJWax6DVQjj4m0/xuC5YYNW8id+2dk=
Received: by 10.90.87.2 with SMTP id k2mr11276729agb.111.1281370391858; Mon, 
	09 Aug 2010 09:13:11 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 9 Aug 2010 09:13:11 -0700 (PDT)
In-Reply-To: <4C601F9B.6040102@puffy.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152977>

On Mon, Aug 9, 2010 at 15:32, Tomasz Pajor <nikon@puffy.pl> wrote:

> Is this proper behaviour:
>
> root# su <username> -c "git commit --quiet -a -m \"templates generation\";"
> # On branch master
> nothing to commit (working directory clean)
> root# echo $?
> 1

Yes, you asked it to create a commit, but there's nothing to commit.
Hence the failure to commit.
