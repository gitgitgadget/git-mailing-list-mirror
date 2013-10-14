From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v5 1/3] test: use unambigous leading path (/foo) for MSYS
Date: Mon, 14 Oct 2013 08:50:42 +0200
Message-ID: <CAHGBnuPE7z=rGmuNorMJsMn1kd92yheR=ZH=80GPRFATBC1g0A@mail.gmail.com>
References: <52570EC8.3050207@gmail.com>
	<cover.1381717700.git.worldhello.net@gmail.com>
	<4a078e41976b25488571b1478a51e287ffdd55c8.1381717700.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 08:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVbzZ-000492-Jq
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 08:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab3JNGuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 02:50:44 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:52880 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab3JNGuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 02:50:44 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so5472095lbh.28
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VuA9uy7pNgVb5KdKbmd69Aj6Yr5zLdXBfChY7iWMWaI=;
        b=GfgZAxMO7+tSyBFiOTryvg/Jk9GATD3JAZaC6xwGryxWHLoMd1zsr/VfNew7naou/k
         oXckcBgkUvumGRcKBVOC1DF+8f1sS8J998UKO04gS2TIjq7Wr0EEK9585AHLO0ouKuom
         pH3SkWJw+uGCHm9pHJv/0k/hv+LsyTD9FGBi4KEqBqOpkltlC/xMcWD+4htdPOGyOCpn
         JwppM1sgi+5Ej784Rj+zPOvDf38OTzyFHSMK7yAtlRm1Dj0cK99bV5uvG/LW8BCBH+7q
         ImSsASAbEMG2p6w3HqcbOFT+bWCwthLEhJLQ27PrxKNg12nA5HtuaIAK5nBPWu69DTR+
         5i+Q==
X-Received: by 10.112.72.229 with SMTP id g5mr29525447lbv.10.1381733442480;
 Sun, 13 Oct 2013 23:50:42 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Sun, 13 Oct 2013 23:50:42 -0700 (PDT)
In-Reply-To: <4a078e41976b25488571b1478a51e287ffdd55c8.1381717700.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236096>

On Mon, Oct 14, 2013 at 4:29 AM, Jiang Xin <worldhello.net@gmail.com> wrote:

> In test cases for relative_path, path with one leading character
> (such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
> such DOS drive on MSYS platform. Use an umambigous leading path
> "/foo" instead.
>
> Also change two leading slashes (//) to three leading slashes (///),
> otherwize it will be recognized as UNC name on MSYS platform.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t0060-path-utils.sh | 56 +++++++++++++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)

Thanks, ack.

-- 
Sebastian Schuberth
