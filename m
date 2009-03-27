From: "Etienne Vallette d'Osia" <dohzya@gmail.com>
Subject: Re: Improve tags
Date: Fri, 27 Mar 2009 11:30:43 +0100
Message-ID: <49CCAAD3.4070104@gmail.com>
References: <49CB798B.4090107@gmail.com> <49CBA713.4040605@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Etienne Vallette d'Osia <dohzya@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 27 11:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln9NC-0004CK-5E
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 11:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbZC0Kat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 06:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbZC0Kat
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 06:30:49 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51135 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852AbZC0Kas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 06:30:48 -0400
Received: by fxm2 with SMTP id 2so951666fxm.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 03:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Sj3Um2E2a2Z3qALnMLWh4970CM2YgEMc2SJqFHGMFmA=;
        b=eYTb1jALmwmoeqX6H7ReHCwSh8AlVlJ1GzVZ3nRArXCpBTMRQ64WeqbYbdnRcpKinc
         LKWJnkVnOHQMRzOUkT5h9Efdwjy92TV7a4z1y4wnTrS3I4gCRaXbO+W5anC1J+fBne7H
         O5USFCVE2bHawKi0Q98xvl4tpPZADB/MBSaDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=Yghimv+pIxrB1x9hfeYXimI4HCXlObECdWdpVWQN0hHRGlw7DXZTs7nTN21t1aomhu
         8hOO+wa4HSw59ixI9gBJcgfwHo+m0DE89emgXDqA767mVzF5G4cUVQx3VgzV7HI75Gut
         nR9bEpEv8VnpRkjr5ZX0SnRzkKiWO735p2Q24=
Received: by 10.102.228.10 with SMTP id a10mr355833muh.26.1238149845464;
        Fri, 27 Mar 2009 03:30:45 -0700 (PDT)
Received: from schubby.inria.fr (schubby.inria.fr [138.96.218.89])
        by mx.google.com with ESMTPS id i5sm2815795mue.43.2009.03.27.03.30.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 03:30:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <49CBA713.4040605@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114878>

 > You described your motivation and use case very clearly!
 >
 > Maybe "label" would be an appropriate name for "non-unique tags". I
 > assume they should be local and non-versioned. It sounds as if a file
 > storing a list of sha1s could be the simplest approach (one file per
 > label in a new subdir of .git), although this may not scale well. A
 > first step could be implementing a command "git label" in shell which
 > sets and displays labels. Later on, various builtins would need to be
 > taught about it if you want labels displayed in log etc.
 >
 > Michael

Thanks a lot

"label" is perfect !

In fact, I was thinking about non-local labels.
But keeping information in a separate file and not in commit directly is 
a very nice idea (and closer than the current tag implementation).
I love your approach, you have just make this idea realizable
