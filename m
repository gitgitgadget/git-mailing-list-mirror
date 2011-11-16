From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Wed, 16 Nov 2011 16:28:50 -0600
Message-ID: <20111116222850.GA17750@elie.hsd1.il.comcast.net>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
 <CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
 <7v1ut9uglb.fsf@alter.siamese.dyndns.org>
 <CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com>
 <CALUzUxrM8o1uahQgSFUuvZ0mSPxG_zVQ9awOantRM2A8kkbbtA@mail.gmail.com>
 <CACf55T5cp1ko45DCufcRXm=EeZd1-x+aYasvbzjDXkQH31u5VA@mail.gmail.com>
 <alpine.DEB.2.00.1111161008430.19479@tvnag.unkk.fr>
 <CACf55T6rUiE8Pm3s16oFgJ1ueTAdOwOz_+XptE-tZM1z9fcq+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 23:37:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQo6g-0001l4-Tx
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 23:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab1KPWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 17:37:22 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41507 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab1KPWhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 17:37:21 -0500
Received: by ggnb2 with SMTP id b2so277880ggn.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 14:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lF3kBZ8fZNVSjveUJt7v7l8Q2p6X2c9Q/esPJXnWBqk=;
        b=uVMhX8SA8MDEK/SNVfP3FgQo511cSzZRcNq4ZhF0g72wcRBg21G1LzlLIg8eJihqVD
         /Z7e8juzsJY4XVZheNMheQn7OMJxNiB7FzJeZT72gGSIMenuOjKfXRRGFhw8upQbRYBD
         tiYkdkTPWXfFDsfQN93AGdJqxl2ebCVULZiAs=
Received: by 10.236.201.200 with SMTP id b48mr4983422yho.76.1321482541560;
        Wed, 16 Nov 2011 14:29:01 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id u10sm42018751anj.6.2011.11.16.14.28.59
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 14:29:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACf55T6rUiE8Pm3s16oFgJ1ueTAdOwOz_+XptE-tZM1z9fcq+w@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185558>

Dmitry Smirnov wrote:

> What Git is providing to libcurl? Can I log it?

ltrace can help.
