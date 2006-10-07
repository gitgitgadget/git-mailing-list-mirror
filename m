From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: gitweb: using quotemeta
Date: Sat, 7 Oct 2006 10:41:21 -0700 (PDT)
Message-ID: <20061007174121.44284.qmail@web31813.mail.mud.yahoo.com>
References: <200610071123.23654.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 19:41:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWGAy-0005qm-QZ
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 19:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWJGRlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 13:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWJGRlX
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 13:41:23 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:37813 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932354AbWJGRlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 13:41:22 -0400
Received: (qmail 44286 invoked by uid 60001); 7 Oct 2006 17:41:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GMMv4w6arwiD4z+qGu5dO0moatKRYjP7za0BMU9suT7lZqse8G4KciYp0MIb3i2iodXh+Ko8mFSOn6WHphFoceKTkV+J1Y/HIuxJ18aQRr7W7iIbtbIcX5gil+kDJkLHxDSYgpYOLYAEOiTgJdDzMHmpsI3G197XGbEJtmXvi2Q=  ;
Received: from [71.80.233.118] by web31813.mail.mud.yahoo.com via HTTP; Sat, 07 Oct 2006 10:41:21 PDT
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <200610071123.23654.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28489>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> >> I'd rather add (and use) separate subroutine for quoting/escaping
> >> values in HTTP headers, or to be more exact for the filename part
> >> of HTTP header "Content-Disposition:". This way if we decide to
> >> not replace all characters outside US-ASCII in suggested filename
> >> to save with '?', but only qoublequote '"' and linefeed '\n' characters,
> >> or even implement RFC 2047 to do the encoding (of course if browsers
> >> can read it), we could do this in one place. 
> > 
> > Sounds sane.  quote_filename?
> 
> Luben Tuikov used  to_qtext  in
>   "[PATCH] gitweb: Convert Content-Disposition filenames into qtext"
>   Msg-ID: <20061006191801.68649.qmail@web31815.mail.mud.yahoo.com>
>   http://permalink.gmane.org/gmane.comp.version-control.git/28437

I think that people familiar with the RFC will be able to quickly
recognize what this function does, after seeing "qtext" in the
name of the function.  After all, not only filenames can be qtext.

    Luben
