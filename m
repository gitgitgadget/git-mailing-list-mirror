From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2009, #03; Wed, 29)
Date: Wed, 29 Jul 2009 17:50:46 -0700 (PDT)
Message-ID: <m3vdlb0zb6.fsf@localhost.localdomain>
References: <7vzlanqj9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:50:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJrD-0006lC-1C
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbZG3Aur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbZG3Aur
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:50:47 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:43743 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbZG3Auq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 20:50:46 -0400
Received: by ewy10 with SMTP id 10so402767ewy.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 17:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=N4HalLpPQkXNepbn1Ea4UeDXxa3ZgElKpIa2sZ8ED7o=;
        b=ciLvwXTHTbgYeNlJmSERNPYViD5fkDQN2CWp+0NxxaSooShjQRfAOVYlaZhLySqLmF
         Z8YCLTUrCGml9GZ7ttgCnlN59oBKvX+W2DpKIQjgt45gXqQ5xbCV5IfvPmeELrfNwrNh
         h9MtC0b4d90SwUzAazxwm9dliq76Lw09+K5iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wXUm7TnfX46KE5s5Y1ezUkuLclmx0+DLxZ99P+nH3xlXr8SDaTyx0XDmwB0I9RFqMI
         EIr/w0N8nRBX/RujjqO71cPqJQUeOc7zqBg39RT3xW5MndaEVmOYSLPIMI7T+SYKlpK7
         yiGRRpsQRZZv85SyquurtxIXPkyjvDYLwnWp0=
Received: by 10.210.52.15 with SMTP id z15mr587467ebz.34.1248915046420;
        Wed, 29 Jul 2009 17:50:46 -0700 (PDT)
Received: from localhost.localdomain (abvq124.neoplus.adsl.tpnet.pl [83.8.214.124])
        by mx.google.com with ESMTPS id 5sm1271729eyf.34.2009.07.29.17.50.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 17:50:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6U0oMoX030585;
	Thu, 30 Jul 2009 02:50:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6U0o67a030581;
	Thu, 30 Jul 2009 02:50:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vzlanqj9p.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124428>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-blame (Sat Jul 25 00:44:10 2009 +0200) 10 commits
>  - gitweb: Create links leading to 'blame_incremental' using
>    JavaScript
>  - gitweb: Incremental blame (proof of concept)
>  - gitweb: Add optional "time to generate page" info in footer
>  - gitweb: Add -partial_query option to href() subroutine
>  - gitweb: Use light/dark for class names also in 'blame' view
>  - gitweb: Add author initials in 'blame' view, a la "git gui blame"
>  - gitweb: Mark commits with no "previous" in 'blame' view
>  - gitweb: Use "previous" header of git-blame -p in 'blame' view
>  - gitweb: Mark boundary commits in 'blame' view
>  - gitweb: Make .error style generic
> 
> There may have been updates during 1.6.4-rc period that I missed.

There weren't any updates.  I plan on replacing the 4 top patches soon
(without '-partial_query' one, as it would not be needed), less proof
of concept, but still RFC.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
