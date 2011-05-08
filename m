From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sun, 8 May 2011 01:49:02 -0500
Message-ID: <20110508064902.GA12868@elie>
References: <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
 <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
 <20110506065601.GB13351@elie>
 <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
 <20110506141719.GA2991@elie>
 <BANLkTikW2u2W=Hpw2G4VJf_h88x4_7x_=Q@mail.gmail.com>
 <20110506145036.GB2991@elie>
 <BANLkTimdS7vs71vEVTxutvyp3rC4KxPjMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 08:49:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIxo2-0000D9-3R
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 08:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab1EHGtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 02:49:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33766 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab1EHGtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 02:49:11 -0400
Received: by iyb14 with SMTP id 14so3592994iyb.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ULNJ9wBwv5XwB6R/VaCFzv1TCjtLRxsY8/rEhQImXLg=;
        b=LKoWtDJCeFe+9PyUkif9ZPxtMjUxypx3da08DVhAtg+oVce7/szl/3GbnkPt8FTMG5
         1e1e791yevWOh1bWdkcPKD1JL2T9KlBjkXh+Qvn/5IBxsDtzEguxiRhkG5pSBIyef+d8
         qzm1fUP3I7/9OluPBK3QDtezKEVw5C1b1RP0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WAIIT85ocEpl/vRNoqewYS45PVCdJbBK8yxZId4XspkPz8mAAM5HgvKCgfXYDVedTH
         ABc0iAsUrX7k26Iqxj7zFk2Tg4+xglPOn73DjAEnBw4hCAKH+5GNWZUQ4B8VVhXI5EDL
         E1gfEORfblbs0D+qiZ46RKjI7Z7IuBGezCW54=
Received: by 10.42.159.65 with SMTP id k1mr4773570icx.174.1304837350280;
        Sat, 07 May 2011 23:49:10 -0700 (PDT)
Received: from elie (adsl-69-209-53-78.dsl.chcgil.sbcglobal.net [69.209.53.78])
        by mx.google.com with ESMTPS id u17sm2081159ibm.28.2011.05.07.23.49.07
        (version=SSLv3 cipher=OTHER);
        Sat, 07 May 2011 23:49:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimdS7vs71vEVTxutvyp3rC4KxPjMA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173074>

Jon Seymour wrote:

> The idea isn't to replace standard operating system facilities for
> application installation. The idea is to provide a uniform interface
> for accomplishing the rather limited task of extending git that can
> work the same way, irrespective of platform, irrespective of file
> system layouts, irrespective of assumptions about which directories
> are already in the user's paths.
[...]
> If at the end of the day, we say make and install are the way to do
> it, then fine. However, this makes the dependencies for a successful
> install strictly greater than the existence of git and a POSIX shell
> which we can assume if git is already installed.

Thanks for explaining, and sorry to have given so much grief by not
understanding.

If this whole conversation were about how to add a new menu item to
git gui, I would have understood completely.  Having to figure out how
to get something in a directory listed in PATH would be undue
complication.

After going in circles a few times, I think you're saying there are
also some people using git on the command line for whom "make
prefix=<whereever> install" won't cut it.  With such a person in mind,
what you're trying to do makes sense --- and why not do it, when it
will bring some other benefits as a side-effect, like the ability to
add new commands without them showing up in git-<TAB> tab completion?
So I'll be quiet now.
