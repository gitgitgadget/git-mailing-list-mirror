From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitweb: false base href sent when integrated via reverse proxy
 and path_info is active
Date: Sun, 28 Nov 2010 10:27:20 -0600
Message-ID: <20101128162720.GB18335@burratino>
References: <20101128081048.13668.67286.reportbug@sb74.startrek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Reichelt <debian@nachtgeist.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 17:28:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMk6x-0003Uz-3J
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 17:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab0K1Q11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 11:27:27 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41904 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0K1Q10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 11:27:26 -0500
Received: by gxk22 with SMTP id 22so1627053gxk.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XMAUNP2bbVeJ6pP0Tt1aytF41Uj4RI4Tbl5gO8k0uuw=;
        b=sta3f2DuUANBSUTixYRAvv4jerJOEpWtkKsv6E0ixu9vaUfymMHzKOzWZrqGlkC9zt
         /Icy7oFPOt3KtWFvryyf4I80nSxDSp3rAPRaenCuDsoWVitxvDq6x5Jh9cHNp7LY/0p2
         cp4CtzSf/XKev0AyYM8IOR6altBZKm7a9mX0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KLFo1TkSrIV5K0px4jT/t8mSUgkaMT1zfGj62bSFE7mu4Fq1/jLmjjVFLjUqX+CAjI
         a4qO+9LCAQtsM1kes8vR6BrSFgvhDvAZIVxvRbEcr9gaJgtnjU0PdW17Gj9yigNpvMJ+
         9+7vxKdElRzcEp4/kkSjQtyP78JEafpQWTKmQ=
Received: by 10.151.158.7 with SMTP id k7mr8579076ybo.405.1290961644789;
        Sun, 28 Nov 2010 08:27:24 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id f4sm2588927yhc.3.2010.11.28.08.27.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 08:27:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101128081048.13668.67286.reportbug@sb74.startrek>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162341>

Hi Jakub et al,

Daniel Reichelt wrote[1]:

> I just noticed that integrating gitweb via reverse proxy is impossible when
> path_info is enabled in gitweb.conf. The base href sent on gitweb.cgi:3427
> contains the "internal" URL called by the reverse proxy mechanism, not the
> original one called by the user agent which makes it impossible for the
> client to display CSS, images, etc...
> 
> I suggest an additional config variable, e.g.
> $feature{'pathinfo'}{'basehrefoverride'} which could override the base href
> tag determinted by the cgi script (or disable sending a base href tag at all
> - at least I was able to achieve my desired setup by adjusting the URLs for
> CSS etc in gitweb.conf to fitting absolute URLs).

Any advice for Daniel?  Is it a good idea?

Regards,
Jonathan

[1] http://bugs.debian.org/605217
