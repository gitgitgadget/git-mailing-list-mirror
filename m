From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in incremental blame
Date: Wed, 25 Nov 2009 02:13:50 +0100
Message-ID: <200911250213.50684.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911250145.16472.jnareb@gmail.com> <20091125100104.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 02:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND6SM-0000Wx-86
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 02:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933953AbZKYBNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 20:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933928AbZKYBNw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 20:13:52 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:63957 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933913AbZKYBNw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 20:13:52 -0500
Received: by fxm5 with SMTP id 5so6501241fxm.28
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 17:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UmxDG6HQe7NdZ8GwH3SQ7s33qflKnkyV94Uxao2jCgQ=;
        b=gJpgDxQ8lEWexhsvNYHfY6gCZbWYiHFrmiv6kbGd+mrO95cdjjwqGJrTTxdYx30Tx4
         ZUHql4wx8FkppkigtWjxsqmdkEDaM2I1ZzEVa7PKREQXyHmp9i6O1dn//rD5WA83wrmP
         nbujlT07ZCzHTw7NstD8TUfgJGBUNLAauDgao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bslW4XjPMiLiBUx7W577F5APXy7YKvRj9Yaa9Ijq6mJA2NBmUtjg+k2xkDlSkAxcgg
         aN2P/aITLWwPBqLAiDhN6RgnCQBfXDO/t83P4YVBbNYbGUlk31hfD1Gc4ZqtPJP1waYt
         9DudV+XJU/4d3zePFb/5mQQO4LuWWpJgvXM6w=
Received: by 10.103.78.7 with SMTP id f7mr3020001mul.95.1259111637637;
        Tue, 24 Nov 2009 17:13:57 -0800 (PST)
Received: from ?192.168.1.13? (abwj137.neoplus.adsl.tpnet.pl [83.8.233.137])
        by mx.google.com with ESMTPS id b9sm1964124mug.39.2009.11.24.17.13.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 17:13:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20091125100104.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133605>

On Wed, 25 Nov 2009, Nanako Shiraishi wrote:
> Quoting Jakub Narebski <jnareb@gmail.com>
> 
> > On Sat, 21 Nov 2009, Jakub Narebski wrote:
> >
> > Below the same patch is in the form of a proper commit; although the title
> > (subject) of this commit could be better...
> 
> Does this replace the first of the previous two-patch series? Is
> Stephen's second patch still needed (with his fix)? 

No, it replaces neither first patch of Stephen's two patch series that
started this thread, namely "gitweb.js: fix null object exception in
initials calculation" (which is about initials of committer... if they
exist), nor the follow-up fix of off-by-one bug in padLeftStr.

This is fix of an independent issue (even if it occurs only in IE8).

-- 
Jakub Narebski
Poland
