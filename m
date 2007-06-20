From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Wed, 20 Jun 2007 18:54:40 +0200
Message-ID: <200706201854.41571.jnareb@gmail.com>
References: <f2t6na$5bi$1@sea.gmane.org> <20070619172619.GH19725@planck.djpig.de> <Pine.LNX.4.64.0706201129550.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 20 18:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I13SC-0006Ie-FT
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 18:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbXFTQyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 12:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbXFTQyq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 12:54:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:26578 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbXFTQyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 12:54:45 -0400
Received: by ug-out-1314.google.com with SMTP id j3so392689ugf
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 09:54:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sPzqxK7iY1vkoRiztxmw6imt+J5I6YGj2H9FRy1Hyg7XVdg0USPrBHd3Dz5qIWHmXYRYnZYZIyWtwCnWJJCg//72asjKKT9Y5CJR4zOxVuTiP2Ifnur/fo5iaiRz2ZRpqi8RkWGXHOuvR1Q1WeZMkTwkStdfb6qRosgo74hBWvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=doCDzOQ7YDFMEK52jQB4bIF++dgGS6x9eWrZ0xUJD6BsQjDVFmRxCdsnLgj21KDvmw7ankpOpSVprl9lxP5AsjkMBFTZNGJgYFVbhaThuaptn1cRwKTzmRFCpe8ZRxi1uZXuu631K2ISL5AGw4qJNUTTsZXJAoLhZcq5CzIWT7A=
Received: by 10.82.158.12 with SMTP id g12mr1838081bue.1182358483898;
        Wed, 20 Jun 2007 09:54:43 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm2602540mue.2007.06.20.09.54.42
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2007 09:54:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0706201129550.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50561>

Johannes Schindelin wrote:
> On Tue, 19 Jun 2007, Frank Lichtenheld wrote:
> > On Tue, Jun 19, 2007 at 04:57:21PM +0100, Johannes Schindelin wrote:

> > > [foo "bar\nbaz"]
> > > 	key = value
> > > gives
> > > 
> > > foo.barbaz.key=value
> > 
> > for me this gives
> > 
> > foo.barnbaz.key=value
> 
> Yes, of course I had to have a typo in my message. *sigh*
> 
> The point is, that I would not expect a "\" to be _ignored_. Either 
> interpreted, or throwing an error, but just ignored?

It is interpreted. Perhaps not what you thought it is interpreted, but 
it is interpreted. '\x' => 'x' for 'x' which are not in some limited 
set. ;-)))

-- 
Jakub Narebski
Poland
