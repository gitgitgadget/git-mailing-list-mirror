From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: To graft or not to graft... (Re: Recovering from repository corruption)
Date: Wed, 11 Jun 2008 16:34:31 -0700 (PDT)
Message-ID: <m3ve0fr1fg.fsf@localhost.localdomain>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	<m3abhtp42o.fsf@localhost.localdomain>
	<6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
	<200806102159.02875.jnareb@gmail.com>
	<6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
	<alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
	<6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
	<alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
	<20080611232126.GA9054@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Zqz-0000mY-68
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbYFKXeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbYFKXeg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:34:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:31848 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbYFKXee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:34:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2284122fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=t/hjNWO/z/D4I+vob/M+wVZPvngj2pOWyuAjTQbbgfQ=;
        b=RVhJtY+fVsGJqteyhT/K7tIL2HsAYw9CM8pbvgZQ9+qU4yOzta2NqxTl/xq9jx2YIL
         rZQ4iAsRuCDsEm8ubFR0XkAQW0RoE9z7f7ZQs7dhHp4G6oyp7OziczUOvSSH+CHzCJeO
         Pb+NJgDqZreOjuxLA5hZ1jcA7HWpxUV1/5WPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=daG3mjje3/pYahqWBDqIYWHTotVEZezmR7m/whfY2orvmkuBFQwxC0Rfuo+KFFRpjJ
         arxOgADpEG9JhXwvTQEwyiEE3upwnB/4U2DjyLR5FwMpVAyQFsps83hX80JSMORpuY8U
         8VzC6RvnQj+y933bXPM7wVduP2/sb9Bm4Gmh0=
Received: by 10.86.29.19 with SMTP id c19mr1167880fgc.28.1213227273006;
        Wed, 11 Jun 2008 16:34:33 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.226.105])
        by mx.google.com with ESMTPS id e20sm1162436fga.1.2008.06.11.16.34.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 16:34:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5BNYUfD027281;
	Thu, 12 Jun 2008 01:34:31 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5BNYRUm027277;
	Thu, 12 Jun 2008 01:34:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080611232126.GA9054@cuci.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84685>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> This is kind of confusing.
>
> As I understood it from the few shreds of documentation that actually
> mention the grafts file, the grafts file is *not* being cloned.
> Therefore, my assumption was that cloning a repository that has a grafts
> file gives an identical result to cloning the same repository *without*
> the grafts file present.
> 
> As I understand it now, the cloning process actually peeks at the grafts
> file while cloning, and then doesn't copy it.  This results in a rather
> confusingly corrupt clone.
> 
> I suggest two things:
> a. That during the cloning process, the grafts file is completely
>    disregarded in any case at first.
> b. Preferably the grafts file is copied as well (after cloning).  I
>    never really understood why the file is not being copied in the first
>    place (anyone care to explain that?).

A bit of explanation: initially I think grafts were created as a means
to "graft" historical repository (conversion from BitKeeper and from
patches) to current work repository (from when git was deemed suitable
as SCM for Linux kernel development).  Nevertheless the machenism is
generic enough to change history _locally_ in many strange ways (for
example shallow clone uses kind of grafts).

Because graft file can be used to alter history, this totally
_bypases_ the check given by sha1 of commit and cryptographically
signed tags.  It negates security given by sha-1 signing.  That's why
using grafs must be _conscious_ decision - therefore they are purely
local and not propagated.

(Also there were no place for grafts in the "smart" trasport, i.e. git
and ssh protocols.  Thinking about what happens if both sides have
grafs files which differ...)

On the other hand history _without_ grafts might not validate.  I
think that it is why current confusing behavior...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
