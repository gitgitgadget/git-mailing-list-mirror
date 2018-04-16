Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65FA91F404
	for <e@80x24.org>; Mon, 16 Apr 2018 15:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeDPPon (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 11:44:43 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:38378 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDPPom (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 11:44:42 -0400
Received: by mail-oi0-f51.google.com with SMTP id y20-v6so3484143oix.5
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=iDWKzMLi3uyDngL67hNPG1waJ6R3aRZF9wwZeVwzmuQ=;
        b=OjEIhz3FyLUZMpUdnVXWM/WtjL+9tD2hwG0JBkHnM01phjSmWdWdpqgAgi8vWLqU0N
         GJTG58tMwbiEsszvjmAjhTJytWkBdaBshQBaGr85pveT0Yv3O2NDLyxIT4m4CWzJlZz/
         LvvSLC94+3WWwbxoXxU/luSTGYMANl9ILyzjf+XIecggV5tIX1tjFJPXKPwYx2rmMb5j
         EqwDFINZSwpXtXa+/47PTioyhKaSkA3tYBawtaAGymGOVTDbSibrYXRSGGHE0daA67Tn
         F6SyGRLE2ENwWAGRHKEFIRYm5QxFQVvm8SvqplvWvw8+1v2Md1KQS1pwLu4AfcdJOZKb
         /cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iDWKzMLi3uyDngL67hNPG1waJ6R3aRZF9wwZeVwzmuQ=;
        b=txQM9vZOcYzHi91NrEO5RyxbPCL0h/TTcix7jXGa49+/34+eiERg4I8vElr59rY8h3
         vom2WuqCNFvrkEQior7SzkK+EuvBxwe0dOEIYQbzcK/tzipUXHx9/ZqPmt1ZsQiYmXVP
         UIIJzAIBWxPFCQMirDgJeivyexFkvMNKNUpBktIqlBTj5rnezQvMF/RSiE8Fk7XelYTi
         3iiN7l3+0hd5kEEX9q6+K0LJGQ7N/ijrbWyQSUuBLF4hCGLfTqVPbYuozna81vwdP0F8
         2+g5kLh9zmWEHoJnIeFyFfI0zUviyZnINPMCNhKrjgxiuo3D3ph/CNNxgwCu+2hrb9rw
         A5nQ==
X-Gm-Message-State: ALQs6tAkJ3CkWNo1eIePx2PF99OHjkMNteU2oyKDW801v/u6S08pSPLj
        9cvBh5FYtWsOcbVwPgNmVMpzMJAitnK5PE0/NmSMLw==
X-Google-Smtp-Source: AIpwx48fen5/FmbDVcLX9npkfnYIVeykawcnxFfP0lorn4bc4AY41nfKliYq15LsLFDHUVi22nNwHZls/O7t7qaBc6g=
X-Received: by 2002:aca:2c81:: with SMTP id s123-v6mr5275618ois.27.1523893481619;
 Mon, 16 Apr 2018 08:44:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.9.209 with HTTP; Mon, 16 Apr 2018 08:44:41 -0700 (PDT)
From:   Marko Vasic <vasic@utexas.edu>
Date:   Mon, 16 Apr 2018 10:44:41 -0500
Message-ID: <CALH-0NbMxkQewnrr6S_xtyVH0BrC2J6gpB5r-hx8=PpekP1VKw@mail.gmail.com>
Subject: Git Bash Completion Not Working In Emacs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git bash completion script works perfectly under the terminal,
however, it does not work in Emacs (neither shell nor gui mode). Did
anyone encounter this issues and how can it be solved?

System I use:
OS: Ubuntu 17.10
Emacs: 25.2.2

Thanks,
Marko
