From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 02:40:25 -0800 (PST)
Message-ID: <m3odctr245.fsf@roke.D-201>
References: <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
	<fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com>
	<fjrj9k$n6k$1@ger.gmane.org> <47616044.7070504@viscovery.net>
	<fjskqt$eap$1@ger.gmane.org> <fjt6vm$n7d$1@ger.gmane.org>
	<fcaeb9bf0712132224u54ca845ap4836dfe1cda37b29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org,
	gcc@gcc.gnu.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 11:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J37yP-0002Xk-FA
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbXLNKk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 05:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbXLNKk3
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:40:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:25044 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbXLNKk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:40:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1105900ugc.16
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 02:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=F1dmCt5UsmUs0iwOZQ+uBbcvsPRSR5rTsCEIfFZaCyY=;
        b=Zg40h66cxUoqkwpzbWzRtrlFjsb8fIWtdl+oLQVwY9nYH8CExj7GFj26sFjKNl6z5YC+mpY88FKSpz5Kdu5+umINvMmf3JfH+G6pThUduhK6gMhIbaAOjpHrDtWow9yY/CK6ubLWqPgHzIj6LtACACe5ft2HFwMevv6+LVKWvoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=ixcME61FZlu+bEjbNNq6PIjJ9gy7FWh3Fbob7up/Bk9Tz08vbxddvjU0C6TnkqN8PeAPMJfuxoR5r4m1mjJgjxuWYzatfhs02hI+WiSwGxZvIx2NM9Q2o8hSCCVjMu+9JN7dLHXTdZ+GzQs2cDdieX/+p72CmP9eKpo0zCoDgd4=
Received: by 10.67.20.3 with SMTP id x3mr99663ugi.3.1197628826325;
        Fri, 14 Dec 2007 02:40:26 -0800 (PST)
Received: from roke.D-201 ( [83.8.245.165])
        by mx.google.com with ESMTPS id g28sm12019154fkg.2007.12.14.02.40.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Dec 2007 02:40:25 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBEAeJqI003671;
	Fri, 14 Dec 2007 11:40:20 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBEAeENE003668;
	Fri, 14 Dec 2007 11:40:14 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <fcaeb9bf0712132224u54ca845ap4836dfe1cda37b29@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68274>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Dec 14, 2007 1:14 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
> > > Hmmm... it is even documented in git-gc(1)... and git-index-pack(1) of
> > > all things.
> >
> > I found that the .keep file is not transmitted over the network (at
> > least I tried with git+ssh:// and http:// protocols), however.
> 
> I'm thinking about "git clone --keep" to mark initial packs precious.
> But 'git clone' is under rewrite to C. Let's wait until C rewrite is
> done.

But if you clone via network, pack might be network optimized if you
use "smart" transport, not disk optimized, at least with current git
which regenerates pack also on clone AFAIK.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
