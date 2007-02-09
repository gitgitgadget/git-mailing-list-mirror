From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 9 Feb 2007 15:29:16 -0500
Message-ID: <118833cc0702091229qfa0a3bcyae40b5e7ff70262b@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	 <7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 21:29:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFcN1-0006ar-CI
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 21:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992806AbXBIU3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 15:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992807AbXBIU3T
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 15:29:19 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:18031 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992806AbXBIU3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 15:29:17 -0500
Received: by wx-out-0506.google.com with SMTP id h31so952018wxd
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:29:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kmYuEx2lz7l+D5L1hwV1+cHOeRE2rwoBw2LDWu1UDqxpZrHLwM/WokACwI185ehMsX84asRB4t9YmIRE3o0DTEleB8+h2RTml6J1uoRauhS4BrLhgn+o5Ml4CMEasdw72GzbMqfUKmlqg/spawlTzTtYGi+KFNie61dmlxZbyX8=
Received: by 10.70.125.11 with SMTP id x11mr17994498wxc.1171052957022;
        Fri, 09 Feb 2007 12:29:17 -0800 (PST)
Received: by 10.70.95.13 with HTTP; Fri, 9 Feb 2007 12:29:16 -0800 (PST)
In-Reply-To: <7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39197>

> Running refresh internally in runstatus without writing the
> result out _might_ be an option, but that would largely be
> a hack to only help qgit.

I might be overlooking something, but couldn't that updated index be
saved elsewhere?  And subcommands be pointed at that, of course.

Morten
