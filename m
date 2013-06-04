From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: *** glibc detected *** git: double free or corruption (fasttop):
 0x0000000001fab820 ***
Date: Tue, 04 Jun 2013 18:24:59 +0200
Message-ID: <51AE14DB.6080505@gmail.com>
References: <CAKObCardgmTiuuE_LbzjD2fCmqwMHXbN-6-xZV_uUV=fjcBs3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jason Gross <jasongross9@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 18:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uju2u-00062W-5l
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 18:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab3FDQZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 12:25:12 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:64120 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab3FDQZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 12:25:11 -0400
Received: by mail-ea0-f176.google.com with SMTP id o14so364029eaj.21
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=nDvfmyAd+ZQ8Fo2r0syFOsG9fNGQ7lPb4hnLD1lQ3lU=;
        b=pGhGnznHpjyZdyKGpyqm8IMLvLoEQCOzADaTrEaCcNdZdrSHDLg59SYTKvkkHWJhpA
         lxLc6nmOAyBrf1o8rUFmlx8U6Kbsf/xYKcYzX6Rbd+lPNsKRJ89CaEaycMIKDTx6kcgi
         7hFdR2WLWzSxzBwsRblNjFSxsuDMGbED1zbRYSwX9swHQeVB0j77aWX1arIcRKJguqvN
         NnFxRERwJAVRmymdMVJ6cQaWSqo2+F9Xqt0Hk1kVNNjnGR29z2r0Y5bi5g6RX8llsqSx
         zfrO9vTHGb4QvTx1pLRx75ZlBGHEeP4l2Fsntzn5OCq6hQ1FGmtgxh1gcGHW52Ez0duO
         czjQ==
X-Received: by 10.15.44.10 with SMTP id y10mr27305717eev.5.1370363108366;
        Tue, 04 Jun 2013 09:25:08 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id y2sm92862081eeu.2.2013.06.04.09.25.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 09:25:07 -0700 (PDT)
In-Reply-To: <CAKObCardgmTiuuE_LbzjD2fCmqwMHXbN-6-xZV_uUV=fjcBs3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226373>

On 06/04/2013 05:46 PM, Jason Gross wrote:
> I get "*** glibc detected *** git: double free or corruption
> (fasttop): 0x0000000001fab820 ***" reliably on the following set of
> commands.  I'm working on a remote machine where I don't have
> administrative privileges, so I can't update from git 1.7.2.5 to a
> newer version.
>
Sure you can; install from a release tarball.  The page
<http://git-scm.com/downloads> links the latest version
(1.8.3) as well as older ones.

As for the issue you reported, I'll leave that to the real git
developers (I'm only a lurker here).

Regards,
  Stefano
