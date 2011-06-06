From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for
 /etc/gitweb.conf (WIP)
Date: Mon, 6 Jun 2011 17:25:00 -0500
Message-ID: <20110606222500.GE30588@elie>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
 <1307382271-7677-5-git-send-email-jnareb@gmail.com>
 <20110606221236.GD30588@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>,
	Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 00:25:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTiET-0007pw-Bc
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 00:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab1FFWZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 18:25:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60692 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab1FFWZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 18:25:05 -0400
Received: by iyb14 with SMTP id 14so3484782iyb.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EuNh9s8UjrPmorzPEH+ckAMBrRLbCY42X/KrUYD07T0=;
        b=SFq/MzBHlAFsh/adfS3Mv8GFclUsqMtaybGuhmYwrXEQJETf8bBF1yFK2y99owWFF7
         3cZiculy01lN4HUGgOdzWKemKex1WcciMUJJKJCxB1uk2a5msObtvHcCYy2qJR/pDWMI
         IgbwVuQa8DPddNS1CUEh709Sm04Z6BiLy6okY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RBZwk9frCBZmzTTQ7S/zIOUDqfIppM61oBI+vIXN0pfGAQ6BsoKiXX/T3lzoTXhqM1
         qLMqzCB2qRGnXuqQZio2g/2sy8w23sIa6jdLzusI0MeYC3C3yMfrys7PpYgZbdERDlA0
         0fEwegYlb2J+VpgBj0qRvzSTr812Mx84QYipU=
Received: by 10.43.55.81 with SMTP id vx17mr9601688icb.52.1307399105141;
        Mon, 06 Jun 2011 15:25:05 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.ameritech.net [68.255.97.40])
        by mx.google.com with ESMTPS id f6sm3056344icx.3.2011.06.06.15.25.02
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 15:25:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606221236.GD30588@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175177>

Jonathan Nieder wrote:
> Jakub Narebski wrote:

>> +$GIT::
>> +	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
[...]
> I think a better default would be "git", so if a newer git gets
> installed in /usr/local/bin then gitweb would notice automatically.

Wait, that's quite wrong.  What I was forgetting about is the case
where the webmaster does not control the web hosting but just has a
place to drop CGI scripts under ~/public_html/cgi-bin.  In such a case
it would be very convenient that "make install-gitweb" just does the
right thing (including using a private copy of git).

Sorry for the nonsense.
