From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 23:32:42 +0300
Message-ID: <f36b08ee0607171332k1da1ef77j352b31c78039d06c@mail.gmail.com>
References: <20060706055729.GA12512@admingilde.org>
	 <87k66p8jee.fsf@mid.deneb.enyo.de>
	 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <87fyh1ncm0.fsf@mid.deneb.enyo.de>
	 <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
	 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
	 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <17595.48003.145000.414361@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 22:33:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2Zlw-000848-9Z
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 22:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWGQUcp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 16:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWGQUcp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 16:32:45 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:43107 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750916AbWGQUcp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 16:32:45 -0400
Received: by py-out-1112.google.com with SMTP id t32so1509658pyc
        for <git@vger.kernel.org>; Mon, 17 Jul 2006 13:32:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QK/rROzJ4oQbt9d7ejtsfgMA4sX8kM8HLpDNncF1Fco+aYrZvtqaNOSZK3EpRhNogeGuMJwzl+FTsEJVSvluThudM/qYtuYVBvSZG/WmaqeZBUzxCeMqLyvp++SYYcmndSRyVO++d+lQ8XKQiWTswVB70/+Y2IVsdbjjfDgs8vk=
Received: by 10.35.121.9 with SMTP id y9mr4519302pym;
        Mon, 17 Jul 2006 13:32:42 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Mon, 17 Jul 2006 13:32:42 -0700 (PDT)
In-Reply-To: <17595.48003.145000.414361@lapjr.intranet.kiel.bmiag.de>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23984>

On 7/17/06, Juergen Ruehle <j.ruehle@bmiag.de> wrote:
> Johannes Schindelin writes:
>  > > > It is not Cygwin really. It's windows. You can't rename or delete an
>  > > > open or mmapped file in that thing.
>  > >
>  > > And GIT's workaround is to read the whole file into memory and close
>  > > it after that?  Uh-oh.
>  >
>  > If you have a better idea (which does not make git source code ugly), go
>  > ahead, write a patch.
>
> On several boxes I've tested the mmap code passes the tests on NTFS.

On me, it failed me on git-apply with more than 1 patches on
the commandline.

git-apply with 1 patch on the commandline passed, with two, failed.

git-apply with two patches on commandline is the simplest
testcase that exposes this problem, AFAIK.

Yakov
