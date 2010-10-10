From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 12/14] mingw: import poll-emulation from gnulib
Date: Sun, 10 Oct 2010 16:28:40 +0200
Message-ID: <AANLkTikR4FMK31oJP24B+9QxLypSbO7PL8G5vEtUp=my@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-13-git-send-email-kusmabite@gmail.com> <AANLkTim1BZR89M22tAkT0qtfk70QeN0QuyKi5Q2KQQKR@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 16:29:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4wtk-0007Rg-Ue
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 16:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab0JJO3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 10:29:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37594 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab0JJO3D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 10:29:03 -0400
Received: by vws2 with SMTP id 2so466579vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=B78FyyV8I4S53x70KOPgMTQwMI0FfCT7i+z7TENgZY4=;
        b=jy1H6uEi37IpZCyZhv4nU1sEJOwj7Ylww1/r39iaaZOCyWPv0CiKoitCvDTQk8ojnR
         OkD69Kmw8+igEOT9WmH9wWJ3xkwXBbywHwn2Ftp+6upbsxacJYUUUkFPkwnH90YwaAfA
         6WmRPUUpuVcPx5KcGcaj9q8eNF33C1DN8M0vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=hPElkVuCPt2ZWLas+8d7jHtN4ot0n3a/Jg7rl435zPVAYl/jHSXI+JT2y3NaFgF3vl
         VC+ZWLNSbkUf5Lyh+5doApb1V7JysZdqQbgCcy62bX5RebdQe7C6AvhS7Rhn/RpCLFeK
         CoitcLwZkIKVodDY41wAQH19p8PhBHM8qDzAY=
Received: by 10.220.187.141 with SMTP id cw13mr1561006vcb.38.1286720940895;
 Sun, 10 Oct 2010 07:29:00 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 07:28:40 -0700 (PDT)
In-Reply-To: <AANLkTim1BZR89M22tAkT0qtfk70QeN0QuyKi5Q2KQQKR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158675>

On Sun, Oct 10, 2010 at 4:15 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Oct 10, 2010 at 13:20, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> lib/poll.c and lib/poll.in.h imported from 0a05120 in
>> git://git.savannah.gnu.org/gnulib.git
>
> Having fought with importing things from gnulib myself using their
> tools it would be useful to note in the commit message *how* you
> imported this. Did you use the gnulib command with some archane
> options so it wouldn't touch the build system while it was at it, or
> did you just copy the relevant files manually?
>

Sorry if that was unclear - I just copied the files (verbatim).
Patching to make it compile for us comes in the next patch.

I didn't even know that there was a gnulib tool to extract code, but a
quick google-search shows that there is. I'll look into using the tool
instead for the next round.
