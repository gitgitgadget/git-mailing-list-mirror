From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Large pack causes git clone failures ... what to do?
Date: Tue, 31 Aug 2010 16:46:58 +0930
Message-ID: <AANLkTi=1iLx=-9gxkGzuhrbpA005VPSp0itkAkOG4D4z@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 09:17:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqL5h-0001g2-ST
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 09:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223Ab0HaHRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 03:17:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54093 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab0HaHRC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 03:17:02 -0400
Received: by wyb35 with SMTP id 35so7540039wyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to:date
         :message-id:subject:from:to:content-type;
        bh=mhYvLMDlas0kwVDhViU4XUPAhP0brG87gUP2xfasW48=;
        b=rRjOGH9Y2vzSCuoqMjrfKRKcySsREqHRNz3LVFGkDlhylsSAhHjBB2aUCTCKsJFK6N
         xAcucqZsDnXfaISgntgwshDY1EM7oawugT6l4YhOFHy5PQN5CAnwhpWRxslhZ5/XAVrg
         fqd2wnqRkvhKAN2xIdJCQ/Tz2srz6yNLXq6ew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=EZah3EpNr3FKqrfD4D2Q237VO+dSDWM3vlt6zkvAhYKBE1GW/9J/TRUVIZhCeARooA
         dP8nUpj8WQTl1nlHGNbMtDBJmN4Md4uUrC6D2c7eb86vhS33d2boSzcGKBar6UFl8emQ
         1bFdta66Gpp6/WhUrTPEUBYddrEyhf2bZP8CI=
Received: by 10.216.210.206 with SMTP id u56mr5801635weo.50.1283239018163;
 Tue, 31 Aug 2010 00:16:58 -0700 (PDT)
Received: by 10.216.164.19 with HTTP; Tue, 31 Aug 2010 00:16:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154882>

Hi,

I did a "git gc" on a repository and ended up with a 4GB pack ... now I
can't clone the repository and get the following:


remote: fatal: Out of memory? mmap failed: Cannot allocate memory
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption
on the remote side.
fatal: index-pack failed

How do I deal with this?   I'm running git version 1.6.2.3

I've looked at "git repack --max-pack-size", but which that created new packs it
didn't delete the old monster. If I run gc, how do I tell it about the
max-pack size? It doesn't
seem to support this argument.

Cheers,
Geoff

--
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
http://perfidy.com.au
