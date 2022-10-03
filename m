Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B76BC433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 11:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJCLp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJCLp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 07:45:57 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE00192AB
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 04:45:55 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CF51A240104
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 13:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1664797553; bh=+MbFVgg+rA8NKrkHaB46c3aP4/aN3xV+LfuD6iZ4FL8=;
        h=From:To:Subject:Date:From;
        b=S0TCay3XitXa/qazeXj0Zyd9SscCivNnVs6TT5uwCw7yPol5qCV+YW371vFEzWX2O
         3NtyFhgA5cpGudusH8iGhha8rP+Y/lpVnbdlkq96NwtGQ6OmnELJR3LpidJyBgfJ+1
         ZRJnwkeiVfXitiOLm5FUV3a7lM5SOZb7kZICl8UWtqrFaGpDsE1INSVowyBbG3J4u+
         BApwycmq7X1oCrgurbR6bBaRzdEmSTM3IPZ1RdDFkox4aeuiXNYFpePUfxkiLxT3Ok
         5lWn5+b6vzErmwy3WbdVztLllvYSrbMaEQQbgBrXOdeIat/8ZJF7dy1NKzfP8EtKIC
         UJ5vIN7vg8Brw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MgzYX5Kh7z6tnN
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 13:45:52 +0200 (CEST)
From:   "Tim Jaacks" <timjaacks@posteo.de>
To:     git@vger.kernel.org
Subject: Bash completion for git aliases containing nested subcommands
Date:   Mon, 03 Oct 2022 11:45:51 +0000
Message-Id: <em8d7ca854-51a3-4cb5-aaf9-30ed37b4194b@acer-switch-tim>
Reply-To: "Tim Jaacks" <timjaacks@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I have set up the following alias in my .gitconfig file:

[alias]
     ss =3D stash show

Unfortunately bash completion does not work correctly on this alias.=20
When I type "git ss <TAB>", I get:

$ git ss <TAB>
apply clear drop pop show
branch create list push

Which is obviously the completion for "git stash" instead of "git stash=20
show".

With the original command I get the list of available stashes:

$ git stash show <TAB>
stash@{0} stash@{1}

Is there a way to get the completion on the alias behave like on the=20
original command?

I am on Ubuntu 20.04 and using the distro's default git completions.

Kind regards,
Tim

