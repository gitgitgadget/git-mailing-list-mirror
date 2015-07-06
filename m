From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 11:27:13 -0400
Message-ID: <CAD0k6qQyhMKe7=gzuPt3QwDEvX1ovr72aHnGeAHnf1=LffqF-Q@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAD0k6qTDpH0H-k9h+f3X8PjXpOZ7tRzv+8wvi8HALhg9DDm4Ew@mail.gmail.com>
 <CAD0k6qSJeNBX=kmo4dn-=SqHGottXT2PJfpCD=y_SKNwEMDMyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 17:27:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8J1-00052x-09
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 17:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbbGFP1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 11:27:35 -0400
Received: from mail-vn0-f48.google.com ([209.85.216.48]:38500 "EHLO
	mail-vn0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbGFP1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 11:27:34 -0400
Received: by vnav203 with SMTP id v203so4871611vna.5
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wyZwZGhXFGTUnS8Obrmvg0AmhmZuMHhuWRmNI07dS8o=;
        b=H8XGw9/Cid9QvzeiADfCan8T2XQM+ArfzZZa5UNBbaoRxEiV1Hn6cD54FSc7mbECrw
         6hvcJVdeCVXbU8zO6b6wZe17kPdPCxVBREk2z7QT53mEgETs7eonFdmxYEhBbFlkCfbs
         cWac/ofr8riw3GsSTNCsRe1BuzTOuy0aPWAcpXE/ZhXzFSPcE1TfY6IrKIS7NJExV6kb
         pdlbmWZKunRwkXXGZB1xq35ge44wpwtpYU+fTDveEC33Zzvr3TqDr8LQYyds/1zZJd8x
         WrrUMj7kijSEZn7qemtom8sejVDioT/kl1hNEIVxrXFfqHdVmRY9YXx5RdIGB5sQgfMp
         WbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wyZwZGhXFGTUnS8Obrmvg0AmhmZuMHhuWRmNI07dS8o=;
        b=PN97mmMQcdBozsT0KPp5NMWPmEALRM2rqcMES9Jh6udKXDE2wxRGGPlQG9OrH3Zi+j
         jzNspfTlNJaeb8Q/Q2clwmJvwjzx4rcpQ6vl6WDBB6NL9peT4Ti7bgUt8v4Bz4FDCkG/
         TOGLIzRwKh46/ciqcxlibLZKYsAkNcpA/Jc6p7ML6xW8NM+9XPPLmauiQm2ol7jbHYAj
         LZNLL/VFCVlxYAfO6b/sk+drP6qY6gy/k3NA8zDXi6xD5yGRmBOYtTOmW4aBk0ZQtoOz
         LbTp/YFUCfVd9fY/BSpsfTZ87IGjvdw7j0gDfVl1H/p1jiNMnFNzsmMrlG7vhjKTK/t2
         l7kg==
X-Gm-Message-State: ALoCoQnvuZwYn1fpb2OxgFnM2AkcaHcvM7sNVIL+OxomDxdr500c291PRkvwnuNf0bcgFIRsRuZ9
X-Received: by 10.52.251.107 with SMTP id zj11mr50576741vdc.96.1436196453104;
 Mon, 06 Jul 2015 08:27:33 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 08:27:13 -0700 (PDT)
In-Reply-To: <CAD0k6qSJeNBX=kmo4dn-=SqHGottXT2PJfpCD=y_SKNwEMDMyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273387>

On Mon, Jul 6, 2015 at 11:22 AM, Dave Borowitz <dborowitz@google.com> wrote:
> b. Write a parser in some other clever way, e.g. parsing the entire
> cert in reverse might work.

...as long as " " is illegal in nonce and pushee values, which it may
be but is not explicitly documented. I still have no desire to write
such a parser.
