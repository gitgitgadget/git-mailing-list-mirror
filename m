From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Gitweb: include minified version of js and css files in the repo
Date: Sat, 13 Mar 2010 00:26:51 -0800 (PST)
Message-ID: <m3d3z8lj9x.fsf@localhost.localdomain>
References: <1B527F20-CF6C-451B-9C6E-1BE74992354D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Rada <markrada26@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 09:27:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqMga-0003wn-AS
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 09:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758917Ab0CMI0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 03:26:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:11733 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896Ab0CMI0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 03:26:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so854982fgg.1
        for <git@vger.kernel.org>; Sat, 13 Mar 2010 00:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=3BLaTHJk/sIle8ZXhXjNVQJ11DUbtAs0r6culRg6k0k=;
        b=TSBybO6nQ0k29yO6ZrKYsEIRJI8MScfiupL4USN+aNbmux6QoT7qHwPOBG++JsT74d
         A1DR8WjKqtINOcMGNR/MlWTIa6pUiwixwOyDVsenmDdBhs6jwoH4JjtjJ58o92kmT4n7
         3o3DShA2+YIG7Lc1GRCLgrIq1xeLp4el9XWHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=P40AMRzkHhVoM64VmalNfH1tj6qoEEhQZ2Q1waL/YEDF04NTKXq69cg5Fg+BIQfbsa
         eH/SZN9nDES8RvLsFBNbMQMW4HE1xgsbIKX3tLBJTgqRiDmIWEmcsNCsa0+dm5P6fomd
         yLf29D19/Qs4pmEQHsQXg7YyQG5oW5SBJQgW0=
Received: by 10.102.209.14 with SMTP id h14mr3632229mug.25.1268468812804;
        Sat, 13 Mar 2010 00:26:52 -0800 (PST)
Received: from localhost.localdomain (abwm212.neoplus.adsl.tpnet.pl [83.8.236.212])
        by mx.google.com with ESMTPS id y37sm8783568mug.22.2010.03.13.00.26.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Mar 2010 00:26:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2D8QTkB004295;
	Sat, 13 Mar 2010 09:26:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2D8QIX2004291;
	Sat, 13 Mar 2010 09:26:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1B527F20-CF6C-451B-9C6E-1BE74992354D@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142091>

Mark Rada <markrada26@gmail.com> writes:

> I was catching up on the changes to gitweb changes in the
> last little while and I noticed an option to pass gitweb.js
> through a minifier during the make execution, which I thought
> was pretty cool. 
> 
> However, I was wondering if there were any reasons why the
> minified version of the javascript code was not distributed
> in the git repository? It seems like you are leaving that
> effort to be duplicated a lot by people who compile git
> themselves.

The reason is that one should not include *generated* files in
version control.  We do not include ./configure script (from
configure.ac), we do not include gitweb.min.js (from gitweb.js).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
