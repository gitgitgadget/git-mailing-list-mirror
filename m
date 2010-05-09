From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH 6/6] Add test_harness make target for testing with 
	prove(1)
Date: Sun, 9 May 2010 13:04:30 +0200
Message-ID: <q2pd2d39d861005090404w41710d82nd9b2570f79931d00@mail.gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
	 <1273261025-31523-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 13:04:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB4JJ-0006CC-Eq
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 13:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab0EILEc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 07:04:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:18272 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab0EILEb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 07:04:31 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1256941fga.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=j3dZZRv89hYla0x8z7woHd7Yk5jahgVC9F3Z/xdEU0k=;
        b=OGJe1c/rdmkxtaa6ADax3ZexmqDqBhXghKiRgRbgH5XtrDQ6IMmSMnxRTqCfinW5DB
         dX4yhdbHfsfsfkkbNBlpZVylH8m0fG5Kc4iaPpyPB673pQjimvEtXZfd9lc5qP+wgMyV
         H7dzrYvtQNHtARBarhYg11cjxfMzt8FeNPtL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ESPUdPxmdZbeusfqhgkuwsGvsql51i2NGYczz0l2JzDtSfNFjNqhK+hZ4VpSrnO6s+
         /7a3yf4QGn/iy16QMLuwhuDtAnsy4MTCgTsZY5lM76D7wJE0gQImV/HfjI2Uaqp312hw
         VlNgs6FZnZfdP0sCgTgdcMQUwVdQk03qC7Ap0=
Received: by 10.239.130.209 with SMTP id 17mr7490hbk.200.1273403070071; Sun, 
	09 May 2010 04:04:30 -0700 (PDT)
Received: by 10.239.179.197 with HTTP; Sun, 9 May 2010 04:04:30 -0700 (PDT)
In-Reply-To: <1273261025-31523-6-git-send-email-avarab@gmail.com>
X-Google-Sender-Auth: bc0276ce63bc8b23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146720>

On Fri, May 7, 2010 at 21:37, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gma=
il.com> wrote:
> The --jobs option I'm supplying to prove(1) is not supported in all
> prove versions, some older ones (before Perl 5.10.1) don't have
> it. Anyone that's hacking Git probably has 5.10.1, [...]

Not on the platforms I'm testing Git on. (The non-Linux ones.) It's
troublesome enough that parts of Git itself requires 5.8 or later..

>and you can always use the old `make test` for non-parallel tests.

If tests still can be run.. ok then.

-Tor
