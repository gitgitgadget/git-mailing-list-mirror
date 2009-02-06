From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Count the line of codes
Date: Fri, 06 Feb 2009 06:08:32 -0800 (PST)
Message-ID: <m3zlgzvesp.fsf@localhost.localdomain>
References: <21868069.post@talk.nabble.com> <gmgs1u$lsv$1@ger.gmane.org>
	<vpqy6wjg24s.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Gilger <heipei@hackvalue.de>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRP8-0005ym-L4
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891AbZBFOIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756230AbZBFOIg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:08:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:34667 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482AbZBFOIf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:08:35 -0500
Received: by nf-out-0910.google.com with SMTP id d3so138263nfc.21
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 06:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wWRnxbgObsVWDtVB/p6ezPX0c5040ALF7ZAAimLNOyE=;
        b=xg+BgCuSxSGATDyRV1i8nZSMILC+O5q+JsytkG9/RjFKSXcoIz9FtWnO6AtHl4rrJt
         9KXAv1p4rro13tcr37y+mBLzjUMR68EswBgjhnRDmquiAYgFOJPxdRm/wTgYSczfbG95
         8HRvPn6nnVHGB/KyArv9NB0fOSAeRRaegCffI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rtKvSZeyxokEj4sff9qkVIOyG8p2KLBJ9d9OTLzwGSQ5wZ52kgGCH+CgyhYjtLoUUN
         phZiwYQBkDGeu2cxlpm6wRt0qOF5V7TJ4TKL+KwacDIuD1rtkNiFekv5ocCHgc+62TxO
         tEPMx3/fKTg5k2h6+K7FjAcCN+oyFqsuhAU48=
Received: by 10.66.241.13 with SMTP id o13mr555723ugh.31.1233929313135;
        Fri, 06 Feb 2009 06:08:33 -0800 (PST)
Received: from localhost.localdomain (abuz248.neoplus.adsl.tpnet.pl [83.8.197.248])
        by mx.google.com with ESMTPS id d38sm737062ugf.23.2009.02.06.06.08.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 06:08:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n16E8PK1016915;
	Fri, 6 Feb 2009 15:08:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n16E8NKF016911;
	Fri, 6 Feb 2009 15:08:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <vpqy6wjg24s.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108710>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> Johannes Gilger <heipei@hackvalue.de> writes: 
>> On 2009-02-06, zyk <zhengyuk@hotmail.com> wrote:
>>>
>>> Does anyone know if there is any tools available for counting the line of
>>> codes in the project using GIT?
>>
>> wc -l *.c *.h for example would count the lines of all c-files and 
>> their headers.
> 
> wc for the total number of lines in files, or
> http://www.dwheeler.com/sloccount/ to get the number of lines of code
> (excluding blank lines and such).

Or Ohcount (OSS part of Ohloh) from http://labs.ohloh.net/ohcount

Or GitStat (but that is web-based) which you can see at work at
http://mirror.celinuxforum.org/gitstat/

Or git-statistic GSoC 2008 project http://repo.or.cz/w/git-stats.git

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
