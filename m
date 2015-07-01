From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 6/7] pack-protocol.txt: Mark pushee field as optional
Date: Wed, 1 Jul 2015 12:31:07 -0700
Message-ID: <CAD0k6qSsNHTVktgQFvhHmOXMMd7xZ1=7=ukGVmGmWuaw0DXp6Q@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-7-git-send-email-dborowitz@google.com> <xmqqbnfvaeqk.fsf@gitster.dls.corp.google.com>
 <xmqqy4iz8zon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:31:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANjI-0000xq-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbGATb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:31:28 -0400
Received: from mail-vn0-f51.google.com ([209.85.216.51]:41299 "EHLO
	mail-vn0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbbGATb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:31:27 -0400
Received: by vnav203 with SMTP id v203so8070281vna.8
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wD0CBnzYT/EHehcDfGVpKxrLFKIU1+tDGskaUM4pp1w=;
        b=j5WA8/xkUzbtp3BubUFkgDi2OS1ij2Q99dezpP9sklx+wdSQR6MJq4dcdA5OU4L0UQ
         Vg77zDyRT0pTcfS5flAO87yAGQ0tagfCX1crL2X//LZlKDi9IQqaDf7/kNY/RhjN/Ojm
         buTAjc4Al+8LfUzoIpgQ4Pucg3LkwKfzEmaPEcG9SVNat6WoRwyZ/BpYwMcai1ZZeau4
         F7lzUp5BtJdUCdWUBaymwNloic9mMb/oSOqo4Iz/HK0ixyRmEBiN5UU3lGNBhspWt6ja
         Ug35inQ+9Cb2nzNlaTQn3xl79s6/8vK2RFRybEeTHTOQY5xGx8ECiLHq6s7w0N4so7O8
         2SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wD0CBnzYT/EHehcDfGVpKxrLFKIU1+tDGskaUM4pp1w=;
        b=f57GDIpiYZPrs01k42DeAwP5dGJNbCVZlRCK1Nguhbyury+zdCHDNqAHjeODsQ9d7e
         yHSBkv79zsLQewqi07n6++b7W2DSas61xDbs6jShXm8mE8MVV9P12ZdhLgh7xi+qrX+x
         ed6E6jLLi2HBnJdvfCip0MIhVjzpP7KrYiTMpzonMpQhAbpQ1jAem86M8WmTlOjI0fOj
         zMA3YsjR+Hb23JUeTMRr4E5m2xIF+pMiJWsuLPXZvlB8KvMpjKZxDPniecvny7xL8z9h
         JDjwmX8TFtMbL89Pd5tasRnhXwBV0sMieEnbBDySAQV1fmPp93VTu93SPFOyNdvR7dyU
         qGiw==
X-Gm-Message-State: ALoCoQnk9GzGx3RZxVM/4cFANVmz+12GEvKawjdeIUyuPjZrbUH7utBtCRTd6Bmp8wicJZvEu0Zz
X-Received: by 10.52.251.107 with SMTP id zj11mr27128968vdc.96.1435779086690;
 Wed, 01 Jul 2015 12:31:26 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Wed, 1 Jul 2015 12:31:07 -0700 (PDT)
In-Reply-To: <xmqqy4iz8zon.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273190>

On Wed, Jul 1, 2015 at 12:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Answering myself, the most trivial example is "git send-pack" ;-)
> It passes args that has a NULL in the .url field.

Well, the example I have involves an actual "git push" command. The
fact that .url is NULL in that case may be a separate bug.
