From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 13:35:30 -0500
Message-ID: <AANLkTi=tT=AHWhHUw1tWT777ZPjvmTuMjDJ_orHYYN-x@mail.gmail.com>
References: <20101018051702.GD22376@kytes> <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes> <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino> <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
 <20101018172810.GA6877@burratino> <AANLkTinYpa61a=68ACSALtxuFnhGh5nGxmeD41J3e51i@mail.gmail.com>
 <20101018181336.GB6877@burratino> <AANLkTikHrCoZkJHN7Bnq4tgCTAHDfy7-92YOiV=s4VD8@mail.gmail.com>
 <20101018182530.GC6877@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 20:36:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7uYv-0001r5-Nl
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 20:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522Ab0JRSfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 14:35:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56898 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab0JRSfv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 14:35:51 -0400
Received: by yxm8 with SMTP id 8so633035yxm.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Fa4q6fe3wV1P2uc/69mvQrB2+IVhsc5Y2fkm4L4GRL8=;
        b=tWBJw+IEGBisWUfW6vjQY5WSwuT+pGTLg1GVxeQ6WafiD/V7m+utoz5ZNPjYxokSrH
         Rdweh57FwvkH9njQi04mRZfMrAkc1/KUXYh3mhRmn2b7EbiFRnKICICqwQO6/s4IM1ut
         oI8ppSAMau3biQzMuX0Xu6zVmwyxVOj/XDGWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fpdBD3wR1NZAuMcoRSPSpRl489djuE7c/M0Qhhw6Djr+ozQQ3UTLHrB+1ewAPfCSlc
         40yFngUHSbSRXeRZScPDAygqjPWOOD4KJo4bJi+SVPMxvPKj9S2uh6JT4xLnup0a7J64
         uyuR53/wxwNSSsAOIImCCa5O5BCFmRkOMOe0Q=
Received: by 10.150.177.7 with SMTP id z7mr7365791ybe.433.1287426950581; Mon,
 18 Oct 2010 11:35:50 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Mon, 18 Oct 2010 11:35:30 -0700 (PDT)
In-Reply-To: <20101018182530.GC6877@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159279>

Heya,

On Mon, Oct 18, 2010 at 13:25, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Good question. =C2=A0Ram, I think there was some discussion of this
> recently in connection with svnrdump, right? =C2=A0IIRC the suggested
> method was to use hooks or mine a commits@ mailing list. :(

Hmmm, in that case perhaps we should instead just ignore changed
history? Anyone collaborating on history can clone the repository
they're collaborating from, including all git-remote-svn meta-data. It
seems nearly impossible to guarantee that two people that clone the
same repository at different times get the same git hashes (unless we
stub out all mutable data, which is ugly and a pita).

--=20
Cheers,

Sverre Rabbelier
