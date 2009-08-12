From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Scumd
Date: Wed, 12 Aug 2009 13:26:41 -0700 (PDT)
Message-ID: <m3ws58ok1r.fsf@localhost.localdomain>
References: <4A8309D9.8070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKPP-0005iC-6J
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbZHLU0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbZHLU0n
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:26:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:32045 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbZHLU0m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:26:42 -0400
Received: by fg-out-1718.google.com with SMTP id e12so867625fga.17
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=/Uv83A3dkbaY0Ovz+BGmBAJW4lAd+6W9xlojw0kel5E=;
        b=GPvy4YHkZ88Sv3Bm/Ba4Bb3UuZZ3K6fJlVF+F5l5Km0VHN6toRxjHheplM9GdQj8Vv
         RVYhl1RWLBwlwE4h2UXA/9zIfwJxI/vj/uRfarCFxYoNUq69A9Xi1CdOf5EEuKaPZzWF
         roFt87/I8NiZqruXAUM3vi7bcLsUxae3oB25c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=aXSNHDslnlDVhkYUel1GWyYZG1xLCdoTmv459AwD4v22GDOIoz71EMkq1xgNiOhqg+
         DcovXVp+i4w7UJPS4DnZL/rQd3k358knn9phkTkkNsZgA7w+SGDkqFLs3PEmbWySfm2q
         KKfD4im4eApJhrAiYzExC9h8im19gfjts63rc=
Received: by 10.87.11.8 with SMTP id o8mr276918fgi.23.1250108802576;
        Wed, 12 Aug 2009 13:26:42 -0700 (PDT)
Received: from localhost.localdomain (abvv142.neoplus.adsl.tpnet.pl [83.8.219.142])
        by mx.google.com with ESMTPS id 12sm3639868fgg.11.2009.08.12.13.26.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 13:26:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7CKQfLx019458;
	Wed, 12 Aug 2009 22:26:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7CKQeJY019455;
	Wed, 12 Aug 2009 22:26:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A8309D9.8070008@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125738>

Michael Gaffney <mr.gaffo@gmail.com> writes:

>     This is an initial announcement of SCuMD, a pure java git sshd
> daemon. The source is at git://github.com/gaffo/scumd. The impetus
> behind SCuMD is to provide a highly configurable git daemon which can
> authenticate and authorize off of flat files, databases, LDAP, web
> services, or any other resource you can think of. SCuMD's other goal
> is to remove the need to serve off of normal sshd which some find to
> be a security risk on the open Internet. Currently SCuMD supports LDAP
> as the authentication module but coding other modules is quite simple.
>
>     I would welcome any feedback including a better name. SCuMD stands
> for SCM Daemon.

Could you add information about this tool to Git Wiki:
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
perhaps below entry for gitosis?

TIA
-- 
Jakub Narebski

Git User's Survey 2009
http://tinyurl.com/GitSurvey2009
