From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Mon, 23 Jul 2012 20:27:01 +0200
Message-ID: <CAD77+gSRXu1hLRs0AN3z8aUUsFE-=3pmHTBaOKz7UUZ=m4bS9A@mail.gmail.com>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com>
 <7vsjcjnjvj.fsf@alter.siamese.dyndns.org> <CAD77+gSa7FJuQSBRC02CqEPakbc9cNJDRWxCrYX8ZjB0wL_Syw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNLr-0007o0-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab2GWS1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:27:23 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47774 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab2GWS1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:27:22 -0400
Received: by vbbff1 with SMTP id ff1so4977959vbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uFedi9Ympd85l1OVlZM77YvvR2u5++Km/Fi7DLHRW7o=;
        b=d1qc9LRBnlvjfxP1HwLk6lDHIRRqswkS3VWBeMorH/hGAgcm1VJHRuN9+5YXyblc19
         E9d/yH84E6fmWqD5F8takoJAvtLk/TGqyM559Agn6O0EdEqZFN9x1Py5YuVyFTvI9Dfw
         qOyHnzhdfqEfi+U8cKaQPmOjXD7nkTvk9Gnzq22tMcUTLPxANSiLV6l/aDhXS+1Sqqz8
         niotdVIAbN4THvyj3xHZuK91rs6uqFu+AETh6r+6i3LYIwNIsT1TXNDXmXn+3+qSjacD
         8s4i5r7TKjfNPk1sB3Znz/YySviK+UbDKYq0bYU369PMoHEzZLpIuMbv6c7XxWTeYPBu
         LOzQ==
Received: by 10.220.116.79 with SMTP id l15mr13313458vcq.69.1343068041687;
 Mon, 23 Jul 2012 11:27:21 -0700 (PDT)
Received: by 10.220.152.18 with HTTP; Mon, 23 Jul 2012 11:27:01 -0700 (PDT)
In-Reply-To: <CAD77+gSa7FJuQSBRC02CqEPakbc9cNJDRWxCrYX8ZjB0wL_Syw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201950>

PPS: Yes, I know that I am replying in a patch thread. I will try it asap.
