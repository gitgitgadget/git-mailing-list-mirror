From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] checkout --detached test: write supporting files
 before start of tests
Date: Fri, 13 Apr 2012 18:49:49 -0500
Message-ID: <20120413234949.GF13995@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413232535.GB13995@burratino>
 <20120413233346.GB16663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:50:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIqFc-0008Do-Nq
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 01:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab2DMXtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 19:49:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59409 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab2DMXty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 19:49:54 -0400
Received: by iagz16 with SMTP id z16so4910062iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BDQsQYnyDx69kXltxOZohexjGpJsN5jHmfq1l7x9Dkg=;
        b=B7u3ye79JRmcFSBkE+UKfgC4VxiZUo7o+2Ufr138mw3gfrdpdOVcVEXI99WcHNVeMg
         bMuzrzF8KjAt5dte9B3RUIXgaxejEuWJjBjL6WhezOqKJSx5kpsG2GOf0TNCru91b/2O
         huuTbfZaYMEC6o0rO5pIYeuZEEdkVq7396YBbfoItdAcdcGkotQtzk7/K4IDADBOznJs
         mZHEeKzM3Ie9poVL7Q0eiArh3ordMhEf6c7GSoiNl0d7KOS5WnWywUbB/VVE1orS6HvQ
         LQZhxCOMJfmyb2+t16kJr5jGQRr+iblmFMWs9lu6NimjP4u7xionxou1t6aXxcVpjsNW
         B2Yg==
Received: by 10.50.187.226 with SMTP id fv2mr48308igc.40.1334360994043;
        Fri, 13 Apr 2012 16:49:54 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id em4sm175539igc.16.2012.04.13.16.49.53
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 16:49:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120413233346.GB16663@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195460>

Jeff King wrote:

>                                                If anything, should this
> not be moving the cat inside the test_expect_success?

That would be fine with me.  It would involve changing the ' around
"master" to '\'' and would mean that if some later patch wants to use
the same message, the author will have to remember to factor it out.

On the other hand, nothing about the message is specific to that test
assertion, so I am ok with the patch I sent, too.
