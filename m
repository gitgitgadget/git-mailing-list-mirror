From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Mon, 18 Apr 2011 15:34:30 +0200
Message-ID: <201104181534.31408.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104141154.55078.jnareb@gmail.com> <20110417201421.GV3258@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 18 15:35:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBobT-0008Ua-Ni
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 15:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab1DRNeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 09:34:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56365 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab1DRNeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 09:34:44 -0400
Received: by fxm17 with SMTP id 17so2833561fxm.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=RE4pyv6aHaaGu7zIeHc07DdiX7YNf4OGMuTaxn/ikyY=;
        b=XIjyPiXuY4i0MzpBmYq3qLHZCAx5yA1WDfmawGUpsXOBksNuNSMWwVMgeLhTJyxgsT
         nQeIkCwug9OotL+M2I49OWS5MA9eVRjoEnE2tMJKFJZ9PddPS86rVLMyl8yL1GQ7eRVT
         e+xLtLSW2G7jpSPBb/ZNmdfMzW1Wh7IBx/zMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nVLMetgOV9+2A2YRmH0IXppgpQnDDV9I19s29hlRxd5wEvo9PotExY3H7pkslwSkjv
         +B4QECRdlEMq4QkB43JBEFmzCeIskpnwvoqbgyyQNQ0ykLaKQ2gA3IDbzK1xby4tBJyh
         fzV8JqRs7K2Q9YC+tltyrL67R9z47caXc6JRA=
Received: by 10.223.59.146 with SMTP id l18mr4885040fah.58.1303133682812;
        Mon, 18 Apr 2011 06:34:42 -0700 (PDT)
Received: from [192.168.1.13] (abvc126.neoplus.adsl.tpnet.pl [83.8.200.126])
        by mx.google.com with ESMTPS id l2sm1674190fam.29.2011.04.18.06.34.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2011 06:34:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110417201421.GV3258@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171743>

On Sun, 17 Apr 2011, Petr Baudis wrote:
> On Thu, Apr 14, 2011 at 11:54:53AM +0200, Jakub Narebski wrote:

> > Unfortunately the decision to use JavaScript framework brings its own
> > new problems.
> > 
> > First issue is which JavaScript framework or library to use:
> > * jQuery (lightweight, most popular, used e.g. by MediaWiki)
> > * MooTools (lightweight, 2nd most popular, opbject-oriented)
> > * YUI, The Yahoo! User Interface Library 
> > * other: Prototype, Dojo, ExtJS, SproutCore,...
> 
>   Girocco uses MooTools, and I also used it in an old private branch
> of gitweb. I have had pretty good experience with it. But since I wasn't
> able to find anyone to maintain Girocco's gitweb (or even keep it in
> sync with upstream) and the patch flow to core git has dried up, it's
> probably not too relevant argument. :-)

Thanks.  The information about MooTools is certain helpful.

Do you remember why did you choose MooTools from other existing JavaScript
frameworks, including more popular jQuery?

> > So what are your ideas and comments on the issue of JavaScript code
> > and JavaScript libraries / frameworks in gitweb?
> 
>   It seems most common sense to use CDN by default but allow providing
> pre-downloaded file with the library at build time as an alternative.

This seems to be a consensus.  Now what's left is to worry about plugins,
extensions etc. which would be helpful for gitweb JavaScript use, but
are not in core provided by CDN.

-- 
Jakub Narebski
Poland
