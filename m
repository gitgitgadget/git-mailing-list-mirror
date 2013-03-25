From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 11:20:23 -0700
Message-ID: <20130325182023.GA1414@google.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <7v38vjz7sx.fsf@alter.siamese.dyndns.org>
 <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:21:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKC0y-0004J7-JM
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619Ab3CYSUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:20:33 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:46020 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363Ab3CYSUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:20:32 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so3336334dae.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WhQbMSI7o7l6rjSYHXO+V8cZbHJvFGUjQxsQgjuCDhw=;
        b=WaSxtZ9TJuLz4/o8BPU3gxEjwYTY1bYGu1es+XeKibHBUGaiwYtbdtwtaY7NxhvZrm
         /E6RkLiIY/GcxiRxnBHcwKWE2txJveO66PcMXllULSH5kAb8O64rEbfQnsqD1cevthe6
         aS5okw7BGcWm06U/RgEMU1gF0DQZlzTCLwSEceSzBwYCNFflDlZrVCPqm47QTEWzffc/
         hy4xBue8VTpDPHlVyGP8vlpJBDm6QnxktUop5oAdjRd0Ddj2a9OA1kF6KLAKVggVSsBq
         QcTM2x0NLBSTlqrC6qVc6l9fmUcJCOYdOJQj2RT2JbCCrYNXherekoRluSWZyWYgfSi0
         sHfg==
X-Received: by 10.68.252.39 with SMTP id zp7mr19249391pbc.184.1364235632024;
        Mon, 25 Mar 2013 11:20:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id 1sm14259549pba.32.2013.03.25.11.20.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 11:20:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219060>

Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> Git 2.0 is coming soon, so I'm excited about breaking a lot of
>>> backward compatibility ;)
>>
>> Don't.
>
> push.default is the necessary exception?

A while ago there was a discussion of changes of the "If we were
starting over today, it would be obvious we should have made it work
the other way" kind and potential transition plans for them leading up
to 2.0.  It's way too late to throw new breakage in.

More generally, it doesn't make a lot of sense to save thinking about
such questions for the last minute before a new major release.  If an
important change will require breaking compatibility and can only be
done using a painful 5-year transition, start today (and send patches
to the ML when an appropriate quiet moment comes to get review) so the
5-year counter can start ticking.

Hoping that clarifies,
Jonathan
