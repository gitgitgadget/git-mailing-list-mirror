From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 09 Dec 2008 01:46:05 -0800 (PST)
Message-ID: <m3vdtthebu.fsf@localhost.localdomain>
References: <1228815240.18611.48.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 10:47:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9zBi-0001uk-Dj
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 10:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYLIJqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 04:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYLIJqK
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 04:46:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:37185 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYLIJqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 04:46:08 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1023030ugf.37
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 01:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=dvqOiTsScVS1bAiRWbZMsQYDvbkIvZDmGqEiWxe+A0A=;
        b=LYrs4u70uep+buSMPjQrBtgJ6omuHzhELbGBJLJ2pnqVpByUNJohIv4fpwJ4V50Kt8
         wpQPQqKGlM0xIo72uLMsB5spdWEVwlLlJsVq1v9F94xqzokvrinYvysix8wtsZ9TiLbd
         oO9C5FDZt+fwvsFhqcyiEtyW/L8beA0N9sxHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=H2LpIMabT2utrbUUbPww3EjP+iHwpVj1B9c5kdNfGZ21sMMMaJ5BdNFiYfMyC671KH
         WSUa9sJJKZ8Ltj8qaqca738mX5qji14WnDJClxMYh74OVjYVZrKX+5DqQVGwXcvaq0gR
         7do+55wGOhtDTy2fsWAxXLxAVekBxOrUf61nk=
Received: by 10.67.96.9 with SMTP id y9mr3093640ugl.64.1228815966805;
        Tue, 09 Dec 2008 01:46:06 -0800 (PST)
Received: from localhost.localdomain (abwb7.neoplus.adsl.tpnet.pl [83.8.225.7])
        by mx.google.com with ESMTPS id k2sm6652305ugf.21.2008.12.09.01.46.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Dec 2008 01:46:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB99ja0p002001;
	Tue, 9 Dec 2008 10:45:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB99jP9v001996;
	Tue, 9 Dec 2008 10:45:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1228815240.18611.48.camel@starfruit.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102615>

"R. Tyler Ballance" <tyler@slide.com> writes:

> Is there a header macro I can define or a config option I could define
> to make --no-ff on `git pull` implicit instead of explicit? Making sure
> we are always generating merge commits as a "just-in-case" safe guard
> about merge-happy developers who think after hitting enter? :)

branch.<name>.mergeoptions ?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
