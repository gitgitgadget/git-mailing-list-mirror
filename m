From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: blame vs annotate?
Date: Wed, 03 Sep 2008 11:11:25 -0700 (PDT)
Message-ID: <m3zlmpp0ac.fsf@localhost.localdomain>
References: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kawr4-0002Xf-Ma
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 20:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbYICSLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 14:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbYICSLa
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 14:11:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:5674 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbYICSL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 14:11:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so217299fgg.17
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=3o2PMtacclW5d3B6V5MPRtItxe3BuaxrRiKlH7RfBUA=;
        b=B07b2CVgi8a3Bwc3blIMdLGeGJO/E3AHcp6N1JUlMTapgCDAdan52yhhlgh/u1yanM
         agn9isTA7f3ZCEnPmwKNtyETHutob34AH/N+r4btHye9a+CBT8tZ/hUzJ0DdfL1W2yQF
         l2MuGkb9f6J/xzVEevOhCh3Kxj4QdX5BJXeic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=b1G9rZkEliBM12xhJg8sJljTbwku8zWg1d0YFmHTWIFFLJ6OL+l2sTYeA4D+Kx042i
         /KqbrlHZ0taPYkoCbOqptG3udutGDpkHm3rj2+xMVUQDdI5KQGLZ9eb5XQr7RXXRw9FA
         4J+D9i3i1ZaezFIlW23RL5bbb8ohXTY6KZVkk=
Received: by 10.86.98.10 with SMTP id v10mr6899790fgb.39.1220465486125;
        Wed, 03 Sep 2008 11:11:26 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.253.191])
        by mx.google.com with ESMTPS id 4sm10155443fgg.4.2008.09.03.11.11.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 11:11:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m83IBO0b010652;
	Wed, 3 Sep 2008 20:11:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m83IBN28010649;
	Wed, 3 Sep 2008 20:11:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94832>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> What's the difference between 'git blame' & 'git annotate'?  The
> output is practically identical - it's not obvious when you would use
> one over the other

Long, long time ago (which in git terms mean almost 2 years ago:
git-annotate.perl was removed on Oct 9, 2006) there were two competing
implementations: git-annotate, which IIRC was first (starting at Feb
20, 2006) and was written in Perl, and git-blame (stated at Feb 21,
2006) which was written in C.  In long term git-blame won, if I
remember correctly because it avoided some strange corner case, and
assigned blame better.  Then git-annotate was made alias to "git-blame
-c", perhaps in additon to different synopsis (order of arguments and
possible options), for backward compatibility.

HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
