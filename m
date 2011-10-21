From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: git grep --no-index and absolute paths don't work?
Date: Fri, 21 Oct 2011 08:34:10 +0200
Message-ID: <CAKPyHN138OZRt_3PT5ChuTpSEuOdybnyAj8Baqr=3OD=y==jgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 08:36:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RH8im-0001RX-0O
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 08:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab1JUGeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 02:34:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51453 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab1JUGeL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 02:34:11 -0400
Received: by vws1 with SMTP id 1so2689293vws.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=mwPzItR4LAkVbYmJb6DWzfkMb0FpkUysuB8paCjGXc0=;
        b=QkhBeOUZmpqF5nQM2ki/t+TzHVoHw1vUKYjpkhEKRbv2tXTFj1n/UdaSpYGA1xr4lH
         36DSjA2BQAQvQOtrpeoex+/zxWPc0nWi+SeCicSqG/11QvyFbrnNj7Vvls3TjL8TfsvV
         77NnE3N2FVnYeMjCWA0fXcdcHA0TCIHHUJU/w=
Received: by 10.52.92.212 with SMTP id co20mr13547262vdb.119.1319178850344;
 Thu, 20 Oct 2011 23:34:10 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Thu, 20 Oct 2011 23:34:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184048>

Hi,

I'm currently  totally confused, that a

    git grep --no-index foo /usr/include

does not work. I know that the documentation says "in the current
directory" for the --no-index flag. But this does not work ether:

    cd ~; git grep --no-index foo ~/.bashrc

They all fail with 'is outside repository'. Which is for itself vary
misleading, because I intentionally said --no-index.

Any input is appreciate.

Thanks.

Bert
