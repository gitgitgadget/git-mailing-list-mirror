From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Trying to setup Visual Studio 2013 with a CentOS 6.5 x64 git
 server
Date: Wed, 23 Apr 2014 12:20:37 -0700
Message-ID: <20140423192037.GF15516@google.com>
References: <CAOWfAePSjpOaN0pgaVqjHxvdMPp2WnEhHj2-Wea1dV7WyjtMiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Buege <charles.buege@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd2is-00032P-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249AbaDWTUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:20:41 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:59690 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbaDWTUk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:20:40 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so1066084pdj.41
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TL/P/oo/Wx8fUpv8EUZ3HEImuxRtKxV91AIzK3TG7bw=;
        b=f+5j0tHMEJ48RSIiWtnAvxMvQc5sKAFiuoGR3BWMTout5b3OnZojbrLwslAokARNsZ
         TGZ30oi6RsGs5KeHDFmKlkBex6ELfxz0ZSk1cUVTpkOMEIbHSW5NOzNV7yLj5kzMY1au
         kRYKFmQ60rwX4w/1ha8dcESbky/mL9BPBwhGfbV2IykqUzNE1Br2xVvzVu5FE7+co/mG
         6kVZenfGCimVA1ICGxr3uOORqeufENgSbbUrJDRiSOTD5vnCL6z+s1mBOXJyZvgJ9org
         jjgM0UeZ3mnWoHmtzaWztOoA4yzSCi4+XTZhxiCwRxOVReR546RNQSn4OkB4dc1ByB+/
         xzWQ==
X-Received: by 10.68.201.97 with SMTP id jz1mr58306589pbc.26.1398280840190;
        Wed, 23 Apr 2014 12:20:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gu11sm4163784pbd.38.2014.04.23.12.20.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Apr 2014 12:20:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOWfAePSjpOaN0pgaVqjHxvdMPp2WnEhHj2-Wea1dV7WyjtMiw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246870>

Hi,

Charles Buege wrote:

> If, in actuality, I can use a CentOS git server with Visual Studio
> 2013, can anyone point me in the direction of an
> FAQ/directions/YouTube video/book/anything for how to setup something
> like this?

I suspect
http://msdn.microsoft.com/en-us/library/hh850445.aspx#remote_3rd_party_connect_clone
should get you started.

As far as I can tell from #git, every once in a while people seem to
want to escape from GUIs to have control over what they're doing (for
example when cleaning up existing commits, or when performing a
complex merge).  You can find a usable commandline version of Git for
Windows at http://msysgit.github.io/ (and the same project has a
TortoiseSVN-like explorer plugin called GitCheetah if you need that).

Hope that helps,
Jonathan
