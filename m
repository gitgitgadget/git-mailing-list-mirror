From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Thu, 20 Jan 2011 21:08:27 +0100
Message-ID: <20110120200827.GB14184@vidovic>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino>
 <20110116020207.GC28137@burratino>
 <20110120193923.GA14184@vidovic>
 <20110120195726.GA11702@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 21:08:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg0oI-0006OJ-6F
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 21:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab1ATUIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 15:08:35 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59553 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab1ATUIe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 15:08:34 -0500
Received: by wwa36 with SMTP id 36so1061928wwa.1
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 12:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=H85qrJsSeRNrfoh1jwwRnbzq5tBEtkEkmaQ8HWArUC4=;
        b=xrMfbRQsWBtrRjxj8GgjamDfeN5uwfPyVG7DwmAMva3mvHTT3YGnCqp5GJA0jSxgPg
         S3a2TmS+v5czVFTc8fPFuF1FIyMdzIYbjV7D1J2n5EcF8asYG3uw1DNEYjdpzt2nzOmP
         NIBKrEMo2Nop7KixEzaD446mBuoBhcEnKsl68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N7jKNKxOZINbEyipVWbdnNKUiVcuGrc9iQkYiFhFSMa7J+EC4g5GJ39wq2t8eBj+hk
         xIslf0Tk60ZRKv9wUhLKkZDKIojOyPnuvuOa6kkhHsf35ggX+Qmb8sbQnbxabatQLUVU
         JxsWFeOqvsQZXQmnVJ3+6CamPL/L+L1/UFlyE=
Received: by 10.227.93.211 with SMTP id w19mr2908236wbm.155.1295554113717;
        Thu, 20 Jan 2011 12:08:33 -0800 (PST)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id r38sm4459930weq.47.2011.01.20.12.08.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 12:08:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110120195726.GA11702@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165328>

The 20/01/11, Jonathan Nieder wrote:

> Okay.  I agree that my particular wording was confusing.  Are you
> saying the "noop" command in general is confusing?
> 
> The "noop" is itself a non-operation; if you combine "noop" with other
> instructions then the noop itself will have no effect.  Meanwhile if
> you have _no_ instructions then the rebase is cancelled, while if you
> have a single "noop" instruction, that means "I have discarded all the
> commits, but please rebase anyway".

Ok, I think I get it now. What about adding

  Use "noop" with no other instruction to fallback to a non-interactive
  rebase. If other instructions are present, "noop" has no effect.

?

-- 
Nicolas Sebrecht
