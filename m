From: Alif Wahid <alif.wahid@gmail.com>
Subject: Re: Git exhausts memory.
Date: Sun, 3 Apr 2011 19:15:47 +1000
Message-ID: <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
	<alpine.LFD.2.00.1104021103130.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 11:15:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6JPW-00056E-4Q
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 11:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125Ab1DCJPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 05:15:49 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48645 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1DCJPs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 05:15:48 -0400
Received: by vws1 with SMTP id 1so3559650vws.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1sdfgBFLETCnRYMWsr03to71Dj6KsN45+hW9M3X+yOM=;
        b=rI5uEUHI/pRSgC+CO1eMQzOmXMYYmHe4Nur3rj3/mz/XPyQEoqAHahuhLnmbNLXvvi
         EP2Fj9wiKQL4ewjIqDa2VyMCOgWzoBl6bVkIctewp7mWiONyqc8QNe1FxnM3hZbnIoK/
         BMAPDLFNKvarSoxvqE0Y2CA9GUS4TPHdEAgXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QWDhNj21QE2ES8FVLQ1fBp7x4FW1gKBE6hXm5oA1sZ6VkiQp+5jBCjT3yU+UF9ohOb
         rw3z+abCJ/vPNim6gs55Gk+gbHeVzy+co3Wvrp6eu6U2OGS0JgxgVHaKEbnmQhje/Jdq
         PIKMEdyQ9fGj++Zb7XVV9CZOCggaMgQFiMJkw=
Received: by 10.52.179.69 with SMTP id de5mr2287309vdc.304.1301822147611; Sun,
 03 Apr 2011 02:15:47 -0700 (PDT)
Received: by 10.52.155.70 with HTTP; Sun, 3 Apr 2011 02:15:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1104021103130.28032@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170687>

Hi Nicolas,

On 3 April 2011 02:05, Nicolas Pitre <nico@fluxnic.net> wrote:

> Don't use --max-pack-size. =C2=A0That won't help here.

I've tried only --window-memory with different values and they all
failed. It seems to me as though this option is simply ignored or
non-existent.

> How large are those tar files?

The tar files aggregate to just under 2 GB and my complete working
tree is around 3 GB. Whenever I run git-gc or git-repack they seem to
reach a virtual mem. footprint of roughly 2.5 GB over the course of 10
minutes and then fail with the out-of-memory error.

Alif
