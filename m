From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to create v2 patch
Date: Sat, 01 Dec 2007 06:02:23 -0800 (PST)
Message-ID: <m3r6i6wm1g.fsf@roke.D-201>
References: <47515693.9070405@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
X-From: git-owner@vger.kernel.org Sat Dec 01 15:02:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IySvf-0003eo-GK
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 15:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbXLAOC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 09:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbXLAOC1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 09:02:27 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:51978 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbXLAOC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 09:02:26 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1155994mue
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=eV5yXa+VdUzRRq80rOW6DA4GQpckBI3GHBl85CxnMKI=;
        b=HjN3AFJ0GCjhMKIRA8ZqRkWVsKrk9zyJWSR0291FMpba+HjxmAIvgcVHE//q06u4df337FgsAZvXZrbth5JZ94kiVmmXv1WysjD6IfjSd0MGxhWYssP0fUARKGeIvnQTmT/Oyfp9fk2Kre9EtWh4pJ1Q5Zx/ANSl82KSwhwcXGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=H1AuBYD7FiKk3YMQYe3oXHZKZ8Crbh7RRPRrXy0GNwKpvVmDGTWQLL3vr9o1ZnND0Q9ezs2i3PJckF3eJWcIH4Ll3hOhvJsELODy7/BBD02F7mpTeF2DOvbET9b7kUrve8ZUjBZITvykoYdzpldaLjErHlYIzMYhk2G0mpzg5Ms=
Received: by 10.86.73.17 with SMTP id v17mr2467068fga.1196517744158;
        Sat, 01 Dec 2007 06:02:24 -0800 (PST)
Received: from roke.D-201 ( [83.8.236.184])
        by mx.google.com with ESMTPS id e11sm4797738fga.2007.12.01.06.02.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2007 06:02:23 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB1E2KfA002460;
	Sat, 1 Dec 2007 15:02:20 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB1E2JRO002457;
	Sat, 1 Dec 2007 15:02:19 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <47515693.9070405@imap.cc>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66718>

Tilman Schmidt <tilman@imap.cc> writes:

> Let's say that following the scheme laid out in
> "Everyday GIT ...", chapter "Individual Developer (Participant)".
> I have produced a patch, submitted it to LKML, received a few
> comments, committed appropriate changes to my local git tree,
> and now want to submit a revised patch. How do I do that?

If you have original commit and commit with corrections on top of it,
do a squash rebase using "git rebase -i" (interactive), or do a squash
merge.

In the future it would be better to just amend ("git commit --amend")
original commit (or if you are using StGIT, "stg refresh" it).

-- 
Jakub Narebski
Poland
