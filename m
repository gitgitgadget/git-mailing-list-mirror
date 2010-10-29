From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 00/42] repo setup test cases and fixes
Date: Fri, 29 Oct 2010 10:04:40 -0700
Message-ID: <AANLkTikJJnTXfWXKe5bm_Qyjmgna9g3vChdkPzoiAb4i@mail.gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 19:05:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBsO4-0000nz-Vk
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 19:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407Ab0J2RFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 13:05:04 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63012 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab0J2RFC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 13:05:02 -0400
Received: by yxk8 with SMTP id 8so1778360yxk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=c/OIir1XVnn03EqmPzqruvtADj/H4rw/dlbCQYrGmeY=;
        b=nvrXRe8eIQuxbj1DsxRTPMiQSulHdjdJ8KR+AbFrihh0pyWR97mbj/m+RZJtb+lLw6
         RSg0+JYiYodx9zlRmtSCGAVmSL2XLR3paThfoBLjnE6ulDelNPNkBfLN8iNvEaSKVjns
         LQD7kbrkmiCr1uptWU9KPNvWKiSB1Oitx58TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=M4fomue/TXnlDoRPcM0GhcseZmAKwJjdEW0X7bhUgequiLNW3DJb7QoE36O1dwiN6f
         vBx4TpEXS9RhU8KzZIboTP3KOv6QqPolWS1QE5jr/s/IPoCtY46YvMVgyrDbcTlwYcaS
         rNfMB+MsXSlDNSwYhgWopnxoFc+dW3NHAFVXw=
Received: by 10.150.177.7 with SMTP id z7mr10274678ybe.433.1288371901364; Fri,
 29 Oct 2010 10:05:01 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 29 Oct 2010 10:04:40 -0700 (PDT)
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160340>

Heya,

2010/10/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> This series includes setup coverage tests (180/376 fail). Then the fi=
xes,
> which bring down to zero failed test in the end. 02/42 describes the
> rules. New rules are:

Shouldn't the fixes come first (for bisectability?). It don't much
like the idea of the test suite being horribly broken for a whole
bunch of patches that someone might end up hitting while bisecting.

--=20
Cheers,

Sverre Rabbelier
