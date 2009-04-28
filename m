From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: Windows Server?
Date: Tue, 28 Apr 2009 23:46:00 +0100
Message-ID: <18071eea0904281546u52423fe3saf7abaa486bfa0ec@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3F0A6@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 00:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyw44-0005VO-1v
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 00:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZD1WqE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 18:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZD1WqD
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 18:46:03 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:34297 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbZD1WqB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 18:46:01 -0400
Received: by ewy24 with SMTP id 24so913063ewy.37
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O99E7TauJiSr7UanHQA0xzC1PAknnYHcCqPM5NO6MZc=;
        b=IJ/pSuKeqn1+6ZTVSS60L3bP6kvnMpv+xLMFclAq4pw+9nJ73ZhgOaoXk4RAs8b+xt
         KxqhRRgnQ0Wz4ZiCI6N09fl0kJ6v1Xn+lMTF6zu1odcbIcdAaubHaApHUcW3NkjikrgB
         FgEavdimkx1DgWiEZElS47A5l3yyqrtWWBXXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E1GctI7d7G6fsTWdjTVR9Cm1OcmmkRFSzIKOcsG1LY41pMzBaomlD8iibHd+JWbG9D
         gs/YkbHrb/c9LS8EuiyQ+EX38nR23mHQEkQiCsvSSblWLJtOnmtBUfe5jWNxegkY2aBj
         +RcCz3CkhuWAq8cqZ4TEumEK/Q0oYNItxNbOQ=
Received: by 10.210.130.14 with SMTP id c14mr6300222ebd.26.1240958760411; Tue, 
	28 Apr 2009 15:46:00 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AE3F0A6@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117826>

2009/4/28 John Dlugosz <JDlugosz@tradestation.com>:
> We are a Windows' shop, writing software that runs on Windows.
> Naturally, the network location I.T. provided for the repository is o=
n a
> Windows server. =A0I'm concerned with using file:// access once every=
one
> starts using it in earnest, especially over a cross-continent VPN.
>
> I suppose that git-daemon isn't available as a Windows service. =A0I
> posted a short time ago asking about it, and the news did not seem go=
od.

Well, git-daemon speaks the git:// protocol which generally is for
pull only.  If you're wanting push and pull access, using something
like ssh is the way to go.

> So, is ssh a good second? =A0That is, the manipulations of the centra=
l
> repo is being done by the machine that owns that disk, and the protoc=
ol
> talks between the two copies of git?

Yes, using ssh is fine.

> Is there anything that needs to be done on the server machine, other
> than having a SSH server, and formulating the path the way the disk
> really is on that machine (as opposed to the network share structure)=
?

Nope -- a running ssh server is all that's needed.  The clients then
would need an ssh-client to contact the server over ssh, of course.
Not knowing anything about WIndows, would putty provide this?

-- Thomas Adam
