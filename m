From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 23:29:02 +0400
Message-ID: <20080711192902.GD1721@dpotapov.dyndns.org>
References: <200807102057.15063.toralf.foerster@gmx.de> <200807111539.06606.toralf.foerster@gmx.de> <37fcd2780807110744k3b2a332csdf788dabd172622c@mail.gmail.com> <200807111658.40626.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 21:30:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHOJm-0003wp-2O
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 21:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbYGKT3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jul 2008 15:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbYGKT3K
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 15:29:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:53983 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbYGKT3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 15:29:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1588376fgg.17
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Urz8tw4setHxIqEYpIeC53n2PnlfrkUaSdaiBiFVqJk=;
        b=NyjyegS4d+q9LkdL8A186GJx87TEADMYKJ3NVXTnfqRVxZuR9kvf+hoExKlIRQrki+
         BU1PAccLq/C3xBy/ow/e6LwRmjOcpuUQ6QxwNtL/f2nqUk171fozXacQhVSc8upSRZk4
         RIYtqbcMLuiAUhfooUAwBkUJGvs5FX6yzxXxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YS1iUP660GjyZaTUl0F3XArJAZ+WJfspf6G9ZIPGuV7M8vf6zeXDTTrbTuWtmwRIpQ
         bp02Ua9NBf7f1zO//lHGFptN4vKExj50q6FYb7UDSonypmcTjpeEbONoHXtM8Yx4pde8
         qUPG8flNOixTUWp/M3ZL/85GjXDN7i5PoMCOQ=
Received: by 10.86.33.19 with SMTP id g19mr10367117fgg.67.1215804546072;
        Fri, 11 Jul 2008 12:29:06 -0700 (PDT)
Received: from localhost ( [85.141.148.129])
        by mx.google.com with ESMTPS id e20sm1819719fga.1.2008.07.11.12.29.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jul 2008 12:29:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807111658.40626.toralf.foerster@gmx.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88162>

On Fri, Jul 11, 2008 at 04:58:40PM +0200, Toralf F=F6rster wrote:
>=20
> $> git-log v2.6.26-rc9.. --pretty=3Dshort | grep "^commit" | cut -f2 =
-d' ' | xargs -n 1 git describe | grep '\-56\-'

The fastest way to do the same would be:

git rev-list v2.6.26-rc9.. | xargs git describe | grep '\-56\-'


Dmitry
