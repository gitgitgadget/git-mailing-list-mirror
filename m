From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCHv7 1/6] commit: helper methods to reduce redundant blocks
 of code
Date: Tue, 2 Nov 2010 18:42:10 -0200
Message-ID: <AANLkTinX=aSm-Dh2jDuxLdXk90528v5BdbnLsTyaHYD1@mail.gmail.com>
References: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
	<1288727952-57498-2-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 21:42:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDNgR-0001kI-0z
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 21:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab0KBUmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 16:42:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38023 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab0KBUmM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 16:42:12 -0400
Received: by bwz11 with SMTP id 11so5923047bwz.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WOJO+ACTQylqVCKfPs8wKAn8tFREZRxCkIePukc7GYA=;
        b=MwNPYFTsDf8HB/rekJucfN6htZrNKdcq1k08/4A5TdXAiAB95G9U/j7NjftnzPOAcD
         ZNe1Jinz7xU761zBd/H1gKQEkN3tnMXBqk1aT65IHECUPiR2CfWN+8LjauMFyj/uYksK
         kMHsTjZkOy+9DXzgRI6VFAMtAXixxHQxSa2mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SU5r0IYNocat+b3GNDt29a1r9lsINOHHoKXstvWszloYxizPrPa1B+W7bFPLd7wPz3
         qSnnm7bODE5N6IT62rHQbvcQl8Vx5Ff+NhVnCYIt7+IoALN4vEo96afzqWUV+Mjxo1YI
         zfymnXtdWiOIXe0DKFJuLQjYpaiGaMmmZzMdQ=
Received: by 10.204.69.200 with SMTP id a8mr14901289bkj.36.1288730530919; Tue,
 02 Nov 2010 13:42:10 -0700 (PDT)
Received: by 10.204.69.206 with HTTP; Tue, 2 Nov 2010 13:42:10 -0700 (PDT)
In-Reply-To: <1288727952-57498-2-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160553>

On Tue, Nov 2, 2010 at 5:59 PM, Pat Notz <patnotz@gmail.com> wrote:
> * builtin/commit.c: Replace block of code with a one-liner call to
> =C2=A0logmsg_reencode().
>
> * commit.c: new function for looking up a comit by name
>
nit: s/comit/commit
