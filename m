From: "seventh guardian" <seventhguardian@gmail.com>
Subject: Re: [bug] git-clone over ssh fails when repository has local commits
Date: Sun, 6 Apr 2008 20:02:41 +0100
Message-ID: <1caff7430804061202x1370d34aw41bf082c8fd4bd64@mail.gmail.com>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com>
	 <20080406161120.GB24358@coredump.intra.peff.net>
	 <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com>
	 <20080406165655.GA26060@coredump.intra.peff.net>
	 <1caff7430804061011ye82e74v289dd3536b253bcb@mail.gmail.com>
	 <20080406175136.GB32399@coredump.intra.peff.net>
	 <1caff7430804061106m49a60bc0wbbd9001394e83589@mail.gmail.com>
	 <20080406181749.GA2218@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 21:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jia9f-0001Ru-IC
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 21:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYDFTCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 15:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbYDFTCn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 15:02:43 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:45386 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbYDFTCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 15:02:43 -0400
Received: by el-out-1112.google.com with SMTP id v27so713622ele.17
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OOMYwxxD2p0PPrm0IDlmDguNwpWhS0gTpDi0Qu1H3uo=;
        b=r9ge7w+NMVPoKCbKis88cNo7riRjj13jcS930QRKXZLxtZPU2MyYC/V85AWiBzSfrpdW9KkQb17dlj7Xu9bCEP8B4q68epEy5JDloQTm1sTEJkbx7Z5lH36EconENCK1DlJrs7Hc9UApKh6RCDMNPqrutq4NH169YwgQ9kln4Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=caCO8MHfv6ioahgnADpGfBfXLlUArKroa1vLS6WiPzfb8kFSoAJPLTbHN3pPyoG0c0QlWB+p+eyVtW9mkQI+bSbRXlROzGOP67ijJ06N6X/RLnEb5tYsKMqSzSob1J0iD/lBRrylST76ioyEGcZflgU14wKTlbTr/wvGvACSSCU=
Received: by 10.114.61.12 with SMTP id j12mr1913967waa.151.1207508561621;
        Sun, 06 Apr 2008 12:02:41 -0700 (PDT)
Received: by 10.114.126.18 with HTTP; Sun, 6 Apr 2008 12:02:41 -0700 (PDT)
In-Reply-To: <20080406181749.GA2218@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78914>

On Sun, Apr 6, 2008 at 7:17 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 06, 2008 at 07:06:40PM +0100, seventh guardian wrote:
>
>  Can you give an exact set of steps to reproduce? There doesn't seem to
>  be anything wrong with those repos, and I was able to do:
>
>   m1$ git clone git://anongit.freedesktop.org/git/nouveau/xf86-video-nouveau/
>   m1$ cd xf86-video-nouveau && echo foo >>COPYING && git commit -a -m foo
>   m2$ git clone ssh://m1/path/to/xf86-video-nouveau
>
>  So now my guess is when you make local changes, something funny is going
>  on. Can you describe that process in more detail?

My process is the same as yours, except for the "time-torture" the
repositories have suffered. Surprisingly, everything worked on a fresh
clone. So I suspect my "local master" repo's are somewhat messed up..
Will try to investigate further.

Thanks!
  Renato
