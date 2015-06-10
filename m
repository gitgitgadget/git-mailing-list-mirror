From: =?UTF-8?B?YsOkcg==?= <crashcookie@gmail.com>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Wed, 10 Jun 2015 18:54:35 -0300
Message-ID: <CADQvvWWS35vO9XZAEc6Zb3PPRU1XBOn_Xe+1P3-RVOcSFjbHKw@mail.gmail.com>
References: <5570F094.10007@quantopian.com> <20150607124001.GA11042@peff.net>
 <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
 <20150610185635.GA22800@peff.net> <xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
 <20150610192734.GA23715@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Kamens <jkamens@quantopian.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:55:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2nxd-0004i4-Nc
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 23:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbbFJVy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 17:54:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35627 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbFJVy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 17:54:56 -0400
Received: by oiax69 with SMTP id x69so4903855oia.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UqYSeGh3UfyK0t06cqVnjlW7VzyvnweOBI4tt56nqvM=;
        b=eQ6+BWC3DMBQCqQEo2tKCHwh8Qd/olLyg39uRglsRNHxLUgjcbkNOL1DWmC/EPryfV
         +I26r/+t3VWu76B3zbgub/BI3ZewPyDnYplt9pp9NtF4kS6dkwG/8k1BrInrPvIKUlyF
         MmQkQsLS2p6CKmnfxjPrp8vxdo1NRe1bavM7UI/TevyugXL7LLa+jJDVMmq5GtNr0YDT
         DCsrAyq2A8hNyrnwY3aZsqnFHnAfU3Ul9ZevagRS0LBYOKydwzvvERnmdbyKDK7sNgWY
         LjKurBjjWr31S47dXzJQKbzdSEJbEtXvvbtfhHL7sPyQYaNisAtBqjfqjFxdJuOvOgcS
         YYGw==
X-Received: by 10.202.173.3 with SMTP id w3mr4471098oie.34.1433973296154; Wed,
 10 Jun 2015 14:54:56 -0700 (PDT)
Received: by 10.60.157.202 with HTTP; Wed, 10 Jun 2015 14:54:35 -0700 (PDT)
In-Reply-To: <20150610192734.GA23715@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271361>

On Wed, Jun 10, 2015 at 4:27 PM, Jeff King <peff@peff.net> wrote:
> I dunno. With respect to the original patch, I am OK if we just want to
> revert it. This area of stash seems a bit under-designed IMHO, but if
> people were happy enough with it before, I do not think the safety
> benefit from ed178ef is that great (it is not saving you from destroying
> working tree content, only the index state; the individual content blobs
> are still available from git-fsck).

I feel the same way, in fact I'm +1 to revert it until we figure out a
better way to deal with this properly.

-- 
Ber Clausen
