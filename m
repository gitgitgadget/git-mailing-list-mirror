From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 13/13] tag.c: implement '--merged' and '--no-merged' options
Date: Mon, 17 Aug 2015 01:06:16 -0400
Message-ID: <CAPig+cSvHOFdM06PjsdLjsYenZdrijBqdZTYAjEv5w5qDt=_1Q@mail.gmail.com>
References: <1439661643-16094-14-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 07:06:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRCcz-0000R8-Cx
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 07:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbbHQFGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 01:06:19 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33323 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbHQFGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 01:06:16 -0400
Received: by ykll84 with SMTP id l84so53131402ykl.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 22:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=V9picLrVK87J6bs9vb863v1xtUdY6JH2tCxSPG4a7t8=;
        b=oshIAIhbgfci9z3idF506N3PcCZIA/T6yLbgCO24Sq7uICaR3yndSc36M1oimS0Aka
         W3CT9mSAk93di1BNWaRtWh2J8OeUziqi8oSkZ6+ubK5ZbSoLjWiG0gxgkBfvPfig+T/R
         22K13U8AgV/iGGaORB3foULNKF84VgquXO6c5DCr3v19WNfzFTbJMyRrzbh6qGTcapkH
         Fi7QenNbgSh9ezlMxKLBtJpqMZTwxWm4Y+N8iKQmuG+XCQdhyzDZBCYgj6kEyTymhIvh
         YQho0MstW9HtxnlaIsRRlklUETxORdO2i5V5VoDKcvcYgcp+uxfSDMAJe9td6h4Zdf+z
         BP+A==
X-Received: by 10.129.92.8 with SMTP id q8mr3469901ywb.163.1439787976119; Sun,
 16 Aug 2015 22:06:16 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 22:06:16 -0700 (PDT)
In-Reply-To: <1439661643-16094-14-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: jTBJ0gT4PQBN6YMwKLewEBAAyME
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276031>

On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Using 'ref-filter' APIs implement the '--merged' and '--no-merged'

s/implement/to implement/

> options into 'tag.c'. The '--merged' option lets the user to only
> list tags merged into the named commit. The '--no-merged' option
> lets the user to only list tags not merged into the named commit.
> If no object is provided it assumes HEAD as the object.
>
> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
