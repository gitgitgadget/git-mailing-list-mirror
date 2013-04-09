From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 9 Apr 2013 16:14:21 -0700
Message-ID: <20130409231421.GA30308@google.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 01:14:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPhkE-0007KG-SG
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 01:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab3DIXO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 19:14:27 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:45161 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab3DIXO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 19:14:26 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so3254572dad.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CY6RT3lqho0ULNeYEzNnOHQxSnjG8SY1zbImgUPgxTo=;
        b=lJrftX2nb6BmzAkLv6Tbpza4orKJV9SGLc5eofvzPk7MAjvh00EtPIJIP3TdNHAYxc
         NNdLN6prUAyUxoqqB8TlAW2pwwa5GQa14tv7EV4LVE8j67PH4evj96Tm1jn+piVZJ13S
         mZaG7H5BT/T1rDyyIRdADHUGZnN4Z7+2/ShMo0QgJWipmgCmwtlUz5p/JeXsOoHnVfpK
         nCy633J4mYM6yRR3mZ+IXxlwat08WUhhcBjxOXuHP5hncqfuCigex402IEXgKeIRFglC
         bWLK/b2QcSVgs/ptvWfjuhAX5gtxc0Oj1ezgG1i2LU3fB3oWalekcK2zOfvoAyXAvoU2
         U5QQ==
X-Received: by 10.68.197.130 with SMTP id iu2mr4861130pbc.64.1365549265934;
        Tue, 09 Apr 2013 16:14:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id rt13sm48265496pac.14.2013.04.09.16.14.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 16:14:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130409231332.GZ30308@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220652>

Jonathan Nieder wrote:

>              today you can do
>
> 	git push origin master; # push branch master to remote origin
> 	git push --multiple origin korg; # push default refspec to 2 remotes

Pretend I said "fetch". ;-)
