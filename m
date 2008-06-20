From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Are C++ contributions welcome?
Date: Fri, 20 Jun 2008 07:16:06 -0700 (PDT)
Message-ID: <m38wx0mbuu.fsf@localhost.localdomain>
References: <4c88165dd0077363a30b4f98fed16c2f@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jose maria gomez vergara <josemaria@jmgv.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 16:17:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9hQT-0007Ot-5l
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 16:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbYFTOQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 10:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755866AbYFTOQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 10:16:09 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:43304 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375AbYFTOQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 10:16:08 -0400
Received: by an-out-0708.google.com with SMTP id d40so289769and.103
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=7COw1DYyRqNgAFarbZdCQRsT93PGjML0nNST19IqTqQ=;
        b=tNlvAWrXaHxTe/Uv35KTFDNlbFNDH+HzLfokVCmqhVeOzipXFO0/4aBpISxCMp64wh
         eQKdNMy4fVEtPe75sdunOW1DiR0Fddt6AxDPt1nNqhfeBAInAqNjvUEpp+M2w09qRPAs
         rPmhcyXxmbFEFbDvnaZ9odrLGLjOYdp0B5VSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=p/18T+1yAvNi7Qg4nsYT91f98emdV+RwoJLhYLfqbYxEXlBulV+EPaut3ziboGms2x
         XC3gHZzBqzp8Rz2x4bx+ZOIbL01+xisuWMdRGoTZQHT1erQzPOuaRSVsZe5s6hpZUYGI
         szmiHo7gqsx+KjMeZl1GdoSlrTyYFFpgrtFV8=
Received: by 10.100.139.20 with SMTP id m20mr5551555and.135.1213971367218;
        Fri, 20 Jun 2008 07:16:07 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.51])
        by mx.google.com with ESMTPS id c78sm1474841hsa.12.2008.06.20.07.16.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 07:16:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5KEFeK1007410;
	Fri, 20 Jun 2008 16:15:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5KEFLWZ007406;
	Fri, 20 Jun 2008 16:15:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4c88165dd0077363a30b4f98fed16c2f@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85649>

Jose Maria Gomez Vergara <josemaria@jmgv.org> writes:

> I think Git is a really good project and I would like to contribute to it.
> I have been having a look to the source and I have realized on that all
> code is C (well and Perl for some scripts and so..). I know that C++ code
> was not welcome sometime ago, but I don't know if this have changed.
> 
> I don't feel comfortable programing in C and I prefer C++ only because I
> have more experience using this one. May I contribute to this project in
> that language?.

I don't think that C++ would get accepted because it would introduce
another dependency; if not runtime dependency (libstdc++), then build
requirement (C++ compiler).

And I think it doesn't bring much: git is not some GUI application
where OOP works best; it is 'close to the metal' (performance), where
I think C works best.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
