From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v3] completion: ignore =?utf-8?b?Y2hwd2RfZnVuY3Rpb25z?= when cding on zsh
Date: Thu, 9 Oct 2014 07:34:30 +0000 (UTC)
Message-ID: <loom.20141009T093007-811@post.gmane.org>
References: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com> <1412804988-56858-2-git-send-email-bt@brandonturner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 09:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xc8FJ-0003cV-SZ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 09:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbaJIHen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 03:34:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:47644 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbaJIHel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 03:34:41 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Xc8FD-0003au-S5
	for git@vger.kernel.org; Thu, 09 Oct 2014 09:34:39 +0200
Received: from 46.19.18.182 ([46.19.18.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 09:34:39 +0200
Received: from oystwa by 46.19.18.182 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 09:34:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 46.19.18.182 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:32.0) Gecko/20100101 Firefox/32.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Turner <bt <at> brandonturner.net> writes:

>=20
> Software, such as RVM (ruby version manager), may set chpwd functions
> that result in an endless loop when cding.  chpwd functions should be
> ignored.

Now that it has moved to the zsh-specific script you can achieve this m=
ore
simply by using cd -q.

=C3=98sse
