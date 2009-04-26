From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and Mercurial
Date: Sun, 26 Apr 2009 21:57:36 +0200
Message-ID: <200904262157.39450.jnareb@gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org> <op.uszlmeoo1e62zd@merlin.emma.line.org> <200904261209.08108.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Christian Couder" <chriscool@tuxfamily.org>, git@vger.kernel.org,
	"James Cloos" <cloos@jhcloos.com>
To: "Matthias Andree" <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:11:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyAVl-0005PK-Ir
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 21:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624AbZDZT5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 15:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbZDZT5u
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 15:57:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:14889 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbZDZT5u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 15:57:50 -0400
Received: by fg-out-1718.google.com with SMTP id 16so457185fgg.17
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PXv8oMTms/48wmuBsygab7P3uAkMuZbBED23CBo5lWs=;
        b=TUmob2pZGy+gvh093StBwXKjx6DBJv4ygQ1FumgYFAdiizW961AG5CskAM7hloBe3v
         FU3AozTbFU64yphd/I5joZvPwOsVKtq0oaL21wgEuiIa/LKHNz2N0hn4f2CekEI6LACx
         /DJyz6bGZnJZUBz1BL0/63u+KZ2LYRRjJV/TU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kBa9PyZ7RC60HCWfbMJgG43opa7gapYcnMKN/Rvv82eoMhV5mFxq7Z1bSG/kMvXVMR
         pYuKjtubD56Iha7N5343OsxNKu4APTk4dDRKCWbMZsOmcJ3AhPcCW3pEYsGmLAk1WDbY
         uXLBUv+3EXAHOBO11pf0kYWA1rnsdGagJgf+A=
Received: by 10.86.29.8 with SMTP id c8mr2620838fgc.70.1240775868802;
        Sun, 26 Apr 2009 12:57:48 -0700 (PDT)
Received: from ?192.168.1.13? (abvp13.neoplus.adsl.tpnet.pl [83.8.213.13])
        by mx.google.com with ESMTPS id e11sm3140647fga.11.2009.04.26.12.57.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 12:57:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200904261209.08108.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117620>

On Sun, 26 April 2009, Jakub Narebski wrote:
> On Sun, 26 April 2009, Matthias Andree wrote:
> > Am 26.04.2009, 10:16 Uhr, schrieb Jakub Narebski <jnareb@gmail.com>:

> [...]
> > > The deciding feature (well, one of deciding features) was the fact
> > > that Mercurial has better HTTP support... I guess (it was not obvious
> > > from the analysis, but it was hinted at) that Mercurial uses its
> > > custom protocol over HTTP, as opposed to "dumb" HTTP protocol support
> > > in Git.
> > >
> > > Perhaps it is time to restart work on _"smart" HTTP protocol_?
> > 
> > That would certainly be useful, but the "packs" approach is something that  
> > may make this more difficult than for Mercurial. Git+SSH works rather well  
> > though.
> 
> As you can find in mailing list archives the design part of "tunelling"
> pack protocol over HTTP, using git-aware server (for example some CGI
> script, or simple HTTP server like Mercurial's hg-serve), is done.
[...]

See thread named "More on git over HTTP POST" and its predecessor

  http://permalink.gmane.org/gmane.comp.version-control.git/91196
  http://thread.gmane.org/gmane.comp.version-control.git/91104/focus=91196

-- 
Jakub Narebski
Poland
