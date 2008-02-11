From: "Henrik Vendelbo" <hvendelbo.dev@googlemail.com>
Subject: Git over SSH
Date: Mon, 11 Feb 2008 12:38:32 +0000
Message-ID: <9732aadb0802110438s2a102c8cxd4eb4d0dd9595d52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 13:39:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOXwT-0003Nh-1s
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 13:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbYBKMih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 07:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbYBKMie
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 07:38:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:17741 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbYBKMid (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 07:38:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2149817wah.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 04:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=I09+IKBOwnu/y/i6ffzOaEmMEVsm1zLAZSVryIxZqj4=;
        b=gnS2wUvKTPCw0z7FFqnEleNXuMLlAf5Ymp5b7UN51tJlaq/KIhQN0WLlZ11812qy1oOvWe4PdpAUkZjkmMXfTTlVAFG2hbbUu1P1fck8fyNCY4szqI4AT/cDnoezPhQzKIoW9Hvtw2wFeVI58JtIo7Qo6MuD3k7dEDiP+PvzOkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZF4kgclkJ9KpEcQSSSJsrcrDuADMhLlttHZyo25PGTwDyPRj8Cu4UWW1yykfzfLVgzM5pviUHR80QptJAm2/TEEfu2opsOBYMAXhEgp7ALaznyKHBf+n59yH/uJGzzMAvDrDVC5ZLTv301c1l5JsS0IGL6pvWkT1WI4924vJUd4=
Received: by 10.114.169.2 with SMTP id r2mr4247792wae.30.1202733512761;
        Mon, 11 Feb 2008 04:38:32 -0800 (PST)
Received: by 10.114.199.18 with HTTP; Mon, 11 Feb 2008 04:38:32 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73523>

I seem to have missed something quite crucial. After many weeks of
using git locally on two machines, I still haven't managed to
synchronise over ssh.

I use Mac OS X Leopard on both and have no problem ssh'ing between
them manually.

Why I try any of the examples in the documentation I always get a
general failure with some command not being found.
The last one missing was git-upload-pack. Thing is though from a shell
logged in as the same user, I can execute git-upload-pack on both
machine, np.

So is it MacPort of git that is somehow broken?

Thanks,

Henrik
