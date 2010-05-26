From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] commit: show abbreviated sha for commits with empty 
	diffs
Date: Wed, 26 May 2010 13:39:20 +0800
Message-ID: <AANLkTinio71lh1y65IW7FKuVFI3PKPPyGc8LNTOT6yqt@mail.gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
	 <1274694452-4200-2-git-send-email-rctay89@gmail.com>
	 <1274694452-4200-3-git-send-email-rctay89@gmail.com>
	 <1274694452-4200-4-git-send-email-rctay89@gmail.com>
	 <7viq6bqmid.fsf@alter.siamese.dyndns.org>
	 <AANLkTik_R4U3SvUwLR1nFZhszhmVC8SCmp0JhjGFbUsO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 26 07:39:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9Kx-0003pB-MJ
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab0EZFjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 01:39:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52662 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab0EZFjW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 01:39:22 -0400
Received: by gyg13 with SMTP id 13so2554902gyg.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JhwTPmonW8W/b/tx+aD68E7wcXpG51OLkEAq2MbOG70=;
        b=HNCqf6pt0RgAAKo+4wSd7m4ddRzXJDAMIAxDNNPgkVrh9+sfu4KrEF8DyTxGVxLj0L
         RRqoMVjb+ZKZtDPM8cKXiNgKaIWpAoC7o+/zRxJot/9mN7mGBMhmSen1m9PSsM8gbFX2
         QdX0SWOIlUTnqDf66E+zPfgJr9eYJzk4Ca1gY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iwsDTdOcT2qOSojvvznhKRuyuQ4skkxqmbg3u+Xj+k/8MAJT7cWi7XDxWm/9OxI5T2
         HyyrjTRH1Qv/pWn3v/jnv3la9MHwoCBpSrRm7GcrldVJTlUnlOQ+E7RC3ltG6nHPiCUd
         e6S3ixzV51NLqdUgVuNHfJIVVkTE5lBa4joLE=
Received: by 10.231.168.129 with SMTP id u1mr6654145iby.49.1274852360231; Tue, 
	25 May 2010 22:39:20 -0700 (PDT)
Received: by 10.231.33.12 with HTTP; Tue, 25 May 2010 22:39:20 -0700 (PDT)
In-Reply-To: <AANLkTik_R4U3SvUwLR1nFZhszhmVC8SCmp0JhjGFbUsO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147745>

Hi,

On Wed, May 26, 2010 at 1:37 PM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
> Hi,
>
> On Wed, May 26, 2010 at 1:07 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> The fix itself might be trivial, but the series seems to break 7502.=
20
>> and 7502.22
>
> I tested this patch series on top of:
>
> =A0- efd1311 (Merge branch 'jn/shortlog' into next), which contains
> =A0 c197702 (pretty: Respect --abbrev option), the first offending co=
mmit
> =A0 to print un-abbreviated SHA-1s.
>
> =A0- b26ba11, the recent 'next'.
>
> It both cases, #20 and #22 passed fine.

My apologies - I've already squashed in a fix to address that locally
and I haven't sent that out yet.

--=20
Cheers,
Ray Chuan
