From: Jakub Narebski <jnareb@gmail.com>
Subject: git-archimport (was: Re: RFD: git-bzr: anyone interested?)
Date: Sat, 07 Aug 2010 06:03:27 -0700 (PDT)
Message-ID: <m3iq3mo9t5.fsf_-_@localhost.localdomain>
References: <4B7D8358.1080108@gmail.com>
	<fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
	<4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>
	<4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>
	<4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix>
	<p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
	<AANLkTi=a27OtQX-oNwPqmXDUmZHFyKo+fPZCRgSv04G3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Conrad Parker <conrad@metadecks.org>
X-From: git-owner@vger.kernel.org Sat Aug 07 15:03:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohj3p-0001Ns-8b
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 15:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab0HGNDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 09:03:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62502 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab0HGNDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 09:03:30 -0400
Received: by fxm14 with SMTP id 14so4327786fxm.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=McEGNccIGiAL6unnIoC9Ux1d5AunNN7syrEIXlwBg5k=;
        b=LDsqc3rWhNcdqKDTzAmOWnZZLSYf4P6JP7/NuFEptlVTd1df4yyaK8my9zhgnZPVsU
         9uLcCqJA1n3HyzW83H8TCqVpULlLNMqpHwggbHfOgH2jXqbbdq1dQf2Fi/cMuXi7ukir
         jiy+PcTrFew1JmPjf1MI14si+mlPHqJbMf+C8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=QpTrHd12uuzY7X9e5vbQ4FTqx4lJrV/g6lTpQK21C9QJAyiKrfzHnF3NyFISMEeie2
         316GKug/OvRM7RUiabtkJ9AzVaPZtNozYkTQoMwVXNiH1tfOt4oZ2jkhqlBqLo/+cTWY
         WHy9p2q03yFLUy/xdqa6cVIC7C4zlbW2ZhdI8=
Received: by 10.223.103.202 with SMTP id l10mr14299574fao.7.1281186208749;
        Sat, 07 Aug 2010 06:03:28 -0700 (PDT)
Received: from localhost.localdomain (abwi49.neoplus.adsl.tpnet.pl [83.8.232.49])
        by mx.google.com with ESMTPS id c5sm1029207fac.43.2010.08.07.06.03.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 06:03:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o77D2biR004204;
	Sat, 7 Aug 2010 15:02:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o77D2FeD004191;
	Sat, 7 Aug 2010 15:02:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=a27OtQX-oNwPqmXDUmZHFyKo+fPZCRgSv04G3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152854>

Conrad Parker <conrad@metadecks.org> writes:

> Anyone interested in git-bzr might also want to look at some recent
> rewrites; from the current git-bzr README:
> 
> The following are rewrites in Python and may offer better bzr integration:
>   * http://github.com/termie/git-bzr-ng
>   * http://github.com/matthew-brett/git-bzr
> 
> (... and I'd also be interested to know how well either of these work :)
> 
> cheers,

By the way, perhaps it is time to finally retire git-archimport, or at
least move it to contrib section.  Is there anyone using it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
