From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: [TRIVIAL] Documentation: merge: one <remote> is
	required
Date: Tue, 11 Aug 2009 16:42:53 +0200
Message-ID: <20090811144253.GA12956@vidovic>
References: <1249995838.1589.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
X-From: git-owner@vger.kernel.org Tue Aug 11 16:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MasZB-00035d-AS
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 16:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZHKOm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 10:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863AbZHKOm7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 10:42:59 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:64233 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbZHKOm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 10:42:58 -0400
Received: by ewy10 with SMTP id 10so3829361ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=VnsfkOrLPmijTGkGrmEzTFUqCFhGqSETzuTUIMncDok=;
        b=k0d2eWzyeEElEctrtavBpUifXwly9L6Q3+6ADzYOjHu29reaf0jwbYAFBhMwiNwVHi
         SxyNzbbyKVD3m9orNeDSc/RzfbtBsun3T9ddkHB5J4a7KtHHpetCsV4yypH4rv9I147/
         PMAM9u1JL+zoA79myEXwVsK2ghbD61Y/ni40I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xRFkNaVk4/pShyTwIGQdfOWVm59mBGcgpu8KIXLODn6nNgvNe7ZyK2ZMMyD49Weovc
         0vmTY3/XHeEdvdZk03JVAx9yRsNcpT5gOymFJ6M37hquwaSn+0buQEKRs6iOu03LAwLz
         CUWlEifJSJIiKF2RHR/xf1yhDqUT0QfRTutHo=
Received: by 10.210.129.20 with SMTP id b20mr6555329ebd.78.1250001778907;
        Tue, 11 Aug 2009 07:42:58 -0700 (PDT)
Received: from @ (91-164-138-47.rev.libertysurf.net [91.164.138.47])
        by mx.google.com with ESMTPS id 5sm833348eyh.6.2009.08.11.07.42.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 07:42:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1249995838.1589.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125565>

The 11/08/09, Paul Bolle wrote:
> merge only requires one <remote>, so "<remote>..." should be used in the
> synopsis (and not "<remote> <remote>...").
> 

<...>

>  'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
> -	[-m <msg>] <remote> <remote>...
> +	[-m <msg>] <remote>...
>  'git merge' <msg> HEAD <remote>...

Shoudn't be 

   [-m <msg>] <remote> [<remote>...]

or

   [-m <msg>] <remote>[...]

instead?

-- 
Nicolas Sebrecht
