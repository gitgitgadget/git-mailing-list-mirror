From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Improve tags
Date: Fri, 27 Mar 2009 07:15:42 -0700 (PDT)
Message-ID: <m3bprn2gs7.fsf@localhost.localdomain>
References: <49CB798B.4090107@gmail.com>
	<49CBA713.4040605@drmicha.warpmail.net> <49CCAAD3.4070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Etienne Vallette d'Osia" <dohzya@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 15:17:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCs2-0000HL-1W
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 15:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbZC0OPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 10:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbZC0OPq
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 10:15:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:58952 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZC0OPp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 10:15:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1272978rvb.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=AEHf3IffCGSAxiW0bmeC97CuBszw/dI2ZL0TqwYE+qE=;
        b=b648eclWj0Vu19irZUUP7UDT9OhPnbIz1qsoiJpuPvu9HraIDzTwsH8C246T1d4XHC
         c1WIoAmQz551+TZuQJ0nwanWVOR/dVBY5LG72JED9+YoSCU3Ttg/KG1Ohdp9pAERSIgj
         1LS+1cyvUUcZKkwtQtqIANemHbYKE/L46VuYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ApTgAcGla3S+eooHaFi7Sm0cPFliq1P4MgFY+DQC+wWEBCwgp71eSxdk3rlY7nDwZp
         Syd8dd/K/uYDWp+68Ed+qjxLyIFPxHqYMbXNaAOo3l9sqOHdJ5mAbD+xqPlBfRpwc9QP
         m3bnAxl3aAtQ4wqDOc/ZKF7My1fcbhFjCpT+s=
Received: by 10.140.247.13 with SMTP id u13mr1105540rvh.288.1238163343714;
        Fri, 27 Mar 2009 07:15:43 -0700 (PDT)
Received: from localhost.localdomain (abvq19.neoplus.adsl.tpnet.pl [83.8.214.19])
        by mx.google.com with ESMTPS id k2sm3375948rvb.54.2009.03.27.07.15.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 07:15:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2REFcgb008273;
	Fri, 27 Mar 2009 15:15:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2REFaMI008270;
	Fri, 27 Mar 2009 15:15:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <49CCAAD3.4070104@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114897>

"Etienne Vallette d'Osia" <dohzya@gmail.com> writes:

>  > You described your motivation and use case very clearly!
>  >
>  > Maybe "label" would be an appropriate name for "non-unique tags". I
>  > assume they should be local and non-versioned. It sounds as if a file
>  > storing a list of sha1s could be the simplest approach (one file per
>  > label in a new subdir of .git), although this may not scale well. A
>  > first step could be implementing a command "git label" in shell which
>  > sets and displays labels. Later on, various builtins would need to be
>  > taught about it if you want labels displayed in log etc.
> 
> Thanks a lot
> 
> "label" is perfect !
> 
> In fact, I was thinking about non-local labels.
> But keeping information in a separate file and not in commit directly
> is a very nice idea (and closer than the current tag implementation).
> I love your approach, you have just make this idea realizable

This is a bit argument for (abandoned / dropped) 'notes' commit header
idea... But only a tiny bit.

More seriously: take a look at 'notes' idea; I'm not sure what state
they are currently, but they are in active (more or less) development.
They are extension of tags, allowing post-fact annotation of commits.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
