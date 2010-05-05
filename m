From: Michael Norman <mwnorman@gmail.com>
Subject: Re: Does recent 'smart' HTTP feature help git-svn thru unfriendly 
	corp. firewalls too?
Date: Wed, 5 May 2010 10:20:52 -0400
Message-ID: <i2yd43c95441005050720rccceadcex88a2ce6730d96a5d@mail.gmail.com>
References: <t2td43c95441005050710rb5123219v9ca23aebc01e40ad@mail.gmail.com>
	 <20100505141636.GG11053@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 16:21:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9fTC-0003NK-CW
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab0EEOU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 10:20:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38398 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab0EEOUz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 10:20:55 -0400
Received: by wyb35 with SMTP id 35so360267wyb.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/FtK40PlVpBwQf9W5OMwVLugcjpaxf8WL1M4JssWA0k=;
        b=ntUUVr86sDHDyN7otuH/Sr62004Hzzi34PB64ON24hT1Iel31ygyZh9lxjfRXlNcvb
         M/wuFBsm0uqEMbl5tCtJmvtktTLTRGOd2gtCFFMWggryFnRNOe4aOAf5yYpUaX7sByRQ
         6F5x96r6e2zJumD1BFXY58R0mJb1/vKus+hUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fNr7F84lCT9wGB6UQ4aWAmSSWfjVUYZCUv1yIDnlP3sB6Ao+a/p9cXVBAjDdM0aI2E
         lK4H+mPc8KQHH8ILaIYVL/7TF/gUHqM95Cg2g/bmRrZ+LS18JKxEQls3CQMvmt3dB4Pa
         jlm8qcMpyrpHYc0wk0XDpjOjDS/wYddEeYkNI=
Received: by 10.216.86.14 with SMTP id v14mr1281716wee.157.1273069253024; Wed, 
	05 May 2010 07:20:53 -0700 (PDT)
Received: by 10.216.186.148 with HTTP; Wed, 5 May 2010 07:20:52 -0700 (PDT)
In-Reply-To: <20100505141636.GG11053@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146399>

Sigh - most SVN installations require ssh+svn for read/write access.

Our company is changing firewall vendors and I have been told that our
TortoisePlink+putty-session 'trick' may be blocked :-(

On Wed, May 5, 2010 at 10:16 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Michael Norman <mwnorman@gmail.com> wrote:
>> Subject line says it all - does it help?
>
> Not sure I can see how/why. =A0The smart HTTP code helps git go
> through a firewall, not SVN. =A0SVN already speaks HTTP, just
> somewhat inefficiently.
>
> --
> Shawn.
>
