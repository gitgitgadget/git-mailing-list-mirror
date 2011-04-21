From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fork or branch?
Date: Thu, 21 Apr 2011 07:38:08 -0700 (PDT)
Message-ID: <m3sjtbwu01.fsf@localhost.localdomain>
References: <1303390999618-6293910.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: adam_kb <a-kyle@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 16:38:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCv1N-0002wT-GU
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 16:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab1DUOiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 10:38:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54101 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab1DUOiL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 10:38:11 -0400
Received: by bwz15 with SMTP id 15so1463216bwz.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=2mzzRKnCaN1X28bhZ4nvHDswr8QMvoAHXP2kSJQ0Mr8=;
        b=HO6skU8xADPn1f1gp0URTAdaeK9T5198fm3Eo5XYhC2kwMUfO2ME/fJ2Iy5vfZdNpP
         7hQYjDpVr8kWz7PEcddAtlGKTEJmAuArLmTEh2aPRKNolyaQhkuMMT7SmNxdRCd1D95a
         q0ge6Ic8E0vTdJoBCAm4ZaBHHZRFkYKyAJwqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=CxPQKls5t5MToInAzvVrTc9llqZkr2FWuCbEg10/EDYGJi8Pgsd2Mlnc6QJ29lmX66
         D6xtmAvL4kSitvsjDTU8CcwvDIRG8uqJV0V8+6ayyE/wXRZcNI7+vsiPfCAGgHo68bJG
         zg/5c1V1Xgqc78lrlEDPy3PHrgbw7F2Pdv4ok=
Received: by 10.204.32.9 with SMTP id a9mr7887bkd.182.1303396689849;
        Thu, 21 Apr 2011 07:38:09 -0700 (PDT)
Received: from localhost.localdomain (abwt1.neoplus.adsl.tpnet.pl [83.8.243.1])
        by mx.google.com with ESMTPS id x6sm1161987bkv.12.2011.04.21.07.38.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 07:38:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3LEbaWQ005663;
	Thu, 21 Apr 2011 16:37:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3LEbJkI005656;
	Thu, 21 Apr 2011 16:37:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1303390999618-6293910.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171908>

adam_kb <a-kyle@hotmail.com> writes:

> I am new to git and understand most of it except for merge. My question is -
> if I have project X on branch master and its coded in python but I then want
> to take that same project and code it in say C or C++ would I fork or branch
> the project? 

If you do not plan to merge your changes / your rewrite into project
X, then it is a fork (like e.g. LibreOffice.org is a fork of
OpenOffice.org).

Branch is in-repository line of development, e.g. 'stable' and
'unstable', or 'maint', 'master' and 'next' branches.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
