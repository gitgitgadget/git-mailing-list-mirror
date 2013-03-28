From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Composing git repositories
Date: Thu, 28 Mar 2013 11:21:40 -0700
Message-ID: <20130328182140.GO28148@google.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <20130327192630.GF28148@google.com>
 <CALkWK0nreJZX4msFET0a7cuUMWNbQhhqy+ezrkqYGqL4_a2duA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 19:22:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULHSo-00088r-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 19:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab3C1SVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 14:21:46 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:61200 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab3C1SVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 14:21:45 -0400
Received: by mail-da0-f41.google.com with SMTP id w4so4654561dam.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9Y3dk4yrqacr2Rd2TW3W8Hjae4QckQOBE98NLTPZe0I=;
        b=RPIgYJ+0lSlKzItD6ohCID7caMidPmjKDtTwFKkpSCBuRwdrbsTR64SpgYR57FUvrZ
         m4AF6vAiueB/QY6jA75nDViort4YwqwbdiwGX/ziHBy4AQ2RNRZDtBpb4sDvB28AC1vM
         jRYdBoD4HiK8p/fIbggFCCljElXDvK6CsCNIpni1JV0QOk3abH3SPKBQO1ar0IZ4zlqD
         +cgM+VdUoRbbznsYt/QbORPO6v7s9PCS4y4Ggo0MHQxSzLwOwSyCscfxQOSVUHnxb1R1
         6C/W53QeX7SFWkDVHsz+cdvovPoch4OpFK1eCGsrPmpwqNchHQfIL0Q3mNiz2qaPRPPL
         MK+g==
X-Received: by 10.68.243.98 with SMTP id wx2mr37583095pbc.68.1364494905357;
        Thu, 28 Mar 2013 11:21:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ab1sm26375919pbd.37.2013.03.28.11.21.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 11:21:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nreJZX4msFET0a7cuUMWNbQhhqy+ezrkqYGqL4_a2duA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219438>

Ramkumar Ramachandra wrote:

> Do you realize how difficult this is to implement?  We'll need to
> patch all the git commands to essentially do what we'd get for free if
> the submodule were a tree object instead of a commit object (although
> I'm not saying that's the Right thing to do).

What are you talking about?  Yes, of course I realize that recursing
over subprojects that are managed as separate git repositories
requires writing new code.  That's why people have started to write
such code.  They seem to think it's worth it.

Meanwhile others with different designs in mind have written other
tools.  Use cases even overlap a little, so they can compete.  That is
exactly as it should be.
