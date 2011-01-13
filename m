From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Thu, 13 Jan 2011 11:39:05 +0000
Message-ID: <AANLkTi=3ikJ2UNNCW582CT7LQ7o2DBZ1hXJhPfMUNbKk@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
	<alpine.LFD.2.00.1101061956470.22191@xanadu.home>
	<AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
	<AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com>
	<AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
	<AANLkTi=KPVMEviQhyJeWHynPa2q6NJpQ2VyAhbRcmQ1D@mail.gmail.com>
	<AANLkTinwb8orMBjcQjK0ogXd6rMEtRwT8SV41k8D3AXL@mail.gmail.com>
	<AANLkTimkDYCL7+N-Rno1-0p3Gy6o0wYrnuStV_n5k4Hk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 12:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdLWP-0006m2-D8
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 12:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938Ab1AMLjJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jan 2011 06:39:09 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51002 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932891Ab1AMLjH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jan 2011 06:39:07 -0500
Received: by qwa26 with SMTP id 26so1684897qwa.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 03:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8GA0TnPMUsgD67IywNquqTTIPg1n679/aMvdPYULk6Q=;
        b=KJYuqqCne1vTqvgGF9USaW2yf4LwwXV/Aj2litPTXVVySXH/1bqLbH1wxrxhSGvHr1
         70VqLGZyzaBNC6yIhdpszclyEhwSz0yLMR9jaJPh0IWp0KqcD2c67UJS241b0xkqORYj
         n3FmWlcRArEm+vCyP9Lh1P1K8LgIZ+A4EJ7Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PrCoObSxnKpmNISGA/3TuaG+RfhoWormzlop427xpSr0nqeCtyPbHeqU63yQfEcDFk
         j567ZKjyHGhbHkpPc3zkaPOHka+YLoG+WGprtR6ICq0nOZR5wtUoa9yWA/U1kETH5gig
         wAS/eEABO/EonzMAOX8nDX/HdbEqGULXxuabQ=
Received: by 10.224.80.146 with SMTP id t18mr2102600qak.69.1294918745480; Thu,
 13 Jan 2011 03:39:05 -0800 (PST)
Received: by 10.220.175.200 with HTTP; Thu, 13 Jan 2011 03:39:05 -0800 (PST)
In-Reply-To: <AANLkTimkDYCL7+N-Rno1-0p3Gy6o0wYrnuStV_n5k4Hk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165049>

On Sun, Jan 9, 2011 at 5:48 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Sun, Jan 9, 2011 at 8:55 PM, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com> wrote:
>> =C2=A0you still have to come up with a mapping from "chains" to "pie=
ces".
>> in the bittorrent protocol the mapping is done *entirely* implicitly
>> and algorithmically.
>
> Given a commit SHA-1, the mapping can be done algorithmically because
> the graph from the commit tip is fixed. Perhaps not mapping all at
> once, but as you have more pieces in the graph, you can map more.

 you're _sure_ about this?  what happens when new commits get added,
and change that graph?  are you _certain_ that you can write an
algorithm which is capable of generating exactly the same mapping,
even as more commits are added to the repository being mirrored, or,
does that situation not matter?

l.
