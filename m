From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git commit hash clash prevention
Date: Thu, 02 Oct 2008 07:00:18 -0700 (PDT)
Message-ID: <m3prmjqeq8.fsf@localhost.localdomain>
References: <20081002085358.GA5342@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:03:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOkR-0007xI-14
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbYJBOAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbYJBOAX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:00:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:32246 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbYJBOAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:00:22 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1022243ugf.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=iEtL02sIX+PX9cJqtQfI985j64xzFx2utitY1xKjmRo=;
        b=KOUpxws1/M2x4aR81oJyCNb7OFQhSkSuGDRJq65xKqNzg1UU+EU6QJrd8FwnkhIiW3
         NgSDWNdfnyjxG0wQ/OqRel5t68nQemwzGx70UKVZSCqNWtlky3z8kWsKaJHUjMQS9590
         9wUGYnECExlW5aIQLnHiEZQQlXB81GMRzy2xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=GLKNLYGB0nED2o9GdJ9gsHmKRZyYQ9xHh0mPcFqU34ZkJTEVcA0XV3RVcJm26dhg7C
         cHZcepZiF3FivQYlb3YMRaucOQuga8PaFO10VDfMZDkCf57GfdEhyizbkm8KczsRCDG3
         5y9vwgvZBtqYqCtWA8VifbrIdBeiU5t7G7unA=
Received: by 10.66.233.10 with SMTP id f10mr3998031ugh.8.1222956019414;
        Thu, 02 Oct 2008 07:00:19 -0700 (PDT)
Received: from localhost.localdomain (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id i39sm12014587ugd.21.2008.10.02.07.00.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 07:00:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m92E0GBJ018328;
	Thu, 2 Oct 2008 16:00:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m92E0FM2018325;
	Thu, 2 Oct 2008 16:00:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081002085358.GA5342@lapse.rw.madduck.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97331>

martin f krafft <madduck@madduck.net> writes:

> the other day during a workshop on Git, one of the attendants asked
> about the scenario when two developers, Jane and David, both working
> on the same project, both create a commit and the two just so happen
> to have the same SHA-1. I realise that the likelihood of this
> happening is about as high as the chance of <insert witty joke
> here>, but it *is* possible, isn't it? Even though this is thus
> somewhat academic, I am still very curious about it.
> 
> What happens when David now pulls from Jane? How does Git deal with
> this?

Cannot happen in practice.

But just in case git trusts object it already has in repository over
object which just got fetched (or pushed).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
