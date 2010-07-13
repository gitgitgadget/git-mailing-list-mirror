From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Treat submodules as normal directories/files?
Date: Tue, 13 Jul 2010 01:48:59 -0500
Message-ID: <20100713064859.GA2918@burratino>
References: <20100713061451.308580@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: wiekaltheut@gmx.de
X-From: git-owner@vger.kernel.org Tue Jul 13 08:49:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYZJT-0001Hu-6c
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 08:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab0GMGtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 02:49:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42730 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab0GMGtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 02:49:47 -0400
Received: by iwn7 with SMTP id 7so5529977iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=J9TpgK7Y9n1v/L/F4KDQ38DVk7fNM/VBavM9mz7+03c=;
        b=fDTKjl6OqWOMwkbZkc8rGX1MqJWhi4TDESA20sP0t4Q5lVRrXX42O/7a5rwy27Y+jX
         w5b2cMGOEnxuIhE0ySxlKkOUNQGXjj7uSYX/po7KSxokB+oKGc7KjFRjrSJptrVaUwES
         /Z8+hxKrmO+Ef8voYRDfMnN1lQlIHLrmTXcCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OsTggOx/JnDhy13VmEb5jYOx0LQHk/1+8JpPeRGwjyTaEm8ln3lbYHdEkNn2nSMYYp
         1BjH2Hx9oJOVu6eB6ZniDYz7/o9ljQRveG9Df7tqN/YAyaFfl0qR/kCfwC3gcTgST9Px
         WMNvHRTk6KUOoGc1igscrmWpaob3Sc6U1f88M=
Received: by 10.231.150.1 with SMTP id w1mr15827775ibv.7.1279003786492;
        Mon, 12 Jul 2010 23:49:46 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm23570527ibi.18.2010.07.12.23.49.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 23:49:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100713061451.308580@gmx.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150881>

Hi,

wiekaltheut@gmx.de wrote:

> Is it possible to treat submodules as normal 
> directories/files?
> 
> I'm using Git not just for source code, but also for 
> documents and my "projects" directory (mainly an
> Eclipse Workspace) in my home directory. Though Git
> may not be designed for this, it is an easy way do
> create a backup and sync my home directory between
> my machines :-).

See [1] for a similar question.  Though the answer in your
case is likely to be completely different; I suspect you
might find bup[2] interesting.

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/144847
[2] http://github.com/apenwarr/bup#readme
