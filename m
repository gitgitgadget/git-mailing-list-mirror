From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Single system account for multiple git users
Date: Mon, 30 Jun 2008 09:04:15 -0700 (PDT)
Message-ID: <m3iqvqhptu.fsf@localhost.localdomain>
References: <20080630151113.GO5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDLt3-0004oB-IW
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 18:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbYF3QET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 12:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYF3QES
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 12:04:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:9357 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbYF3QES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 12:04:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so451937nfc.21
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=bl3OR4CSFp0emGItwX301ZXMiNV9xrBkyR2gRPEk8CM=;
        b=xOG8UzM7zigdsCT5fZpr6YNC+wEnI+z67C7xfMWyNFxHzhur7liEDpf7/SKGbUkeiZ
         u69ppcwNyHjma7ZBBcBDfsvzy2jcOcrtFJO1o1c50i8WJ2pscY9UAsDO1AI1IgHYO837
         khNh71BBwm36UGjf+nV0/y6afoYvRapLRO24w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=YmwsFMnwafPBiQXo1h/HC7Af4rKTvacVslNaQ7aCi7LSrzV4azKUYKAbbv0E+0NLV+
         3sKENh0JyyAT3MJbdZc6a846wMibktYZDWU/wS0y5tdNAMU0kc0SncaIff/xkLHccwKa
         PpyVQmY/AuXdMiHM7/9BPcIliYTRUxe634kv4=
Received: by 10.210.44.1 with SMTP id r1mr4332141ebr.143.1214841856358;
        Mon, 30 Jun 2008 09:04:16 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.122])
        by mx.google.com with ESMTPS id z33sm6830864ikz.0.2008.06.30.09.04.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 09:04:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5UG4Dsm020704;
	Mon, 30 Jun 2008 18:04:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5UG4DDA020701;
	Mon, 30 Jun 2008 18:04:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080630151113.GO5737@dpotapov.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86918>

Dmitry Potapov <dpotapov@gmail.com> writes:

> Using SSH access with restricted git-shell as login shell and using
> the script from the update-hook-example.txt works fine, but it requres
> that every Git user has a separate system account on the server, which
> is often frowned upon by system administrators, who would prefer to have
> a single system account for access to Git repo.
> 
> I have looked on gitosis, but it requires normal shell account for
> the git user, which was vetoed by sysadmin. [...]

Have you took a look at ssh_acl from InterfacesFrontendsAndTools
from Git Wiki?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
