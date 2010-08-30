From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Example git hooks (Re: Odd results writing a Git pre-receive hook
 to syntax check PHP files.)
Date: Mon, 30 Aug 2010 09:34:11 -0500
Message-ID: <20100830143411.GH2315@burratino>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
 <4C7B8E1E.6050708@drmicha.warpmail.net>
 <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
 <20100830141602.GF2315@burratino>
 <AANLkTi=GUrnH87faWH8G0tD7_KAynVf_ig0KpQRwnsaE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:36:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5T1-0006Rf-7d
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab0H3Of5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:35:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43725 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab0H3Of5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:35:57 -0400
Received: by mail-fx0-f46.google.com with SMTP id 13so3251524fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wEcQHh7BaFbSJiClMCP9JOuFRV/3Bxqtw4h2J3tMtfo=;
        b=Px1QbsH7OJNgEC+kjT1/PvIO5mjS14Zice++dJDmfn2MEhkPXWuDHQZj239gYEgonh
         2HjKQw3if+TO23TNhRp6pMOySwBxCtGARyO+riK0esn1bUkIo9SBBOJxBnKHpCwKfDwy
         l9mshUMeDY/PsY7vlgtve28/eK6UCSIilFuUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j7VFpUGbKSLG1co3WOC7VZm+WpH6Nd9x3W4BbYjP/ypViYgpy8mSuYVaOeKX5Yg4O3
         Wx4G5jTbVfdbA5eS4oCXEHPznOtQxhgfYAn2fxLwAHIApbApfI6H4ghNG01ugFimhHwp
         H+DnYxxGA/otf4vd9emwTutEPG2zBTLjwK6pA=
Received: by 10.223.120.70 with SMTP id c6mr2961553far.40.1283178956324;
        Mon, 30 Aug 2010 07:35:56 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 2sm3344328faz.14.2010.08.30.07.35.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 07:35:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=GUrnH87faWH8G0tD7_KAynVf_ig0KpQRwnsaE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154816>

Chris Patti wrote:

> (P.S. Is there a canonical 'example Git hooks' location I could
> publish this to when it's working? I think there's a dearth of this
> kind of example for people out there right now)

Try the git wiki (git.wiki.kernel.org).  There is a page for aliases
but no page for example hooks yet (though there are some examples
under InterfacesFrontendsAndTools).  You could be the trailblazer.

There are also a few examples in git templates/ and contrib/hooks,
of course.
