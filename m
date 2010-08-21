From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 01:22:05 -0700 (PDT)
Message-ID: <m3wrrknzph.fsf@localhost.localdomain>
References: <20100821092616.5e57135b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 10:22:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmjLY-0001eE-4b
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 10:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab0HUIWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 04:22:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49943 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab0HUIWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 04:22:07 -0400
Received: by bwz11 with SMTP id 11so2689081bwz.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=pgM0QfIaIHxgNWs8QJuSve/12cFx0QLXjLwaWd+ODGM=;
        b=HIUyjArKMwQSTcmNPVPXGKPjhVChcX1942C6xtcBmJMwqmSWG5rWGSfs1nLYY/PwJM
         QcMhWyDJL+XUDN60I/JPZShlO1eexyJc+Mnzezeta5cjozh9KIQ+imRWRK2xaeuuf21v
         R+5x4/3kpvnNQE1zOYfH9RjUr6CAQzV9V+4vM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Gg+H6trhSTjUxKRhoL2QTX6eiJKCLKHS05t+3zcX7d48IvFvGEeDEWzSEICo9BJrQp
         uF90AVJUPxVz+R3LfkQGVmAqIoIgnk4N57OAglf683sv4ecFv2rEqQhC1J7FHE0AbFQz
         RWWxiapwyW9pL4FQ2/EGGEx09oKLvA/TAHyN0=
Received: by 10.204.126.92 with SMTP id b28mr1812326bks.47.1282378926641;
        Sat, 21 Aug 2010 01:22:06 -0700 (PDT)
Received: from localhost.localdomain (abwo112.neoplus.adsl.tpnet.pl [83.8.238.112])
        by mx.google.com with ESMTPS id f10sm2730992bkl.5.2010.08.21.01.22.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 01:22:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7L8LW9K029966;
	Sat, 21 Aug 2010 10:21:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7L8LGSW029958;
	Sat, 21 Aug 2010 10:21:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100821092616.5e57135b@hyperion.delvare>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154125>

Jean Delvare <khali@linux-fr.org> writes:

> I have a feature request for gitweb. In the history view, I would like
> to be (optionally) able to see the tags, interlaced with the actual
> commits. The idea is to get an immediate view of all commits that
> happened between specific tags.
> 
> The actual format for displaying the tags can certainly be discussed, I
> have no strong opinion on this myself. We may want to let the admin
> filter which tags should show up that way, maybe even letting him/her
> define primary and secondary tag formats (think main releases vs.
> release candidates) for nicer output. Then we may want to group (or
> hide) tags when a file hasn't been modified in a long time. But these
> are implementation details, even the raw functionality would be quite
> useful IMHO, and hopefully not too difficult to implement.

Currently in 'shortlog' view you can see 'ref' markers... which
include tags.

For example 'shortlog' view for 'maint' branch has the following
fragment:

 2010-07-28 	 Matthieu Moy	 Document ls-files -t as semi-obsolete.
 2010-07-27 	 Junio C Hamano	 Git 1.7.2.1  [v1.7.2.1]
 2010-07-27 	 Junio C Hamano	 Sync with 1.7.1.2
 2010-07-27 	 Junio C Hamano	 Git 1.7.1.2  [v1.7.1.2]
 2010-07-27 	 Junio C Hamano	 Sync with 1.7.0 series
 2010-07-27 	 Junio C Hamano	 Git 1.7.0.7  [v1.7.0.7]

where e.g. [v1.7.2.1] is ref marker for 'v1.7.2.1' tag.

If you have something different in mind, please provide moackup,
either as ASCII-art, or link to HTML or image.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
