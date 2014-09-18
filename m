From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch
 series overview)
Date: Thu, 18 Sep 2014 10:38:01 -0700
Message-ID: <20140918173801.GC1175@google.com>
References: <20140912004717.GY18279@google.com>
 <xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
 <20140912191812.GZ18279@google.com>
 <xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
 <54136B10.4050001@alum.mit.edu>
 <20140912235745.GB18279@google.com>
 <54198B39.8020405@alum.mit.edu>
 <xmqqfvfoq3ra.fsf@gitster.dls.corp.google.com>
 <20140918165721.GA772@google.com>
 <xmqq4mw4q1qc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUfep-0004Nw-9L
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 19:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137AbaIRRiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 13:38:11 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:49930 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714AbaIRRiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 13:38:10 -0400
Received: by mail-ig0-f179.google.com with SMTP id l13so1815169iga.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8m5raMjUW4atqLURlbC17qIuHabycLjocuOwsNL9LGQ=;
        b=JF3OYCBixtHq3JRPx5XVx7TWi3PAW+xxTGcoa3mtMlJmJDU7MNc/aKAN7Y3+Z6G5eQ
         l2eQKYbcR1UsZ0V9ZtqFUC8EIhyQicAl0/DueMMylJ0h5cgGyiaEOl41QjMaLQn7lhFG
         jpLiyrbeim2coIoJF2cEwZpNz5V37LLiTTb5gW9Eu7v0t+B0cYvTQFPvxHxi6G+Aenr/
         4tU2IZsajbCV45aRrcdS2shdSZBeJygdSdnEeS/08fiZSrzjzLodCbxXWBjRf5MWm1rV
         3C/MRUyElDtEATe+l1yCWL/ycqlvnSid3vPcfzTWkDp7QJyorby4TVwRygNUNjah66xx
         HbIw==
X-Received: by 10.50.12.4 with SMTP id u4mr1404737igb.22.1411061889190;
        Thu, 18 Sep 2014 10:38:09 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id p5sm2710634iga.5.2014.09.18.10.38.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Sep 2014 10:38:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq4mw4q1qc.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257271>

Junio C Hamano wrote:

> Does the order of changes that appear in
>
> https://code-review.googlesource.com/#/q/project:git+branch:master+topic:ref-transaction
>
> have any significance?  e.g. is a "topic" supposed to be a single
> strand of pearls on top of the "branch", and the top one is the tip,
> or something?

Alas no, though that would be a good feature.

Search results are ordered by which was last updated (for example when
someone adds a comment).

The 'Related Changes' shown on the change screen are in topological
order, with the tip at the top.

Jonathan
