From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 18/25] setup.c: support multi-checkout repo setup
Date: Tue, 25 Mar 2014 20:52:13 +0700
Message-ID: <CACsJy8DQ16xd+LOki0pxDVwPyWJ_hYLqJjW4-4VXa92yo1rD1A@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-19-git-send-email-pclouds@gmail.com> <5330469D.9020008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 14:53:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSRmw-0001EN-1K
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 14:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbaCYNwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 09:52:44 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:55369 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbaCYNwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 09:52:43 -0400
Received: by mail-qc0-f172.google.com with SMTP id i8so555202qcq.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Wik+o5Bda51cq4x0uA6GWilpaHUnjv1H1LRL6IaBUpY=;
        b=DyPQHJ5wMZ6wQ7slGHuATVOl/WoyczWijRMADfzObxh66ibX3eSgJ0F6ng77WeY3Y/
         87EumCJ2BY8pM/8vLoHSKehOGQenbZFp1j08S9DiV1B/NiRtxJq/l3+oOp+3nGM+Fu4C
         jDEw2Pe4zzeTn9wTiLOYarrQcUV5VEx9Ltwhb9Y+cvCBXY6YamuADSrtSuq611ELBjxI
         IGLXSGcK16NpYbeBNFUEKmYontakLnOkpkfmdxROgt84B3fFwX3Ig4DQc966a8eljZXK
         TUA8M2naN6sUmGD5gM5cnoTW423dnDqhCj4dkr/GPRhubGGqTqCYShTrSyCMrH1qyRNE
         miuQ==
X-Received: by 10.224.67.4 with SMTP id p4mr2394121qai.89.1395755563136; Tue,
 25 Mar 2014 06:52:43 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Tue, 25 Mar 2014 06:52:13 -0700 (PDT)
In-Reply-To: <5330469D.9020008@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245036>

On Mon, Mar 24, 2014 at 9:52 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> Did I report that t1501  fails when  there is a softlink in $PWD ?
> /home/tb/projects is a softlink to /disc5/projects/

Yes you did and I forgot. I have fixed it, running test suite and will
send the reroll soon.
--=20
Duy
