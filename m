From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Large media in git (was: How it was at GitTogether'08)?
Date: Mon, 10 Nov 2008 10:30:53 +0100
Message-ID: <200811101030.54070.jnareb@gmail.com>
References: <200811080254.53202.jnareb@gmail.com> <200811091731.48694.jnareb@gmail.com> <200811091955.19304.kai@samba.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tim Ansell <mithro@mithis.com>
To: Kai Blin <kai@samba.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 10:32:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzT8H-0001ET-3B
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 10:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYKJJbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 04:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbYKJJbM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 04:31:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:4920 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbYKJJbK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 04:31:10 -0500
Received: by ug-out-1314.google.com with SMTP id 39so313826ugf.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 01:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uANM35iXFALtT4mBvgx71BzVTm7fOYuUn6PQ5ql0L5s=;
        b=gXLv6O82qvlk5yg4lOnmT9GpGicNRzKu7/pJNfnSkJCOPfFTH7NvPaPEn/t7ZuiyWe
         flt410diNTgXB16QRq3lQfAESux3zNjNP5WEq1OqWIqdVplXwFJ/63IVpZyRa+WkZ1R4
         FH1A0UMzEzJ60clI1gQfkeJhfZVc8z76gClGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=g4gInJKelM362K1alnJgKJIBSnmNe69w8uaVWJDBtFGhiDmIWLKFlBQBxTfsP5mF1I
         xsjbgVZcWO3u82N7dtGdwgdbd05CzbKWYRyvrYQg3zUHg14Do0GwowQY/4TPyhU8pCmQ
         j77rHPPcMo8V3BulEbTQpoCbETpRw2K275/Rc=
Received: by 10.67.96.9 with SMTP id y9mr1863233ugl.64.1226309468324;
        Mon, 10 Nov 2008 01:31:08 -0800 (PST)
Received: from ?192.168.1.11? (abww18.neoplus.adsl.tpnet.pl [83.8.246.18])
        by mx.google.com with ESMTPS id e1sm7098983ugf.7.2008.11.10.01.31.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 01:31:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811091955.19304.kai@samba.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100501>

On Sun, 9 Nov 2008, Kai Blin wrote:
> On Sunday 09 November 2008 17:31:47 Jakub Narebski wrote:
> 
> > The workaround is to put all large files for example in 'media/' folder,
> > and make this folder be submodule. Each clone of repository can have
> > this 'media' submodule either present (both in object database, although
> > usually separate from main project object database), or not present
> > (not cloned and not checked out).
> 
> Tim was talking about that media/ folder and managing that in git. If you want 
> to work on the media, you might end up getting hundreds of gigabytes of data 
> to get that folder, even if you only need to change one single file.
> 
> That's the issue we're running into, and I don't thing submodules solve this 
> at all.

Ah, well... Submodules cannot be workaround for _this_ issue. You can
have only all or nothing: either all files in media/ or none of them,
both in working directory like in repository object database... well
unless you subdivide further.

I guess that mentioned work on the media is in remote setting (you
cannot have main repository on network drive) so Dana How's proposed
solution would not work for you, is it?

-- 
Jakub Narebski
Poland
