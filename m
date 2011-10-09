From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] revert: Simplify passing command-line arguments
 around
Date: Sun, 9 Oct 2011 03:53:07 -0500
Message-ID: <20111009085306.GA9209@elie.hsd1.il.comcast.net>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
 <1318095407-26429-7-git-send-email-artagnon@gmail.com>
 <CALUzUxo=xN735+=Yz9eS_VSW3fpiTeng9s-66qM0Jno40-DPXQ@mail.gmail.com>
 <CALkWK0kA=zhpsmYhjMwv11xyHNhA0Ps=BjUDao0+HFLMKnADUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 10:53:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCp8Q-0006JF-JZ
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 10:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab1JIIxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 04:53:21 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34324 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab1JIIxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 04:53:20 -0400
Received: by iakk32 with SMTP id k32so6148558iak.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7UktTv/f4Bqur88aN5Q8lCu/Z+hid6n4CzqDZzMg6qw=;
        b=JRRXKZB2AFpqeR0/vgEaNMYUfzJG3qumBTbAUDhDSSKD5df0hp5QJuiCCln0CrMY2y
         EbuaxhqomLiYXWt4AVXezxyGVKIRj+1UlUkWFvS+VG+TI33DAj1J1Ai+ZyVxszAGdV1C
         YrAOSFYwXgCn37n4O4WQ++PzCu84TWVv49CXM=
Received: by 10.42.136.196 with SMTP id v4mr8273324ict.3.1318150399939;
        Sun, 09 Oct 2011 01:53:19 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ge16sm27677597ibb.2.2011.10.09.01.53.18
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 01:53:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kA=zhpsmYhjMwv11xyHNhA0Ps=BjUDao0+HFLMKnADUg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183190>

Ramkumar Ramachandra wrote:

> Actually, I intended to put it in the commit message.  Seems to be
> idiomatic: grep the log for "\[jc:" etc.

More important than the idiom is the intent.  Presumably that intent
was something like "I wrote the commit message, so if it makes you
scratch your head, blame me, not Jonathan; and I made some other
(minor) improvements, so consider blaming me even if it's the
functional part that makes you scratch your head."

Sorry I haven't had a chance to look over the patch yet.  Is it
supposed to introduce a behavior change, does it prepare for some
future change, or is it just a cleanup?
