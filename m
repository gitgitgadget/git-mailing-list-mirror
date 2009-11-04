From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 08:44:54 +0100
Message-ID: <16cee31f0911032344m3263730l607c02eb4e9adef5@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>
	 <alpine.DEB.1.00.0911040031210.4985@pacific.mpi-cbg.de>
	 <4AF0E842.2010201@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 08:46:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5aY9-0006R2-S7
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbZKDHov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 02:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbZKDHov
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:44:51 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55444 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbZKDHou convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 02:44:50 -0500
Received: by bwz27 with SMTP id 27so8515629bwz.21
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 23:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=0e2tKvGrlTMS/NOmYFTE2ZV+dXYoNSGvsayj5lIWQ4I=;
        b=j72O/IceZYzPsoCQ0coAyjRrd8p49nqDfNoP2jFKMWTSKNPKkiyVH1+I2GLZadbJ01
         RsNj9mi4zKAVQSpDPZ2YaginF8HckZ6J2pFzUfOraPft1g0YsQwd1lRRy59u30fhlg8h
         pT6hEVjsjYVbHgq0RHeNIXmi4UK5gnyK/O+4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Y3wZI3EYsw9bJbTbPoKo94oK8oLjzXI477RDo5D/WvVk4f8k/OKOkZi+lnVMhrI64N
         E7mbpDgmR3ZqOUmeDIgCZAv0A3/Ysx06IwsFmCWelsK2YfFZkAWZx2DWxs92UMdX1EWv
         dosFhqKg6jZajiUxa2Rve3JCUWt40rfHUX0Ec=
Received: by 10.239.179.80 with SMTP id c16mr108242hbg.155.1257320694751; Tue, 
	03 Nov 2009 23:44:54 -0800 (PST)
In-Reply-To: <4AF0E842.2010201@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132058>

>
> Pardon my ignorance, but is there a reason to not use Pthreads for Wi=
n32?
> =A0http://sourceware.org/pthreads-win32/
>

Not using pthreads on Windows makes Git:
1. faster on that platform
2. not depend on Pthreads for Win32

IMHO that makes Git one step closer to become native on Windows, and
is a sensible step.

Andrew
