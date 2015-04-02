From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Thu, 2 Apr 2015 16:14:52 -0700
Message-ID: <CAGZ79kZtqn-7eZ1bZPFXL75NKMQc4yLafO7=StgapDx9=-PCdA@mail.gmail.com>
References: <20150302092136.GA30278@lanh>
	<xmqqr3szql9r.fsf@gitster.dls.corp.google.com>
	<xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
	<1935847.zk75T7vt7M@mfick1-lnx>
	<CAGZ79ka9ficRLEV6KrG5qeAac0ZAQrj2nT=QF=_tFys5pq=5=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 01:14:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdoKA-0001NW-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 01:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbbDBXOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 19:14:54 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34915 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbDBXOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 19:14:53 -0400
Received: by igcau2 with SMTP id au2so89207074igc.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=goNctG0SDlLcw4vEK+a1Jn1/qCPeWD7XoyryE7a3nKo=;
        b=II08BPnGY9/00B/BxOVdsB/S0+TzZKu9TSAuVL2+Ha8cBkxkgo3lhUcwqxOQzeC7i4
         /5J6pCH/GRSaDYd26MT5WAbF5+3/gWZ4B0yOwlGRVk4ct2BCOFaL84XgBbYlONgISg0p
         NM3j2JlHwKehnFYokO0Qfup0R4HlqqhIGCLBTM9qNedvvJvR5m9S6ijZX+UcCQr2HDR7
         f6qOqTHVovgyU+y4wHy4n3I6s9czQfBIAslTFJP4uBvCZ8tNUlN56GPSbaHayFL5PGQf
         rGoKb+QBdsCamZp1NHt4ySJqOnEYDs+S/6T1Z5JYwY1tgPPjtALRHWvH7EKLc2umqv4a
         ElzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=goNctG0SDlLcw4vEK+a1Jn1/qCPeWD7XoyryE7a3nKo=;
        b=QnR4vMPb+2s92Tdl/f13oVXC8FRSnmvq7mleYdhVtQgDkTM7+J3iuO+WJ4PLp1DSLe
         B0oIFtgxaY6cIsz0EhS6MY8jGlMlvJLgr1/k4o79cwKeTw9xRRe2hE3JE13q78+rY98T
         FPSa5GHFKdZBImBQaS9QRlOlMue68aK00wvY+qlXRxR0K8D5oz3UdAfl06z0SDZI9R8F
         YCtoTAzy9JOCTQ4LJfWS5mLlhDM5+buAywQbKJ0feVp4MCEfZ9KEcfOI2I0vamDMDcSp
         BY8RXn7o0AMIZfbPfhdE/x+FHbWTQg+ZkeihV3wpw3pf+0ylJYpBBw9XjJsVsZvRlr+P
         JHFw==
X-Gm-Message-State: ALoCoQmylCJiGf/1pnGj2ZikoImHtMsiP7sVJr6Pek7hEnmK4mfQJL2ofMEhJ6hKEzCpL2NBCLF2
X-Received: by 10.107.132.223 with SMTP id o92mr12211153ioi.49.1428016492609;
 Thu, 02 Apr 2015 16:14:52 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Thu, 2 Apr 2015 16:14:52 -0700 (PDT)
In-Reply-To: <CAGZ79ka9ficRLEV6KrG5qeAac0ZAQrj2nT=QF=_tFys5pq=5=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266692>

After looking at $gmane/264000 again, maybe the client should talk first
stating all the relevant information it wants to get, though I realize this
is not part of capabilities so maybe it could even before, such as:

Client: All I want to do is an ls-remote, so only Phase 2, no
transmission of blobs phase 3
Server: ok
Client[as in the previous mail]: Last time we talked you advertised
hashed to $SHA
Server: that's correct!

As the server knows the client doesn't want to know about Phase3, it
can omit things
relevant to that phase such as the signed push nonce.

So from a high level perspective we'd maybe need 4 phases like
Phase 0) declare the intent (fetch/push all or partial parts)
Phase 1) negotiation of capabilities
Phase 2) ref advertisement (i.e. changes in the DAG end points)
Phase 3) transmitting the missing blobs.

The problem may be that phase 0 and 1 may require mixing, as you may want
to declare new things to do in 0) which you would have needed to advertise as
a capability in 1). So maybe we need to swap that around:

Phase 1a) negotiation of capabilities
Phase 1b) negotiation of intent (fetch/push of all/few branches in
full/shallow/narrow fashion)
Phase 2) ref advertisement (i.e. changes in the DAG end points)
Phase 3) transmitting the missing blobs.
