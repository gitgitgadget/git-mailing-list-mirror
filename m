From: alexandrul <alexandrul.ct@gmail.com>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 19:35:54 +0300
Message-ID: <4ADB43EA.5060901@gmail.com>
References: <20091018144158.GA9789@gandalf.dynalias.org>	 <4ADB3452.6030508@gmail.com>	 <9b18b3110910180837h18e15f74g74626847b6ce4da3@mail.gmail.com>	 <20091018154528.GA5688@gamma.logic.tuwien.ac.at> <9b18b3110910180916s2a2ac751i7520e64294037817@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Norbert Preining <preining@logic.at>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 18:36:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzYjx-0002Mt-Ds
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 18:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbZJRQgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 12:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbZJRQgD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 12:36:03 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:34724 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbZJRQgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 12:36:01 -0400
Received: by ewy4 with SMTP id 4so808057ewy.37
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=RrCYEKM6uvmGXA0YkIPfTWa5MhmTXovEYdP34pVldgU=;
        b=CS7D6Acf7MO62EI6MuvyWCm1EHh9+UabER+1JLdNn5nnV7hr4ik+oQRawETPcYc6zT
         zPLpDKKuVeke1FMXViFg3o4z8ilEFVqj02qWQPIW8BOGS5o5q+KvI5ouvJU1BXjsRoIp
         Ut7AZ2T3S0EPuI7w/HGmEH8ZznXVj1r6Nwj2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=u2WMjSyEh7gJNMF+uYJkn3pobegbyF7GiS9PrEworeVDmGmVYhhms3ANghLqAMSztz
         xZUDB3kjQtKVWhUCaFyNlQZwGacZaVM8Xo8jFP91GT183Ih4xpfhZCgW1nE1eHw7gvzk
         fm1V6IDP/801vlXuMhSZ4oePKYBmIJ9JcViF0=
Received: by 10.216.86.80 with SMTP id v58mr1315835wee.40.1255883764893;
        Sun, 18 Oct 2009 09:36:04 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id i35sm10425512gve.13.2009.10.18.09.36.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Oct 2009 09:36:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <9b18b3110910180916s2a2ac751i7520e64294037817@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130603>

demerphq wrote:
> Consider you have A-B-C-D-E in your master repo. So presumably numbered 1..5.
> 
> If i then make a trivial comment fix to A and then merge and push we
> end up with:
> 
> A-B-C-D-E-G
>  \        /
>   F------+
> 
> If i understand you right you will set F to 6 and G to 7. Thus youll
> end up with the problem that F is a descendent of A yet has a higher
> "version number" than E. You can repeat this process for ever.
> 
> If this suits your needs then great.

Just like subversion :D

It helps by ordering commits by time, not by parents, and I don't need
repo access to figure it out that F is the latest bug/feature/fix.

Think about 2 sql servers, each has different versions of the same
stored procedure. Which one is newer, given that you don't have
the git repository on the production servers? I can't make any decision
on SHA1 only, and if they belong to the same branch ("prod")
I'm so out of luck. At the moment I'm saving SHA1, refs, author date,
comitter date and last subject. But it's easier for me to compare
revision numbers than dates. And don't forget that updating decisions
may be taken by people that have nothing to do with development.

Have a nice day,
  A.
