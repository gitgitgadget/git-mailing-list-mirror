From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 2 Nov 2007 08:28:30 +0100
Message-ID: <200711020828.30969.jnareb@gmail.com>
References: <20071022063222.GS14735@spearce.org> <20071102022335.GU18279@machine.or.cz> <200711020825.23464.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 02 08:26:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inqv5-0005Bv-VR
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 08:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbXKBH0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 03:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbXKBH0F
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 03:26:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:24203 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbXKBH0E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 03:26:04 -0400
Received: by ug-out-1314.google.com with SMTP id z38so584981ugc
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Bw9AC+BZMCR5voEoY3HU26/5/h1rHAzap6Ee4sK/T2U=;
        b=Jvyy+moasBlFi7TMRZnsiTcGLx7HxABQ1y3F3NkgW0aKo9o7ty07wetjxYD8Zq93air3D+WHTIK1PSjUXq7ppSjsjmmFHOlnL84TnQQci8VDcq86eNczWJf8xHu3RgMPjiUPOqyxngXPK68RemdLsrx/L33bv8u1fRdXfMhyUbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I5ixtv2Ci7cBLxSAY3cBh9gePwlI7RSfqa3yyBLzj1BN8O3k4zJpmg8uYugwjZkEKGZQsXD8FGLrVVLQFn/xIhlkaYP8gys7EXimfzAa31fm7nLGy9OTiFJ4BoqjjuLECiXOo7VNHtp/C0pX6Q/dgyxFolxhjsdOh3OC4fowUPo=
Received: by 10.67.115.9 with SMTP id s9mr843160ugm.1193988362203;
        Fri, 02 Nov 2007 00:26:02 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.154])
        by mx.google.com with ESMTPS id q40sm7494323ugc.2007.11.02.00.26.00
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2007 00:26:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200711020825.23464.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63068>

Jakub Narebski wrote:
> Petr Baudis wrote:
> > On Fri, Nov 02, 2007 at 01:04:03AM +0100, Jakub Narebski wrote:
> 
> >> Is 'getopts' bash-ism, or is it in POSIX?
> > 
> > 	http://www.opengroup.org/onlinepubs/009695399/utilities/getopts.html
> > 
> > (Also, most modern distributions have manpage section 1p (3p, ...) with
> > the same contents, so you can check for this stuff pretty easily.)
> 
> Thanks.
> 
> I have just realized however that it doesn't help any (option parser
> not only for C builtin, but also for shell scripts, Perl scripts and
> Python scripts). First, we (the git development community) do not
> consider fact that something is in POSIX as indicator that we can use
> the construct. Second, getopts delas IIRC only with _short_ options.

Just a thought:
  http://www.systhread.net/texts/200704optparse.php

-- 
Jakub Narebski
Poland
