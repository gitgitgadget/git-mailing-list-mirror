From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git --prune --aggresive
Date: Fri, 23 Nov 2007 11:08:16 +0100
Message-ID: <200711231108.16676.jnareb@gmail.com>
References: <200711231058.46578.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 11:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvVSk-0000Ph-Ts
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 11:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbXKWKIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 05:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbXKWKIY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 05:08:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:57847 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbXKWKIX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 05:08:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so476506ugc
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 02:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=3pjxkSKhNAC/2x7KkKKvJuJP3SEz7PPL9cP1VofWlnc=;
        b=dAMlUHcFMDAjx7tLr6x52K3lrYkLn4ILNlUIuCfhagwFmtBqrbvKP4IWtXqUFO6PzrGyyhezmJndAQmL+jn5YD6STNgkd3LUA7nMvwsm9W5ji8DgKR3skyvTt+t9cPNaZWUMJWTYgYCx8WegwmzAqUKBubqBkaTV7N8Yla2/oQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mzdF4/e/M2jt3eUYh5QnMthVmHYOw22TxHUHN3r9U+pfEaaoyZtRUtl0zBhgcZuWDGW1Y6AHR/T9xL8MvaCnus8zElrG2HFEr/F7FAwe47qbolUPhaHJY8dmJ0L4tvSiSoW1T/WskcWeeaXMCSFIkeEF4ThWR7hjoOW41hO6id4=
Received: by 10.86.68.20 with SMTP id q20mr411448fga.1195812500241;
        Fri, 23 Nov 2007 02:08:20 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.172])
        by mx.google.com with ESMTPS id l12sm386375fgb.2007.11.23.02.08.18
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Nov 2007 02:08:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200711231058.46578.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65888>

Jakub Narebski wrote:

> 2396:[gitweb/web@git]# git gc --aggresive --prune
> usage: git-gc [--prune] [--aggressive]
> 2397:[gitweb/web@git]# git gc --prune --aggresive
> usage: git-gc [--prune] [--aggressive]
> 2398:[gitweb/web@git]# git --version
> git version 1.5.3.5
> 
> Either usage string should be fixed, as it suggests that you can specify 
> both --aggresive and --prune, or git-gc should.

I'm very sorry, my mistake: --aggresive instead of --aggressive.
Please disregard this message...

-- 
Jakub Narebski
Poland
