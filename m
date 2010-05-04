From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: preserve permissions?
Date: Tue, 04 May 2010 06:08:00 -0700 (PDT)
Message-ID: <m3fx27g6i8.fsf@localhost.localdomain>
References: <C1288762-C750-4919-A853-5E3229870A59@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Chetwynd <j.chetwynd@btinternet.com>
X-From: git-owner@vger.kernel.org Tue May 04 15:08:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9HrI-0002zD-7s
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 15:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758780Ab0EDNIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 09:08:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:41318 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab0EDNIK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 09:08:10 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1539949fga.1
        for <git@vger.kernel.org>; Tue, 04 May 2010 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=jZW2jRF1RD8whf8NQsacMQuaKDUzVMQcp0q3rZrnJqE=;
        b=cAT+4LKIaRppElLBf0cf6Ffh8onoEjPRPzBcA1dZKHlKlmbZAq3A08Tqg3sK/B98/j
         GXs/PdS2oCm2wDrLtJRP/KV7Hko5NgYcB+/P87VuN4uH+pgxFeFaiRrrHJfmcSNuG9Fv
         tulqwLUemOWnJ2kJ+yCrUC7T4T8rJWNR4RIZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=h04E7If5AOdSP3kelyuIDjyWyNkf7gISCoufgEZpqEwzUkK+ClVScjYUiJFQSc2xFF
         fZnIsQPHtNfDUxT/+XurkG1ICR3l1ubavaiRZBvZT9P/pX/+zdo+n28DYazennwF4aU1
         e620GSSbv0ohFBwKInWz9Hr6fTbB8r4X8hoRs=
Received: by 10.87.69.8 with SMTP id w8mr12649634fgk.58.1272978481546;
        Tue, 04 May 2010 06:08:01 -0700 (PDT)
Received: from localhost.localdomain (abrz91.neoplus.adsl.tpnet.pl [83.8.119.91])
        by mx.google.com with ESMTPS id e11sm10980389fga.18.2010.05.04.06.08.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 06:08:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o44D7iga024769;
	Tue, 4 May 2010 15:07:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o44D7SKo024759;
	Tue, 4 May 2010 15:07:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <C1288762-C750-4919-A853-5E3229870A59@btinternet.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146312>

Jonathan Chetwynd <j.chetwynd@btinternet.com> writes:

> git clone ../xsl-test/
> 
> the original has a single directory, owner _www, and a few files.
> 
> however the clone directory has owner Me.
> 
> what is the reason permissions are not preserved?

Why should permissions be preserved?  Git is a version control system,
meant mainly for software management, not a backup system.  

When you clone repository from somebody, you don't want for files to
have that somebody ownership, especially that such user most probably
do not exist on your machine.

Therefore git does not store ownership, and only basic permissions
(only executable bit for ordinary files, and the symlink bit).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
