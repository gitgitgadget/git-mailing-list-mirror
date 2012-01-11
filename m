From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Wed, 11 Jan 2012 22:22:25 +0530
Message-ID: <CALkWK0=obkB=uxtgKJpBWQ-YUsiOjHeegx3d5NHMTub-8nU_Dw@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com> <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino> <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino> <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
 <20120111131854.GG32173@burratino> <CALkWK0=gvsvqk7Th7YY_eRzb+Ri52AZbOVokC98i9BXVAJOZEw@mail.gmail.com>
 <20120111164758.GD1891@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 17:52:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl1Px-0000J2-34
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 17:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474Ab2AKQws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 11:52:48 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:52787 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432Ab2AKQwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 11:52:47 -0500
Received: by wibhm14 with SMTP id hm14so521507wib.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IqUUfsFRFTzccWNmzyh2UjCczPRE2yHAnLfI/AXkG7o=;
        b=Cocv1B3AyKbu4ezfOd8V/G3QIQ3ktRqegv59CpAL3ysFlTTAsK5NwEPgz2yxVmvt4T
         gR85ia07Zo1r8AV2S8b+KviwRo+SRWQMKI1LmKqjfbzvelsz8y8ZMyPGpee29RKJwXns
         Y2+F60/8mMkeeJj6X3TfwfdSlmHvI14+RgNSw=
Received: by 10.180.82.5 with SMTP id e5mr12122504wiy.18.1326300766240; Wed,
 11 Jan 2012 08:52:46 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Wed, 11 Jan 2012 08:52:25 -0800 (PST)
In-Reply-To: <20120111164758.GD1891@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188374>

Jonathan Nieder wrote:
> In that case, why not just a patch to move the code to sequencer.c,
> with whatever is the minimum of related fixes (just namespace stuff,
> I'd imagine) before it?

Cool, I'll do that then.  I thought what I'd originally posted was an
acceptable minimum to show the motivation for the move.

-- Ram
