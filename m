Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F947C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 13:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBZNWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 08:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBZNWe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 08:22:34 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABB6A278
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=TEV9oLz8Reca8D8jNhOjulLP3jsoKnsziUrDEE7Nbdw=; b=uVPMza
        rlCs4JoP1ZIAk4JT6YE5NpvbE9kVkdaeNfk5yBzjNYcTU8OReCPiSfHtZKPwT5HkJ5ZLKO+8Nqaap
        YpYIi8iabIGamnbynZgUsS5penj1sKm0ljx6zuLK4wPy2Yt8VV2MfrkPATv8oAv3AFz9jP5bs2FJE
        ljE5nElCKtk=;
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pWGz0-000BdX-FH;
        Sun, 26 Feb 2023 13:22:31 +0000
Message-ID: <d9a5ec01-db01-cf9c-71e0-980c1c3cf4af@iee.email>
Date:   Sun, 26 Feb 2023 13:22:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] git-gui: Fix typo in Italian translation
Content-Language: en-GB
To:     lore.pini@gmx.it, git@vger.kernel.org
References: <00aa01d9431b$96efb490$c4cf1db0$@gmx.it>
From:   Philip Oakley <philipoakley@iee.email>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Jiang Xin <worldhello.net@gmail.com>
In-Reply-To: <00aa01d9431b$96efb490$c4cf1db0$@gmx.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/02/2023 22:02, lore.pini@gmx.it wrote:
> Signed-off-by: Lorenzo Pini <lore.pini@gmx.it>
> ---
Git gui corrections should copied to the subsystem maintainers (see
https://git-scm.com/docs/SubmittingPatches#_subsystems_with_dedicated_maintainers,
from git\Documentation\SubmittingPatches.txt)

git-gui/ comes from git-gui project, maintained by Pratyush Yadav:
https://github.com/prati0100/git-gui.git

For translations the details are in po/README.md for the 'portable
objects' subsystem
po/ comes from the localization coordinator, Jiang Xin:
https://github.com/git-l10n/git-po/

I've cc'd those maintainers.
>  po/it.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/it.po b/po/it.po
> index 1bd8b8e..7963aed 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -385,7 +385,7 @@ msgstr "Documentazione sul web"
>
>  #: git-gui.sh:2786 lib/choose_repository.tcl:47
> lib/choose_repository.tcl:56
>  msgid "Show SSH Key"
> -msgstr "Mostra chave SSH"
> +msgstr "Mostra chiave SSH"
>
>  #: git-gui.sh:2893
>  #, tcl-format
> --
> 2.38.1.windows.1
--
Philip

