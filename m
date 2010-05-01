From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD PATCH] revlist/rev-parse: Introduce --heads and --locals revision specifiers
Date: Sat, 01 May 2010 12:42:15 -0700 (PDT)
Message-ID: <m3bpczcsup.fsf@localhost.localdomain>
References: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 01 21:42:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Ia0-0004fC-5O
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 21:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab0EATmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 15:42:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37699 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab0EATmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 15:42:18 -0400
Received: by wye20 with SMTP id 20so895764wye.19
        for <git@vger.kernel.org>; Sat, 01 May 2010 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=+2BFrXtZqO1rUFmAme/A/BeVRi+KigyHpr1gvo6gXb4=;
        b=jlC/rFLu8zc2QvrM1lv+o4rpWXsi8jeUxA+WKqmFHMCFbybSCNvNIona1UVOI8lusS
         5lIyOmG8Y69mLx5aZ5S34nH3TIgTtVMhnsp002QUg4yj5qfLh4DZWkgBHGyW6Udkk9sl
         Pafj5SNdm+lhyFcT1AVRaUnMPPPOzDY9mVxI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=bZeQyvjzMl/qJ79fLVveSHmzZPkoHxRUp0ehN78Ute7u9tijGo/4SLV1H9hB01HvuI
         IgpXNdwPoh/mqlCXm8ZaOF5bU8Gh0SXk1+OotLMahrFtPdHONzGZciMBTx6+sCwHVIoN
         1j/UJJgG3ElYgIwJRutBy9UiIqJZggSiucT1s=
Received: by 10.216.180.202 with SMTP id j52mr3823353wem.214.1272742936079;
        Sat, 01 May 2010 12:42:16 -0700 (PDT)
Received: from localhost.localdomain (abvy46.neoplus.adsl.tpnet.pl [83.8.222.46])
        by mx.google.com with ESMTPS id r29sm26696487wbv.3.2010.05.01.12.42.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 12:42:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o41Jfomn002695;
	Sat, 1 May 2010 21:42:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o41JfY9x002688;
	Sat, 1 May 2010 21:41:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146112>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Due to the increasing usage of the ref namespace (e.g. notes, replace)
> the revision specifier "--all" becomes decreasingly useful. But
> "something like --all" is ineeded for getting a quick overview of
> the development state of a repository.
> 
> Introduce --heads and --locals specifiers in order to help with that:
> 
> --heads == HEAD --branches --remotes
> --locals = HEAD --branches --tags

Wouldn't new feature (introduced in 1.7.0) of --glob=<glob-pattern>
be enough?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
