From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC PATCH] git.txt: document limitations on non-typical repos
 (and hints)
Date: Tue, 5 Oct 2010 18:12:18 +0200
Message-ID: <AANLkTimxCnYqOdp9F7FBpwoua6A7PunUyjP-htko=5Ka@mail.gmail.com>
References: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, weigelt@metux.de, spearce@spearce.org,
	jrnieder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 18:12:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3A7x-0006Jz-M9
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 18:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab0JEQMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 12:12:20 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59738 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab0JEQMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 12:12:19 -0400
Received: by qyk29 with SMTP id 29so2062739qyk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PHYApQDLBrgJ4n0a0EytHjpGiCQg6/SLprNNQ3rNwQM=;
        b=X0vWw+7mSoGY2xfRmXbxFWSxpV2zmkE2L3p0EfJHbTlewDLF8P2FJuJ2+ll7F5ZxVY
         gGw4+DPFCBhnergxFKNCIXZz3vr7MvGIl8xzVeMUnsJQhJZBPVA2SypzTL/JTFsStLB4
         zr4bwDWlMK6qBM3KkKRmSLPWy1o2kh3cwOMSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tTXTnD3qVogzDZQ4MeQT6LNL+MFrnP2x9yXhI1K6x53i96RfGk5bb+VpHc5Xr/zVla
         TC2Vq4fTOgX8vIetf5hJ7iX6PBK7jpKxjkeEihmV0K86R5JmkIzPAyNcN1BJEVvNn9dK
         /T39ZxNkvFo9rYow0sC6TS0wqIS5Nq8ce/bCc=
Received: by 10.224.28.211 with SMTP id n19mr8513015qac.135.1286295138270;
 Tue, 05 Oct 2010 09:12:18 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Tue, 5 Oct 2010 09:12:18 -0700 (PDT)
In-Reply-To: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158211>

On Tue, Oct 5, 2010 at 15:00, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> +Git uses lstat(3) to detect changes in working tree. A huge number

"lstat" is a syscall, manpage section 2.

  http://linux.die.net/man/2/lstat
