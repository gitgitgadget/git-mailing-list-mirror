From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 09/35] lockfile.c: document the various states of
 lock_file objects
Date: Mon, 22 Sep 2014 15:34:49 -0700
Message-ID: <20140922223449.GH1175@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-10-git-send-email-mhagger@alum.mit.edu>
 <20140916210317.GJ29050@google.com>
 <54203E4D.7030800@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 23 00:35:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWCCq-00017C-TK
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 00:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbaIVWex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 18:34:53 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55587 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbaIVWew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 18:34:52 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so4487855pac.31
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p0Szqzt5uQajKkohSGwBTJzuC0Bw47uUai8w4dFt+8Q=;
        b=Rb90YYCPfMYgPE+OR1wfCu97aDiK6nMcOp52sXoVX+zC+3YtvYNjPHwtQLEcdAg30d
         GX8LXuodrlpOPxeBxFYnElPEaM6J49y93C1BkS6AySQOzxOHo9gODrn2bG1G4j1bj2c+
         gaL8CeDS7IL4+E6j5cy/Gt74S0Ml9637OIvyo5F17RtMC30Ph1TYEWILRFdWCQKGWF6H
         tWaQ2zqZtKgPoh/w7Sfkjr0yk0VhFNfktLhJ11reZnjY8XsgFBWH6Ahoufw41C4BQkmR
         aL3wKB4uXFZcK4Svqw8QVO5xDE/Ps5Wr/ys/f37jhgWCQ+suss1zGuEKWeEkb9uS5S95
         8o4Q==
X-Received: by 10.66.157.231 with SMTP id wp7mr7452169pab.151.1411425292425;
        Mon, 22 Sep 2014 15:34:52 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id i4sm10287337pdk.54.2014.09.22.15.34.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Sep 2014 15:34:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54203E4D.7030800@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257389>

Michael Haggerty wrote:

> I agree with your point about overlap. I will split the documentation
> into two parts with less redundancy:
>
> * Documentation/technical/api-lockfile.txt: How to use the API.
>
> * lockfile.{c,h}: Internal implementation details.
>
> I think the implementation details would get lost among the thousand
> things in cache.h. So instead, I will add a commit on top of the patch
> series that splits out a lockfile.h header file (which I think is a good
> idea anyway), and moves the internal documentation there. Sound good?

Yep, a separate lockfile.h header file sounds sensible to me.

Thanks,
Jonathan
