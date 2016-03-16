From: Stefan Beller <sbeller@google.com>
Subject: An idea for the "Leftover Bits": rebase -x to imply -i
Date: Wed, 16 Mar 2016 14:12:39 -0700
Message-ID: <CAGZ79kZg3QkfjB1hwZKRS9Hqg-1H=kQwuwByX_rAMzveXtnp7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:12:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIkH-0004gr-1d
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbcCPVMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:12:41 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36959 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbcCPVMk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:12:40 -0400
Received: by mail-ig0-f179.google.com with SMTP id mh10so54799421igb.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=p/wxqFh0OMu08d2QA0kKepmex+PQ/pqy76esRkyZ1WA=;
        b=nPgHpNo7sQR+WUfWhZH3JBq4/lZ0dM7zfaSXst+fjqLmoKaHLVH6rvsBANgQY5Equ1
         DyeU7UIpWArny9QlamI7vLa23etxfOBPYn1zSua6tAs3zVRSAi95h7+ELQPzp1dLxX4I
         3L6jv9DNDAGvYblMmgOfQWJRl18dayLJwL5kRe8aa687nzsvinnfYTUuYr/2pnEBcDpD
         7UuhEreo6eYIzV/3MFRMBoLTPU4qwChmWRct3Zh90sHEqZhMJgixy6ROvkxzRp7XAsUx
         toDQXmYGIGhNAkstSocywv9A//xQisRcBlokdGRnpHTwDarnTY5mWcFqKYt8uc7Fczlw
         AaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=p/wxqFh0OMu08d2QA0kKepmex+PQ/pqy76esRkyZ1WA=;
        b=jGxacffroTr4kr0VfdII+uS/hprmAdZ6tEf2DX9mjqGhMRLuBug1R54lAy4/00NitV
         hOcdnU//gQC3Y6LtCH2fqrrbAJys1ryVTyp/yj3uWpV/+VqWqXKLIy4NO1Uez8zjzyRz
         /P1/WIEBALW6YUStQMjDueK3Bz+bbb5ASsspKiQJt/d87LmYbJn5N0VgY0Cs9Jq8NvSb
         O/HlOEw9y/DrKhBxPPHoD1NifCsnR6t3HuQLKxn0ylG/+wVlBK2iTL0Bb1GsqrmyGWyK
         +Qt0i6TCSYnmXLyKmD/CSD/xT5hvNHEUAmH2bkkeT2pMtMXDlwzdT7kSkpzhtFx6CUUl
         6Jfg==
X-Gm-Message-State: AD7BkJITfBPCyr/HaWRLiMCCzXRfY+YlUFb03Y8Za8X2yZU/401Lj+VtoB6VWH/zmp6bQyZcI8UOPyIfaub16Fbm
X-Received: by 10.50.43.226 with SMTP id z2mr3759821igl.94.1458162759367; Wed,
 16 Mar 2016 14:12:39 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 16 Mar 2016 14:12:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289038>

Hi Junio,

here is an additional ideas for the "Leftover Bits" on git-blame.blogspot.com
(Is there another way of contributing these, such as sending a patch
against some
repository? Or any other way which may bother you less?)

* "rebase -exec" requiries to be an explicit interactive rebase (i.e.
--interactive was given)
  Could --exec just imply --interactive with a no-op editor? If so
write a patch for it;
  if not, document the reason in the man page at the --exec option.

Thanks,
Stefan
