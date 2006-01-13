From: Artem Khodush <greenkaa@gmail.com>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 14:11:33 +0300
Message-ID: <40b2b7d90601130311v78db741dx7c5eaa57ad300850@mail.gmail.com>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	 <7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	 <BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
	 <7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
	 <BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
	 <7vzmm0eod1.fsf@assigned-by-dhcp.cox.net>
	 <BAYC1-PASMTP01A07DAA61F181E9D9679EAE260@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Jan 13 12:12:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExMqJ-0006lD-5w
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 12:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWAMLLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 06:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWAMLLg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 06:11:36 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:61761 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030341AbWAMLLf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 06:11:35 -0500
Received: by uproxy.gmail.com with SMTP id s2so38167uge
        for <git@vger.kernel.org>; Fri, 13 Jan 2006 03:11:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FxW3XX8/Rmrp7oXwFQtyH/N1i4/lB3HDFBJ9XEmcJd5ePb8o6cdfrc6YRApueLKkD8vnuY5B0jOM3PPuajA+wYFxiiVmW21dBqqFbk8IbCk+y7Fggw4N7Y2Hk6FmqH9Vse4fpBhb81zWmFfvhY1NY7QpnRwyh9k1Gch9NcxKlI0=
Received: by 10.48.202.20 with SMTP id z20mr59029nff;
        Fri, 13 Jan 2006 03:11:33 -0800 (PST)
Received: by 10.48.216.3 with HTTP; Fri, 13 Jan 2006 03:11:33 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <BAYC1-PASMTP01A07DAA61F181E9D9679EAE260@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14624>

> $ export GIT_AUTHOR_NAME="$author"
> $ GIT_AUTHOR_EMAIL="$email" git commit -F .msgfile

> Which is cumbersome and also ends up destroying your defaults if you happen
> to use that method, so afterward you have to unset them or reset them back
> to your own author info.

Hello,

I had a similar problem on cygwin. I agree that setting environment
variables by hand
is cumbersome, and modifying global environment is undesirable. I ended up with
writing shell script, named git-env.sh, that sets all variables
requred for git to work,
and got used to habit of typing

. git-env.sh

every time I intend to do some work in git.
When that environment is not needed any more,
I just close that particular shell window.


hope this helps,
Artem.
