From: =?UTF-8?B?Wm9sdMOhbiBGw7x6ZXNp?= <zfuzesi@eaglet.hu>
Subject: Re: [PATCH v2] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 15:16:18 +0100
Message-ID: <9ab80d150912100616u58391fe3k1f1e921b23417abc@mail.gmail.com>
References: <20091210133645.GA2149@coredump.intra.peff.net>
	 <39e5cb38658919ed989f954a0917dfaa292f6350.1260453234.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 15:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIjof-0001it-ED
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 15:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759503AbZLJOQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 09:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758953AbZLJOQN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 09:16:13 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:58009 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758898AbZLJOQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 09:16:13 -0500
Received: by bwz27 with SMTP id 27so6095975bwz.21
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 06:16:19 -0800 (PST)
Received: by 10.103.78.38 with SMTP id f38mr3901837mul.72.1260454578860; Thu, 
	10 Dec 2009 06:16:18 -0800 (PST)
In-Reply-To: <39e5cb38658919ed989f954a0917dfaa292f6350.1260453234.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135032>

2009/12/10 Michael J Gruber <git@drmicha.warpmail.net>:
> Zolt=C3=A1n, I don't think we should make this into a race. Posting i=
n
> the relevant thread (and actually following it) would help this.

You are right. I've deleted the feature request mail, and then few
minutes laster decided to create the patch. So I've lost the message
ID (though I could retrieve it from the web...).
After posting the patch, noticed that you also posted one.

> Also, I think we should really compare the sha1 the tag points to,
> i.e. like below and like in your v1 (not v2). Different tag object
> is different tag (message may differ, e.g.).

I agree.
