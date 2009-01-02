From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: support hiding projects from user-visible lists
Date: Fri, 2 Jan 2009 20:33:17 +0100
Message-ID: <200901022033.18041.jnareb@gmail.com>
References: <4ba6b6c3fc183002407f322663d7ab53c1c28a91.1229202740.git.matt@mattmccutchen.net> <m3ljujg2eh.fsf@localhost.localdomain> <1230082831.2971.45.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Fri Jan 02 20:34:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIpnB-0004mD-A4
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 20:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987AbZABTdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 14:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757134AbZABTdX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 14:33:23 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:51030 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbZABTdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 14:33:22 -0500
Received: by ewy10 with SMTP id 10so6882567ewy.13
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JqOP+9ImeA2cCXcUOFGb0eQVfZspMOysJghjgXtxgqo=;
        b=CoENa8q79GHzR+fKVyQD75jXGDPzHDBb7742yxSLfSpnKdkV06FVwO4Q3wtD/7Jm3N
         JMEeXhmfkAmjVET4KgXFy9RaWHD0MsOGEdYyLNIrpN332BoB7UIsHeCXVA4PHnT/O/QB
         cGfr7juxhlMrKGkCrmIh2QRry1JoqnF7e9eYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aEIiWzGyj2EKmanf641Zc100syQtmgFWlU3YVM/6hw/A1P0WuY2QtKuumCpWb+Seak
         +jL3keRNMQLIC1ielCY/52up4eLlygnYOE67ZSB7Y5X5YLA7z0fvJusvZX61S6+kSxaS
         fMWFS9Moc4dRXYYIty7lDJj6AOt+Rz0DaCgVg=
Received: by 10.210.20.17 with SMTP id 17mr21274493ebt.25.1230924799515;
        Fri, 02 Jan 2009 11:33:19 -0800 (PST)
Received: from ?192.168.1.11? (abvd167.neoplus.adsl.tpnet.pl [83.8.201.167])
        by mx.google.com with ESMTPS id 10sm1521646eyd.46.2009.01.02.11.33.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jan 2009 11:33:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1230082831.2971.45.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104409>

On Wed, 2008-12-24, Matt McCutchen wrote:
> On Sat, 2008-12-13 at 14:02 -0800, Jakub Narebski wrote:
> >
> > Cannot you do this with new $export_auth_hook gitweb configuration
> > variable, added by Alexander Gavrilov in 
> >    dd7f5f1 (gitweb: Add a per-repository authorization hook.)
> > It is used in check_export_ok subroutine, and is is checked also when
> > getting list of project from file
> > 
> > From gitweb/INSTALL
[...]
> >     For example, if you use mod_perl to run the script, and have dumb
> >     http protocol authentication configured for your repositories, you
> >     can use the following hook to allow access only if the user is
> >     authorized to read the files:
[...]
 
> $export_auth_hook would work, and it would have the nice (but not
> essential) feature of including private projects in the list shown to
> suitably authenticated users.  The only problem is that my Web host
> doesn't support mod_perl.  Is there a practical way to accomplish the
> same thing as the above example in a CGI script?  I would like to avoid
> reimplementing Apache authentication-checking functionality if at all
> possible.

I know it is written that the example code is for mod_perl, but I
don't think it is mod_perl specific; have you checked if it works
for you? I assume that you use Apache, and have Apache Perl bindings
installed...

-- 
Jakub Narebski
Poland
