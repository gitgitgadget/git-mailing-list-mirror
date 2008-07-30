From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 12:25:39 +1200
Message-ID: <46a038f90807291725r134b2a43gb3da00151e22d443@mail.gmail.com>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
	 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
	 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
	 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
	 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
	 <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
	 <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Roman Zippel" <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 02:26:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNzWb-0001zp-EQ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 02:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbYG3AZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 20:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbYG3AZk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 20:25:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:26837 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbYG3AZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 20:25:39 -0400
Received: by wf-out-1314.google.com with SMTP id 27so177898wfd.4
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 17:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+C9fN/tBFTS403ctuf95uB5d14MdSzr5uZA3v53R9ds=;
        b=JufpgwHyA/ULyjUn4FzsLvxCtcwZGCtkXZFDZaBQ+c2C3YQ65v8vqP16WICz7wkoVt
         OoxtDvxY4eBOACB+s4aU0/+d2NKyaWI1jYtQqJdmp3xA1Q6U1Ixfsw9OlJM+SNLyglhV
         PNzxDsFLE8V+VjNaXy0h6HfngqRej2NRnqcbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Aj6KCNT7z0pdxRhMNSjExrp87+QxjyPfRLNvE0jlqrec9PR7KQCEGec8cORBcllD1W
         QQP6BuBZEBn97nuX1Jzpl1o6MDvlJqA5A3bVOn02Dpk9jnYvEA9WOgcqtJpuQKj6rZTx
         u5IRqO2uQRzz0suqey1zr/PwmMKtXUsPq3nlo=
Received: by 10.142.158.17 with SMTP id g17mr2412973wfe.17.1217377539411;
        Tue, 29 Jul 2008 17:25:39 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Tue, 29 Jul 2008 17:25:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90714>

On Wed, Jul 30, 2008 at 12:16 PM, Roman Zippel <zippel@linux-m68k.org> wrote:
> I already did the prototype

afaict people around here are only interested if it can be done
without losing the early-output niceness of current git-log. That it
can be worked out in a "put it all in memory and work it in there"
model is _not_ interesting for git.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
