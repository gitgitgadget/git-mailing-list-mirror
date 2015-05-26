From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Tue, 26 May 2015 10:48:44 -0700
Message-ID: <xmqq1ti3kz5v.fsf@gitster.dls.corp.google.com>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
	<20150525222215.GI26436@vauxhall.crustytoothpaste.net>
	<xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
	<20150526162937.GA24439@256bit.org>
	<xmqqegm3l06u.fsf@gitster.dls.corp.google.com>
	<xmqq617fkztj.fsf@gitster.dls.corp.google.com>
	<20150526173909.GC24439@256bit.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Brabandt <cblists@256bit.org>
X-From: git-owner@vger.kernel.org Tue May 26 19:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxIyH-0003cX-Qo
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 19:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbEZRst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 13:48:49 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34970 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbEZRsq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 13:48:46 -0400
Received: by igbyr2 with SMTP id yr2so64745445igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=E3C/dfqiUDK4wZsYouavX4rnUs7ZrQ691HgbYdaWMso=;
        b=wCS0AoeZX55yQqVXju06PE+B5yVFD+bD9a8+UVjJXNYBIUSnkvLpwAHPEGgwRE30gc
         tdHX6wp+So3Y3ABV+xusjBHJnl4uwotysBlNHy7trtzIpUyg8SgPECwqgPXEn3ZVChzI
         KUcipbX4pMUwSIBE2TxystGGr37KcpHKKWkS7Lf/MP3PNQvBhPxmlDmC0dttIGY1x2JV
         /R1lyz10dl3RhtWhRKU0dGe7NNoZuk92WjdPgFSEGmIJ+GQzzT5md8NBrSigtBk/QdI8
         oE1oDZe5VO/qpIChAEqYD3I/cy+2OwTuYCcnLCTntxZ3Ln0O8eWkOgdQ2Mftj+HDta6y
         n+Sw==
X-Received: by 10.50.79.167 with SMTP id k7mr31078204igx.32.1432662525923;
        Tue, 26 May 2015 10:48:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id rj5sm8824387igc.2.2015.05.26.10.48.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 10:48:45 -0700 (PDT)
In-Reply-To: <20150526173909.GC24439@256bit.org> (Christian Brabandt's message
	of "Tue, 26 May 2015 19:39:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269959>

Christian Brabandt <cblists@256bit.org> writes:

>> And here is the second one.
>
> Wow, great and so fast! I really apologize it.

No need to apologize, but appreciating would not hurt ;-)

Thanks for an interesting idea.  I spotted a buglet in 1/2 so I'll
queue a fixed version on 'pu' when I push today's intergration
result out.
