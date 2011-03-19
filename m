From: Alexey Homyakov <alexey.homyakov@gmail.com>
Subject: The way to make work with git a bit more easier.
Date: Sat, 19 Mar 2011 14:20:12 +0200
Message-ID: <AANLkTimrYGXQ_wWrj-Sr3UB9YbddW613oebddUoLat7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 13:20:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0v8k-0004kN-3S
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 13:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672Ab1CSMUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 08:20:14 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63106 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab1CSMUM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 08:20:12 -0400
Received: by pzk9 with SMTP id 9so568677pzk.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=zL+FIxfkJnshn6+bppeV591fQHzTOX3OV+ucwVhldDE=;
        b=NLNLv+rbrlx5SRT8CXCIjvmFMhY5gET03hZAqQ5icTtGexYSKC0aoszCflfdelY7fw
         io7gXAHZ/2BIOsvcp9Dmjqa1IgkaWoathdoIX5LCSwk+5z/M1RCV1DOMMz+hx+TMdjiD
         7nma9sMxE+ncpOho9W2r636cXMyspWMCdgrw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=bPQLwkE2I+8L9j7yWlpa02YpP8dOs2ccPMqRmDQDYF+34NhbAtjIyWfvNBMi4SEpm8
         ++YncmsxTizjAmXlBkSRQA4Iue03OE2Sv7FgbCJeSKRwXO2VUF0fiviSNA5HND7bh9Nt
         YBALOYDZZYmgovsV6HiMZSz/7T75GvDhD2tBM=
Received: by 10.142.174.18 with SMTP id w18mr1037858wfe.415.1300537212222;
 Sat, 19 Mar 2011 05:20:12 -0700 (PDT)
Received: by 10.143.166.20 with HTTP; Sat, 19 Mar 2011 05:20:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169428>

Hi, guys, i'm enjoy to work with git, but think it's possibly to make
one of the operation more easier.
What do you mean about mark a parts of files which don't need to be
tracked by git once instead using interactive adding each time?
=46or example using statement in comments like this:

=2E...............
tracked part
=2E..............
//@git off
=2E..............
untracked part
=2E..............
//@git on
=2E...............
track again
=2E...............


It's easy to make git understand all possibly comments definitions.

Thanx.

--=20
=F3 =D5=D7=C1=D6=C5=CE=C9=C5=CD,
=E1=CC=C5=CB=D3=C5=CA.
