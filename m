Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB621F453
	for <e@80x24.org>; Thu,  8 Nov 2018 17:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeKICoB (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 21:44:01 -0500
Received: from mout.web.de ([217.72.192.78]:58001 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeKICoB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 21:44:01 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmcjH-1fmZLI0z2J-00aHFJ; Thu, 08
 Nov 2018 18:02:31 +0100
Date:   Thu, 8 Nov 2018 18:02:30 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Adri=E1n?= Gimeno Balaguer <adrigibal@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-rebase is ignoring working-tree-encoding
Message-ID: <20181108170230.GA6652@tor.lan>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104170729.GA21372@tor.lan>
 <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com>
 <20181105181014.GA30777@tor.lan>
 <20181106201618.GA30158@tor.lan>
 <CADN+U_N345aMaiN4CT-_qsecw2gv=8-r+Hqq+CNz-xOx2KGYzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADN+U_N345aMaiN4CT-_qsecw2gv=8-r+Hqq+CNz-xOx2KGYzg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:MqBFytzwMFdSfDd8uQEfNE0aoBZVEVSodrny8YbZSWCKCVNGS+h
 SIcgSh2FKzQagXzL60Ciw3ePqKhP2vjF/WFTuUWNP66pgTav3vbc8zyC5dSB2xTQnd9CGVr
 6JSY2GN2BUU7eCAts1BKuEb4mUD5cyW4VKgqq2yklCV/ej/TX5o2grpGDzt/XfpdA66lheC
 tvFTPZWUTD92Hg7T4YqAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WfvnXF/Zawg=:YTfQ3Iww48XfAizzXBVrDu
 /DVb6PDlkcCVTohoo8NATJsoiNCRXsU8LSeWTzqcn09/3jVQabbcOHm3zM9D56eYJEBOsLr/U
 S6L/3ygS3UiPecTgKoMV/R6HfsXFGlJ3+IrwaxtuA9JUhPrMCguMvMj5FTn76E3VXrwtoyXYi
 9RzXetVsM033r5b5KoeomFw6UakpMX5A+DylxCn4RpQSa0Q7BwUTCPyQqhM3bevM3+aM18ri+
 uMtwPlOQwftTBcy1/IV/hz9bIwbS/fV5JBViSs95zzM+fCxu5djuSzQEoCqLwZPDBEPGXUb3o
 wsGRvf8bQEoJt96p+WTVDOvnRHCZXrjRXsXcm96/BbXeG+q+jkeKCUi26cuFr7pRByEm3h8H2
 X9lR9aJ0MjVT6q12QfRLFHDIRtw0NNzKbPkYg338FmRhDQEmprl1xjegEM4B1lhlMjeMpRZFS
 gENh9RyXSDyWujTAlBspwZ6G6i6xyfphyXrf+R9dlA53iQ409G2PKukmTx2lzRfZ90oZ40vY6
 jLHhOg/ZKzmuUhJP3WYLvwt4YeVqq1sTTN/p4U0ettE6BaiwgNd/wjbdE+HNd9lRY3aa9Yofo
 bUu+XkqqC83qqyaBEtsC7wIZO3YP99Y/wd5ZpaGhhwlwZ+HV9qGCG+tqTHD/Yi2UN78+UN+vI
 DhiQxfDnzuGdRnHtO2WYJkyXoSUm+bcxthqeCLI4S5HdJN5h/AhInjsqFE7mjiXTcEFYnqxRz
 LVK/4Smok4t8LlKYbN3fQEiIGeiBT674w1vmtTogC2HDHaNCRKq78ZCHlnyLB/syaU/1/gUcm
 MjeS6mxHPVwNMM0IoklI4cv87rcksP+AY/UP6ahcGKCGCxSK0L6b3XbsN9r08+iqhZt7vzmxe
 kqYdF/DVGcpY223C5taGVVdivaK/7/oU3z5WrVXPI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 07, 2018 at 05:38:18AM +0100, Adrián Gimeno Balaguer wrote:
> Hello Torsten,
> 
> Thanks for answering.
> 
> Answering to your question, I removed the comments with "rebase" since
> my reported encoding issue happens on more simpler operations
> (described in the PR), and the problem is not directly related to
> rebasing, so I considered it better in order to avoid unrelated
> confusions.
> 
> Let's get back to the problem. Each system has a default endianness.
> Also, in .gitattributes's working-tree-encoding, Git behaves
> differently depending on the attribute's value and the contents of the
> referenced entry file. When I put the value "UTF-16", then the file
> must have a BOM, or Git complains. Otherwise, if I put the value
> "UTF-16BE" or "UTF-16LE", then Git prohibites operations if file has a
> BOM for that main encoding (UTF-16 here), which can be relate to any
> endianness.
> 
> My very initial goal was, given a UTF-16LE file, to be able to view
> human-readable diffs whenever I make a change on it (and yes, it must
> be Little Endian). Plus, this file had a BOM. Now, what are the
> options with Git currently (consider only working-tree-encoding)? If I
> put working-tree-encoding=UTF-16, then I could view readable diffs and
> commit the file, but here is the main problem: Git looses information
> about what initial endianness the file had, therefore, after
> staging/committing it re-encodes the file from UTF-8 (as stored
> internally) to UTF-16 and the default system endianness. In my case it
> did to Big Endian, thus affecting the project's requirement. That is
> why I ended up writing a fixup script to change the encoding back to
> UTF-16LE.

OK, I think I understand your problem now.
The file format which you ask for could be named "UTF-16-BOM-LE",
but that does not exist in reality.
If you use UTF-16, then there must be a BOM, and if there is a BOM,
then a Unicode-aware application -should- be able to handle it.

Why does your project require such a format ?

> 
> On the other hand, once I set working-tree-encoding=UTF-16LE, then Git
> prohibited me from committing the file and even viewing human-readable
> diffs (the output simply tells it's a binary file). In this sense, the
> internal location of these  errors is within the function of utf8.c I
> made changes to in the PR. I hope I was clearer!
> 
> Finally, Git behaviour around this is based on Unicode standards,
> which is why I acknowledged that my changes violated them after
> refering to a link which is present in the ut8.h file.

[]
