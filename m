From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH 2/2] gitk: Markup many strings for translation.
Date: Sat, 28 Jul 2007 00:19:19 -0700 (PDT)
Message-ID: <828559.60536.qm@web38904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 09:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEgaN-0007wX-BA
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 09:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758271AbXG1HTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 03:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758242AbXG1HTV
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 03:19:21 -0400
Received: from web38904.mail.mud.yahoo.com ([209.191.125.110]:31595 "HELO
	web38904.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758183AbXG1HTU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 03:19:20 -0400
Received: (qmail 60765 invoked by uid 60001); 28 Jul 2007 07:19:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Z5v1iOZ5xqPgxScAYaERSNWIFXRqywPZxefqHRwVHdw6GcVF5xY4NMzXwhnVOO0lBOP5ZSwt7xOpuBFCK7PExVpYvwaqd/BK4lsQ9OKkEI0Zx/lgcFWDHkGEEPvMwNXtbmW8QqOfbRwydThjuQ7zbJ0A1wLrM82GRl0I4vm6JR8=;
X-YMail-OSG: snFnUGkVM1mbrkZwsc94WcLiciYDHNaNXnyUnU6DRDee2OKH5v0CCwB3MS3Gd5NHoCMdc3oymKFYmN3eyNjxFMG7Epyw3JQwoXVwQ6O4bC5HtDrcgvGf7Qa6Gw--
Received: from [128.251.88.135] by web38904.mail.mud.yahoo.com via HTTP; Sat, 28 Jul 2007 00:19:19 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54000>

> 
> 
> ----- Original Message ----
> From: Paul Mackerras <paulus@samba.org>
> To: Brett Schwarz <brett_schwarz@yahoo.com>
> Cc: Christian Stimming <stimming@tuhh.de>; git@vger.kernel.org
> Sent: Friday, July 27, 2007 7:40:20 PM
> Subject: Re: [PATCH 2/2] gitk: Markup many strings for translation.
> 
> Brett Schwarz writes:
> 
> > > -        set commitinfo($id) {"No commit information available"}
> > > +        set commitinfo($id) {[mc "No commit information available"]}
> >
> > I think this is probably a typo (on the original), and carrying that
> > forward will probably result in what was not intended.
> >
> > The original has the {} and "". I don't know if this was intended
> > (it will keep the quotes).
> 
> Yes it is what was intended - it is a list with one element, which is
> a string.

Ah, ok. Then the patch probably should look like this then:

  set commitinfo($id) [list [mc "No commit information available"]]


Regards,
    --brett




       
____________________________________________________________________________________
Moody friends. Drama queens. Your life? Nope! - their life, your story. Play Sims Stories at Yahoo! Games.
http://sims.yahoo.com/  
