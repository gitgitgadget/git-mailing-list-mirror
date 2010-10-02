From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/7] commit-tree: free commit message before exiting
Date: Sat, 2 Oct 2010 20:14:35 +0200
Message-ID: <AANLkTikZ5cn8biMvMPzXz6U2J=3yg1KJXayHD-7Cx8Me@mail.gmail.com>
References: <wes62zknmki.fsf@kanis.fr> <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino> <20101002082752.GA29638@burratino> <20101002084100.GH29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 20:19:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P26gd-0001XQ-30
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 20:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162Ab0JBSO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Oct 2010 14:14:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58901 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab0JBSO4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Oct 2010 14:14:56 -0400
Received: by iwn5 with SMTP id 5so5146965iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=p3ennDof1Yq5ROufLiH2L53Pf4nulrt2XzdN+9YRgsM=;
        b=ijNw/8XH6ylrBeeYJHKYg7+/xXIxoeLxpkeQSOqDgkOvZxs+BXKC0sO8xsQDH0WWmd
         Xi0U/ZrvpJ3V3fCGXGxEpRDw023DBH6p2EtlxqBfcUi3F2FiInoHRKi7rqlL1XzqjSuT
         uCpNaDA4mDHkSn52w/2BMXgrHTz2BKwzcwW6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=o4UFz+jisDqwWycqmNGDPpOXpXC3pV4l/1XFvSG/rJ3qS3nN92E7R4I+ekIERogtra
         +RBe/V9gtGD5pkV1nB4pBzaCUvZJk/XV5lITv7v3upkulbdBG+CUDSdy854q9WZZ8xyX
         H3hRB/3vRIEyrHUCr3zmYDa8knnbZXA16Ieh4=
Received: by 10.231.60.4 with SMTP id n4mr7608513ibh.18.1286043295603; Sat, 02
 Oct 2010 11:14:55 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sat, 2 Oct 2010 11:14:35 -0700 (PDT)
In-Reply-To: <20101002084100.GH29638@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157809>

Heya,

On Sat, Oct 2, 2010 at 10:41, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> That's the end of the series. =C2=A0Thanks for reading.

Thanks, I've used git under valgrind a couple of times and always had
to resort to running 'regular' git, looking at what valgrind reports
for it, and then running my modified git, and try to make sure that I
didn't introduce any new leaks. How does the current valgrind output
look like, are we close to being leak free, or is this just a drop in
(or perhaps out of :P) the bucket?

--=20
Cheers,

Sverre Rabbelier
