From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 02:17:17 +0100
Message-ID: <201001250217.17743.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com> <20100124222417.GC9553@machine.or.cz> <201001250103.38703.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 25 02:17:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZDaD-0006QC-Ic
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 02:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab0AYBRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 20:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441Ab0AYBRY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 20:17:24 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:56071 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0AYBRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 20:17:24 -0500
Received: by fxm7 with SMTP id 7so1498509fxm.28
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TO14EdzgBpWn5E2fyzXqZGoAhh5UjEexePfPapzrQss=;
        b=LQycqhpNl/dT1pBJcH6xUJbZVvB1xLSg1HXSfgi3Tk9zEEv4sy11rlJuC6Rn7HjWrx
         NFkd5/O5D4ZshLcM0SJKOa0uWRE3ynbtC4NKFkvPHv8j7z37ssOsNaDWZLEoFBWYDxc3
         R118jOmaaz0e9rihDY5SHZmp/5xP9fqJEVpSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Vl8S/+WHfptZLeukj4ZJ3ITvQSlhSMguXHrQHOnCVNGqhxGn28wkMw89rnfQKWQi0k
         hRBz4UhfAaCT7CN7G/XXYwtSKPrgtSwT5Zhrwo0IflNMJpV11vWJPg2HdHrjtHVi16GS
         DqT8XNac5WGtw+OU0BI7rYScGYRv3jD2Tu9wo=
Received: by 10.223.145.149 with SMTP id d21mr5139737fav.77.1264382237295;
        Sun, 24 Jan 2010 17:17:17 -0800 (PST)
Received: from ?192.168.1.13? (abvk247.neoplus.adsl.tpnet.pl [83.8.208.247])
        by mx.google.com with ESMTPS id 14sm2461739fxm.11.2010.01.24.17.17.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 17:17:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201001250103.38703.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137933>

Jakub Narebski wrote:
> On Sun, 24 Jan 2010, Petr Baudis wrote:
> 
> >   I have stupid question, common to both the original patch and this
> > RFC.
> > 
> > > [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
> > > regenerating cache (WIP)
> > 
> >   Just why is a "Generating..." page appropriate?
> > 
> >   I have to admit I hate it; can you please at least make it
> > configurable? Why is it needed at all? It generates unnecessary
> > redirects, clears my previous page in the browser by a useless
> > placeholder, confuses non-interactive HTTP clients and I just can't
> > see the real purpose.

> Note that the JavaScript-using Ajax-y version from the following patch 
> '[RFC PATCH 11/10] gitweb: Ajax-y "Generating..." page when 
> regenerating cache (WIP)'
>   http://permalink.gmane.org/gmane.comp.version-control.git/137896
> is not visible in browser history, as it simply replaces "Generating..."
> page with the result.  So there is no 'unnecessary redirect', and there
> is no 'useless placeholder' in browser history.

Actually I have checked and the version used on git.kernel.org does show
"Generating..." page, but it does not appear in the history.  I guess
that refresh with no URL does not count as redirect.

-- 
Jakub Narebski
Poland
