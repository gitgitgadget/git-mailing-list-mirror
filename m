From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Tue, 23 Nov 2010 21:07:24 +0000
Message-ID: <AANLkTimAxK66U1NRO7=R9Qb4r_rspNHWkkyq1L-z5--A@mail.gmail.com>
References: <AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
	<32148197.47150.1290543936407.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git ML <git@vger.kernel.org>,
	Wilbert van Dolleweerd <wilbert@arentheym.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 22:07:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL05L-0006Wr-JQ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 22:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab0KWVH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 16:07:26 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41013 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab0KWVHZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 16:07:25 -0500
Received: by qyk12 with SMTP id 12so2831104qyk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5aErucUIYKeekQqcFJy98OUx2L4njCo2NpddRNiClM4=;
        b=XE1PUBX+CmSSjpBeX27TyDu6YaFNOzz4jCXq3RggIl2zN6Dy+3Jeanz+5xgkxSl8sL
         +cOVHimjxLsRQ/gNwE8+XJynXqHAlckicODwNa8+ZsTMbEYpZkLStuV1be21BXbh5mAB
         +NeZDw9CyfUqbsqhS7iFsILA4FPgO3DGCByNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f6IjOngDLMTNxfuGqbO8RTMDY5ZaJUaDx6lUckkfUodMlIy4rrrrk7mr6i6DwDC77S
         b0O/ZFwzfFYjVLP9og9Bv6M+sPl/RAS6c+AOW13F0KgyHjaTHEosOqhrzyxmrUHCRUjZ
         ytaU0Q/O8lY/iTMXdHUSM5M98Oie2bLUT2Z+I=
Received: by 10.229.215.213 with SMTP id hf21mr6718638qcb.189.1290546444608;
 Tue, 23 Nov 2010 13:07:24 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Tue, 23 Nov 2010 13:07:24 -0800 (PST)
In-Reply-To: <32148197.47150.1290543936407.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162027>

On Tue, Nov 23, 2010 at 8:25 PM, Stephen Bash <bash@genarts.com> wrote:
> ----- Original Message -----
> We're working with about a 1.5GB repository, and while I haven't seen an specific msysgit slow downs, I did run into build issues due to Windows anti-virus programs (on-access scans, new files scans, etc). I had to add my development directory to the anti-virus exception list to speed things back up.

Yeah, the performance numbers I mentioned are *after* excluding our AV
software from that directory.

> That being said, I do most of my development on Mac and Linux, and msysgit is noticeably slower across the board for me...

Yup, as mentioned, even under the best case Windows scenario (freshly
cloned repo) I'm still seeing `git status` latencies that are x2-3
times those of Linux machines.

I don't hope to get Windows' git to be as fast as on Linux; at this
point, just making it fast enough to be usable would be an
achievement: I can't tell developers who just switched from a fast SVN
setup to wait for 15s for `git status`, an operation they perform
dozens of times per day (other operations, like stash, also take
involve long, unworkable waits).

.D
