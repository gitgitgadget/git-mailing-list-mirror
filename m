From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/7] migrate api-strbuf.txt into strbuf.h
Date: Tue, 17 Feb 2015 15:00:55 -0800
Message-ID: <20150217230055.GA6785@google.com>
References: <20150116090225.GA30797@peff.net>
 <xmqqh9uqpwe9.fsf@gitster.dls.corp.google.com>
 <20150212230513.GA21222@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:01:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNr8g-0001NS-BD
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 00:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbbBQXBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 18:01:05 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:42243 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbBQXBD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 18:01:03 -0500
Received: by mail-ig0-f170.google.com with SMTP id l13so44903633iga.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 15:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PUztOm4H1ZxZ4UhvMtkqP8cYjQKjJ6kTPYKyvRdEgJg=;
        b=fZ6ccSLSNo4gy5ifhFonCYFd3uIcEouoV/LQd6X7yyW/prRw1F4IshaHMIMKJtLnTS
         DN99kYDnP+3JKixouBquJI+VYkWC4ephHVD3Ew0LLyFZmSOJQtK57rppvC5jCm1LW2nW
         nXCfJtxeiPQ5/ftAobu7e/vejYPsBIwFbfq9hPrVYxTBSQt/9K/vzcaKLlRt7pQ4Teab
         1OdfZxJkV/8Mi71W4kQj6i+W8JvPpchrxl3/uVMCwe/Qx6prstC1qd45axUhKSlF8aSR
         0yqknj4x3aUcA6qp8lIImGTt8DMXOSpPvKnGW9fDxW5m4FIBQ2/Hx3Qq6w7o+Z676hb+
         A5cw==
X-Received: by 10.50.108.108 with SMTP id hj12mr30655562igb.47.1424214062351;
        Tue, 17 Feb 2015 15:01:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:cc13:2338:8bf7:2ec2])
        by mx.google.com with ESMTPSA id yq1sm10870953igb.21.2015.02.17.15.01.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Feb 2015 15:01:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150212230513.GA21222@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263996>

Jeff King wrote:
> On Thu, Feb 12, 2015 at 03:01:18PM -0800, Junio C Hamano wrote:

>> I am inclined to merge this to 'next', if there is a general
>> understanding that we will try to make the headers _the_ single
>> source of truth of the API by (1) not adding to api-*.txt without
>> describing new things in the headers and (2) moving things from
>> api-*.txt to corresponding headers when clarifying, fixing or
>> updating the API.
>
> I'm fine with that (unsurprisingly), but I would like to hear an "OK"
> from Jonathan before going ahead.

Sorry for the slow reply.  Sounds good to me.  I'd prefer for the
in-between state to last as short a period as possible, but I realize
that preference isn't all that meaningful in the absence of patches. :)

Jonathan
