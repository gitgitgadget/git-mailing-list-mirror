From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add missing test file for UTF-16.
Date: Sun, 4 Aug 2013 09:31:01 +0700
Message-ID: <CACsJy8CT3uxp99n9VUXDbL30WEDcuRreeJBaqBcx9Ujici67VA@mail.gmail.com>
References: <1375550791-5823-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Aug 04 04:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5o6s-00042g-KI
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 04:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab3HDCbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 22:31:32 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:52739 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab3HDCbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 22:31:32 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so3991416oag.14
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 19:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1La92VeYpBF9MoztGOzIhJ0kLrTjvGo8cIXL5OgfsT8=;
        b=yWENn+wQVOsHfB61ZqttQif+BzFuvupjS5Zc1sQiqJnibWdNkTxlG71IkAPSY9BLZs
         vcazZ1fpOOsoj6DtGrkN9CHAe0r0K4AITmqV2lpbAoGa/0hzybcQe4yx3dl7nJf06lre
         /LlvE+2GOir6+qIfHj0wbAumhLkKDf21XVDg9jekd6rnKbtyrxZhSDdHRegxEwmgWd2d
         QyxWJE4C6siY0+1l99P+6o8WPNG4R6FPFYRiqax5wSAVOhG3Ag3xH2ECaj0oFOSFM8Wk
         ub3jcpjiMEKnGNvhC7ommxNy5qBqHPLLtlTtWOHtuug0fr1wZ2xfmJ7Ehg4mdpibBZuD
         FFow==
X-Received: by 10.60.132.113 with SMTP id ot17mr9987035oeb.104.1375583491388;
 Sat, 03 Aug 2013 19:31:31 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sat, 3 Aug 2013 19:31:01 -0700 (PDT)
In-Reply-To: <1375550791-5823-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231620>

On Sun, Aug 4, 2013 at 12:26 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> The test file that the UTF-16 rejection test looks for is missing, but this went
> unnoticed because the test is expected to fail anyway; as a consequence, the
> test fails because the file containing the commit message is missing, and not
> because the test file contains a NUL byte.  Fix this by including a sample text
> file containing a commit message encoded in UTF-16.

Tested-by: Duy Nguyen <pclouds@gmai.com>

and sorry, my bad. I think we need your sign-off in this patch.

> ---
>  t/t3900/UTF-16.txt | Bin 0 -> 146 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 t/t3900/UTF-16.txt
>
> diff --git a/t/t3900/UTF-16.txt b/t/t3900/UTF-16.txt
> new file mode 100644
> index 0000000000000000000000000000000000000000..2257f05a992a4b9500f6ff33752cbdf8fb58c99d
> GIT binary patch
> literal 146
> zcmW-aJqm<C6obFoQ_KYvZ0uz~uwFfY_=AGZf}@2;@>bjKEzFY?FCi}po-doQaNvlX
> zuj<&j$Vh~SS#Fd&>8^}o3xQtzWRNy5zCGpzu|P`62Tv_HZgu?B*(r7K7qg7DI9e@K
> J`p+qB@d1eo8QA~;
>
> literal 0
> HcmV?d00001
>
> --
> 1.8.4.rc1
>
-- 
Duy
