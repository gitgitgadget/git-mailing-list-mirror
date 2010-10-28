From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git rebase --abort of an --onto run does not checkout the originating branch
Date: Thu, 28 Oct 2010 09:22:08 -0700 (PDT)
Message-ID: <m3wrp2gufb.fsf@localhost.localdomain>
References: <4CC1C34E.8090203@workspacewhiz.com>
	<7vlj5qkpjc.fsf@alter.siamese.dyndns.org>
	<4CC8E84C.3030709@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 18:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBVF4-00008T-Ie
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 18:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758362Ab0J1QWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 12:22:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34226 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab0J1QWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 12:22:12 -0400
Received: by bwz11 with SMTP id 11so1727647bwz.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=HrRoqaODExr2f/vzF/DN78ss1MsfetSoOuJwKtmDBT4=;
        b=C61OA4TljpFLSJIDi0CNdmGDIraWfDjDpmvBJMhZZb9scNtU1B6KEOQ2NJwQuUrEi9
         hjsTR1WeUCyWrEJ0vowqQ6IoIcEp6lxDqNx5pw6PPAW6rPgwwS3UpIueAtwqkrLJLKb8
         0pR90w94lnOYEan2dsBod2Lb/q+iYp7rbchQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Lz+1IL6pKYBbzPEhMzKZm9FrFBgCGEBoB6RGF/3qybdxf7jck/EFoid3IGDHmuQFHx
         vCWBiLwOlpxS0kNBVCg5J/1NZ5BJqq6NFvDfKHJjab0HzIgXJSIC8vrQwUuxTc1MEDUU
         tncDDe/X9hWr3rLXH53C8w5XZnZig1eVNLflM=
Received: by 10.204.122.8 with SMTP id j8mr862687bkr.135.1288282929336;
        Thu, 28 Oct 2010 09:22:09 -0700 (PDT)
Received: from localhost.localdomain (abvj108.neoplus.adsl.tpnet.pl [83.8.207.108])
        by mx.google.com with ESMTPS id f21sm20625bkf.12.2010.10.28.09.22.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 09:22:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9SGLZ6J011826;
	Thu, 28 Oct 2010 18:21:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9SGLCdi011816;
	Thu, 28 Oct 2010 18:21:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4CC8E84C.3030709@workspacewhiz.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160186>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> I'll just have to remember where I was when I started the rebase,
> perform the abort, and checkout the originating branch.

"git checkout -" (or its generalization "git checkout @{-<n>}").

P.S. This is discounting whether there is bug in "git rebase --abort"
after using it with `--onto` or not.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
