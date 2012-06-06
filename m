From: David Michael Barr <davidbarr@google.com>
Subject: Re: What's cooking in git.git (Jun 2012, #02; Wed, 6)
Date: Thu, 7 Jun 2012 09:49:16 +1000
Message-ID: <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 01:49:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScPz1-0001hZ-EE
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 01:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab2FFXtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 19:49:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40567 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab2FFXtR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 19:49:17 -0400
Received: by yenm10 with SMTP id m10so5649yen.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=dxXXONGRWDPVAC6zMDv7vjV50e4itg2zZgVcIuFView=;
        b=UabxaJKBPskpGsS0j5e3EeGAVnNQX2CIt//LxJTG+dQ1FJAwCNspQaOZZFbK2UQQWU
         VPaoCYtnhCtb9xAmFo6U0pqdb4sfTv6ShNwwxnpgx4l0aXJ2ocijWqZjDrlnHOSUy0m6
         6Xa0a7Y5M6kDF7qk7F91BQYPlpeDUO3N0XameQscnGDTgL084Dv45LqN96Cd930KqW1l
         Dsl7KGp8xCj1ltPz3hwoZVKYGbdzaRyZmo1CFhlB+ApZpmG+dxiwH1JHdfZTx8AIaMGn
         MJJatSlc/JAJ8M6tO073JxhSTFiYuxcONjd7ddajGpj04pLfVp74elqx2ecEDwDJ5LSH
         ef+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=dxXXONGRWDPVAC6zMDv7vjV50e4itg2zZgVcIuFView=;
        b=OPBN9+6asmT/Uyxrn93NqWJWtXNpG8DATt4RLF1duPEbU3q0BNJMwPXDkQvIZxyc3K
         2fp4NE0h3o2mDYKCPvAplEdyFKt01GfOMSK8m/EyVcYiRr69BqHCVlUZih4XR2bKkr/E
         oBQ5F+331zMok+6HrxCW2wWR0PdUP5/kRrnusfAFa3DgRwFw9WWvJLQekP8BjvWw9505
         xJVvU5OQ9byt2/lUQ+PHYmJPHU58GXsg9KvppYVs5plc2G0cM8LMVODL7KMEBUckrHzj
         c3TanxTA5drDlAyRlRdDwwit1ejWvbb2Xr7m8V0ClMOqB7yr5JMl0RCHzoPTxgkNsMgI
         0Tww==
Received: by 10.236.126.15 with SMTP id a15mr105109yhi.14.1339026556593;
        Wed, 06 Jun 2012 16:49:16 -0700 (PDT)
Received: by 10.236.126.15 with SMTP id a15mr105102yhi.14.1339026556502; Wed,
 06 Jun 2012 16:49:16 -0700 (PDT)
Received: by 10.101.170.36 with HTTP; Wed, 6 Jun 2012 16:49:16 -0700 (PDT)
In-Reply-To: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQlZ2g0iQN9qS0zKFAiwtUg3mWN7I1e75rIGm7RwQKBvYPukKl7/aQRr9HD3c1Csw2kO9VdEhWfzFdGoFC7M329l0wl/69W2VImAFOpUFdluRtzJDnSnliMpVoB8c7IdF1k3pJjQU2HN2vi4jTlmft4lzsyHcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199362>

On Thu, Jun 7, 2012 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * db/vcs-svn (2012-06-01) 6 commits
> =A0- vcs-svn: drop no-op reset methods
> =A0- vcs-svn: fix signedness warnings
> =A0- vcs-svn: prefer strstr over memmem
> =A0- vcs-svn: prefer constcmp to prefixcmp
> =A0- vcs-svn: simplify cleanup in apply_one_window()
> =A0- vcs-svn: fix clang-analyzer error
>
> I do not know the doneness of this series that came out of the
> blue. =A0Are people involved in vcs-svn happy with this series?

At the end of this series, vcs-svn is static-analyzer clean when
merged into svn-dump-fast-export.
I believe Jonathan's comments have been addressed.

Regarding minimising dependencies, it remains a long-term goal to make
vcs-svn available to other DVCS implementations.

--
David Barr
