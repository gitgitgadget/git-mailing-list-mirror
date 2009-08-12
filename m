From: david.hagood@gmail.com
Subject: Re: Tie a CVS-aware app into GIT?
Date: Wed, 12 Aug 2009 16:52:43 -0500 (CDT)
Message-ID: <69e27eff741a76e3ab1edaa02857f94b.squirrel@localhost>
References: <b988339dcd1bf764f0da46db763552d8.squirrel@localhost>
    <200908122230.29363.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david.hagood@gmail.com, git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:48:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1dH-0002aJ-VD
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbZHQMr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbZHQMr5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:47:57 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:62110 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbZHQMr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:47:56 -0400
Received: by gxk1 with SMTP id 1so3953191gxk.17
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:message-id
         :in-reply-to:references:date:subject:from:to:cc:user-agent
         :mime-version:content-type:content-transfer-encoding:x-priority
         :importance;
        bh=4RHlW+O0wKKQbKC2nHnXd1l+2XpxzJacA8QQmxpes2c=;
        b=CsBzvOlGo1z2ZDCvjdTJ44gWGqxn7LZNVg9WFQzZusiwShs4wRj9yiMk/amEKmoOVP
         ZR4Hq1d3Z/RIYSvLp9+eoJxLURfWT6L8srlpzRPlNuZNyoWsscqKw/n13nbKKBzJueQt
         lYEmsshPIPd2m/ZAQZGY/LCZlMki4MREShap0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:in-reply-to:references:date:subject:from:to:cc
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-priority:importance;
        b=Sg/pyl4Kbqkhb+ZB/8GoS11k50l13VMzX6ifK69gK4bzrHzRU3yrtNaeLEnZwkSXeA
         zN9bVl6+ub2aJi20iY5rPr/iyoiOcRbrgysIcB70mW/DcXs4AY6YmWIfbEjHNZhzZdfq
         vxTgzNuOw1vVvzgqglSOG/YTLO1GknnmHaj1M=
Received: by 10.91.102.6 with SMTP id e6mr2759612agm.99.1250513277572;
        Mon, 17 Aug 2009 05:47:57 -0700 (PDT)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.121.34.clradsl.sktc.net [64.71.121.34])
        by mx.google.com with ESMTPS id 39sm7903656agd.46.2009.08.17.05.47.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 05:47:56 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 1AB92C7B81E6;
	Wed, 12 Aug 2009 16:52:43 -0500 (CDT)
Received: from deathwish ([127.0.0.1])
        (SquirrelMail authenticated user wowbaggr)
        by localhost with HTTP;
        Wed, 12 Aug 2009 16:52:43 -0500 (CDT)
In-Reply-To: <200908122230.29363.robin.rosenberg.lists@dewire.com>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126173>


> What makes you there would be an issue here?
>
> -- robin
>
>

Mostly just paranoia, a lack of experience with it, and a general
brain-overload because of the bazillion other things I'm trying to work
through. I was hoping I might get good pointers from somebody who's
already done something like this.
