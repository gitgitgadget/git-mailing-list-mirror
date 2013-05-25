From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Sat, 25 May 2013 17:21:38 +0530
Message-ID: <CALkWK0=X9Q-8ukD2PibMJzYURV1-6i0J8rQcD4iYZb2CtmPeCA@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <1369405177-7855-2-git-send-email-artagnon@gmail.com> <CAJDDKr5==LhBCWrPNv89w3T7dXueYfUpY-zykEXkt_VLDsQhww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 13:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgD1L-00040C-O1
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 13:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab3EYLwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 07:52:20 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:51340 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab3EYLwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 07:52:19 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so14526486iec.20
        for <git@vger.kernel.org>; Sat, 25 May 2013 04:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zM+kRkSq1RSVf+K7Ib/iJosuQzZQeUWSpIx9E3BW2TY=;
        b=EkMLNOoPKSHbBNdoC383/daQStaIxhoKbgoqOQhcquvXyuLZuK3pPoF0apBY8r0Ro0
         Dr6KRLsadFHghL9hWrNHci8aeXTzshvVlb0TZp0qOUjogFDDMdL84dB0yhMYrG92BZYr
         eSpu1IQ+9d+8VARuKpMt2r1WIUohuQhma7P1qs/AlnQcm8KGAnbUnl3vgfPstja6WRoA
         nLCJFhCslbAfoPLbRq+5kafC7ZRwQ+5JsdbTBsPM6v5/d0kM3h3ptFcZe9mcylXIJLZI
         ROep6N4tnvwPKqfNtORwb3hAxJK7Iz5JODqfWGDNudfPyp5HiLmiHSiHmQ8zmxZCVpSc
         cQRg==
X-Received: by 10.50.66.140 with SMTP id f12mr1478611igt.63.1369482739037;
 Sat, 25 May 2013 04:52:19 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 25 May 2013 04:51:38 -0700 (PDT)
In-Reply-To: <CAJDDKr5==LhBCWrPNv89w3T7dXueYfUpY-zykEXkt_VLDsQhww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225523>

David Aguilar wrote:
> Can you please also update Documentation/?

Yeah, will do in the re-roll.  Duy is bringing in pretty-formats.
We'll probably need a separate document called pretty-ref-formats or
some such thing.
