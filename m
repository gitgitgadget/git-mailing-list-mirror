From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v2 0/9] Subversion dump parsing library
Date: Thu, 24 Jun 2010 16:26:02 -0500
Message-ID: <20100624212602.GA2458@burratino>
References: <20100624105004.GA12336@burratino>
 <AANLkTilGNaF05EW2IFUpjOx-lP8sDoCkSrsa1-vMZo6B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 23:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtwN-000579-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 23:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab0FXV0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 17:26:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43874 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab0FXV0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 17:26:15 -0400
Received: by iwn41 with SMTP id 41so1244461iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=T+PI63ISsiyIJohDHWWJL6u5eg/M4bC28odOS6DXhcc=;
        b=lpNgJSb7m1PNbx26HlFkhLhPkGfBxeobWc0zVw5xy2VDFKZ5QftHXrFMgjKv0vgN/p
         Z7i9f91EciYnfGKvyD6BoA25oXbHKZe05Vm7TZT4vuEHpOqh1I3Ge8cj/R+5YzG31mzo
         kLw4X0HrMf4d4U/Zqg4XYvgFA+EGR3wIHO7Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xVAgt3GfXznAr4oukGGg+VuoNwmUalf3Hyh6x5a2/xlKIGmU7KWSNtDDpWyNrXy/C6
         QiwsJ2lT8QHT2H5JvfbTREp8QBivs+rtJ1Apz9Mm1c3mIW5HDHRl9TDeV52tISKEckI+
         uU4lm3dxUyDI2x4YaLpcYnGBjBAcNp8G4+F3Y=
Received: by 10.231.125.223 with SMTP id z31mr10794611ibr.78.1277414773847;
        Thu, 24 Jun 2010 14:26:13 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm19415478ibi.14.2010.06.24.14.26.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 14:26:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilGNaF05EW2IFUpjOx-lP8sDoCkSrsa1-vMZo6B@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149652>

Ramkumar Ramachandra wrote:

> I'm in favor of the split mainly because it doesn't make sense to
> re-roll your contrib/ patch everytime the infrastructure in vcs-svn/
> changes
[...]
> I want to get the contrib/ patch in so people can test
> the infrastructure everytime it's re-rolled and goes to `pu`.

Yes, I agree: ideally this should be two branches:

  rr/svn-export for infrastructure
  xx/svn-fe for the frontend

with the latter based on the former.
