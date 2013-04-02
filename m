From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] test-lint-duplicates: check numbering in contrib/remote-helpers
Date: Tue, 2 Apr 2013 19:10:27 +0200
Message-ID: <CALWbr2y2Nh7HPEXHiezoWqp5s28ct2H2-Z2xCXS4dc-VaNdJ8Q@mail.gmail.com>
References: <201304021853.48643.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4jb-0004C8-RB
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761959Ab3DBRK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Apr 2013 13:10:29 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:56851 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761846Ab3DBRK2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 13:10:28 -0400
Received: by mail-qe0-f53.google.com with SMTP id q19so348229qeb.40
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=L2cs9DGcNUNu0EyNscAiVMLizKqh3bAlveFm6BNJiRE=;
        b=CTgyvrIRSNqA6F2ogZ6S+G4U6HIYGNBQjUeLUKPkVQ/eBhORZ+ooUjHP4/Fr7zI2ON
         +s8wvtZNaGobb32DdkPzqgFL5Tt5NECh+q4Xkw/AIXr+CRYCAssay1pcVTFSZiju/Ikm
         f4nRUg5Wvpv7D4lnsAmEGLhgw7gWPbBhvdixtuZvn1SPiZalSS6DCmsYc4aowcQj++Da
         YiJ2L7XQLcHs0/10jzeJix+BsDFDHC6NUATdVOAgMJIsmtI0kRIfnvd8vKk7Ylogb+A2
         EX07ej6SHI7wUsmSu4Hw7KRQOnsrrzxw4M/ni0uSEvQuJ9WA/979GVU/uFcUcXUAOUl/
         YkFw==
X-Received: by 10.224.52.68 with SMTP id h4mr16457626qag.17.1364922627672;
 Tue, 02 Apr 2013 10:10:27 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Tue, 2 Apr 2013 10:10:27 -0700 (PDT)
In-Reply-To: <201304021853.48643.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219803>

On Tue, Apr 2, 2013 at 6:53 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> ---
>  contrib/remote-helpers/Makefile                |   3 +-
>  contrib/remote-helpers/t5810-test-bzr.sh       | 143 +++++++
>  contrib/remote-helpers/t5820-test-hg-bidi.sh   | 243 +++++++++++
>  contrib/remote-helpers/t5821-test-hg-hg-git.sh | 534 +++++++++++++++=
++++++++++
>  contrib/remote-helpers/t5830-test-hg.sh        | 121 ++++++
>  contrib/remote-helpers/test-bzr.sh             | 143 -------
>  contrib/remote-helpers/test-hg-bidi.sh         | 243 -----------
>  contrib/remote-helpers/test-hg-hg-git.sh       | 534 ---------------=
----------
>  contrib/remote-helpers/test-hg.sh              | 121 ------
>  t/Makefile                                     |   2 +-
>  10 files changed, 1044 insertions(+), 1043 deletions(-)
>  create mode 100755 contrib/remote-helpers/t5810-test-bzr.sh
>  create mode 100755 contrib/remote-helpers/t5820-test-hg-bidi.sh
>  create mode 100755 contrib/remote-helpers/t5821-test-hg-hg-git.sh
>  create mode 100755 contrib/remote-helpers/t5830-test-hg.sh
>  delete mode 100755 contrib/remote-helpers/test-bzr.sh
>  delete mode 100755 contrib/remote-helpers/test-hg-bidi.sh
>  delete mode 100755 contrib/remote-helpers/test-hg-hg-git.sh
>  delete mode 100755 contrib/remote-helpers/test-hg.sh

Don't hesitate to format patches with -M :)
