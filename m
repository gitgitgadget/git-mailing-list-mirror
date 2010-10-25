From: Dominique Quatravaux <domq@google.com>
Subject: Re: git rebase and merge commits
Date: Mon, 25 Oct 2010 13:23:47 +0200
Message-ID: <AANLkTinhi=4nUn_anUEuz=m9=E7QJsJFWNBfO2yTtnUi@mail.gmail.com>
References: <AANLkTikroNPehcyBsueCnJ5hR0idd3cBP4m1KNccdRqL@mail.gmail.com> <20101020173201.GA10537@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 13:24:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PALA2-0004GQ-HX
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 13:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab0JYLYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 07:24:13 -0400
Received: from smtp-out.google.com ([74.125.121.35]:52788 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0JYLYM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 07:24:12 -0400
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com [172.25.149.7])
	by smtp-out.google.com with ESMTP id o9PBOARh004523
	for <git@vger.kernel.org>; Mon, 25 Oct 2010 04:24:10 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1288005851; bh=HcBK0oroJGvGZG/4cJKcbLQGl/k=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=a1ymktIrxNEppuupdXqXl0pAKMpaR97hqONFrXmA2ZxKT3mlJBE20QIhEI9zJOhMK
	 UUcMRyd/v9Y8SohcrlxJA==
Received: from gxk5 (gxk5.prod.google.com [10.202.11.5])
	by hpaq7.eem.corp.google.com with ESMTP id o9PBO9Re026849
	for <git@vger.kernel.org>; Mon, 25 Oct 2010 04:24:09 -0700
Received: by gxk5 with SMTP id 5so2523286gxk.26
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vmZyG1uADg6GiQRSDAOgCGGmbdTzmr7kY1cTP89/MBo=;
        b=T6JFYirdVnOUkbB0WjqgnFxYlgLzyvstIB07Q7PuANneDvUTvnj2UmhjNidhdAt786
         cuJKcSYV42A+o3zPt5pg==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FG0H+wBT2MaT4o/CSmi0OjrPnyUo9fUHc3gnyeDGNS99zeRa5V/ptvX4t1d0gT9Psq
         tMPQXiiYfAmnNSK0rgTQ==
Received: by 10.151.106.7 with SMTP id i7mr13098855ybm.145.1288005847282; Mon,
 25 Oct 2010 04:24:07 -0700 (PDT)
Received: by 10.100.205.11 with HTTP; Mon, 25 Oct 2010 04:23:47 -0700 (PDT)
In-Reply-To: <20101020173201.GA10537@burratino>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159944>

On Wed, Oct 20, 2010 at 7:32 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Luckily, there is a roadmap for anyone interested in implementing it.=
 =A0Maybe
> it could be you? =A0See [1] and the surrounding thread.
>
> Thanks for your interest,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/148059/foc=
us=3D148144
>

I gave it a shot last week, but this is more that I can chew on in my
spare time. Sorry! Thanks for the information anyway.


--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
