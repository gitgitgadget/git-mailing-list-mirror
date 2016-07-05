Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5779420706
	for <e@80x24.org>; Tue,  5 Jul 2016 15:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbcGEPZS (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 11:25:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:60178 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754796AbcGEPZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 11:25:16 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M1FAK-1bZeix22S8-00tGPr; Tue, 05 Jul 2016 17:25:07
 +0200
Date:	Tue, 5 Jul 2016 17:07:55 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	git@vger.kernel.org
Subject: reflogs and worktrees?
Message-ID: <alpine.DEB.2.20.1607051704490.8378@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Oubz/pAr/lgDnykhqICprYgGnN58PbspaqHx3KtyhNBqBu1lsbm
 R394PKmXhK8aWbQqVA9aZMQaMjOu+XlAGnJEVLgZgvxDuw1MXCyZYJYO900JxrhJFR7pvP6
 5/D1ZEtWGHaKwZm1Xuo1uuq2A4h41ElHT4uKMoephTHR16CsGdz1pEnVYkz8oxX+iF+4Iwa
 nlJikGTSt/V0nfuOKsdBw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:MCXB4u0e4lE=:3xGcS/N382qIPZ3fuIM+9M
 HO/6AiZvn2ORQ6eu8CbBaLuz044cTdWpZ1S4kpFMzWC8itMoI0HiniSePxCeswoXgbZKm6RH/
 bWvnfl7ZZj410fRC9pd7NRjrRC7pLtGezHgvtYa/kNFqLkNQCugs0QsAgbXdYFqZ+65LHnh13
 WdwYX/3JAcUiS9xwdHXk5PI02wO9zuPbdJ49KiBZ8FgdgVvDzK8lD/hld28DHojsgkrVyftif
 qDGtTtQlDULJ+UKX8LKbL2kMY9eVqyC2hA/DSNhbATrEYEML9SaeC24JxtdoWaqWaBQeFrzmx
 76BH6AZ+8QtdEnezWBi8+54x4MILalbW4HAoudQDskc4sGyTOubIiO1FZYulo6kUOzNlTpxh8
 bVoaMbkFRZak+gIJztbXFwXjMY2re1YqeAEz/R0s+TKD56foTTAcefgzIuH0gXuprv4dqkXBx
 YHjGi39Puio/NWwuUF9puplbBgKWbYrNGbJSZ5hQsNyJdKuVndhO7pgI+6dcgofJ5Ip9VWJrk
 rwkOGzG1blV5TjE1KfpTn3BXlQCNpSyTifPqHo9Q5vQKlqOof/8x5/U13p8OC0+XcnbWKl/eF
 d88UeojPzblWOLUEKhryq0y5Bda8p7VNzCq4RP6zLw/qMTqOShtAYagkkjomM0vJuDQ8kROTT
 //ua53faGHXstX90Ia8Fy0/YrovW1njrTaGZH8ZaJplUEwn6fh8Rrh9WnieQBOjOwerEZla7N
 IlE4NPjsvLue7qJIbbh77O65H3ZKudd57O+mX5DPB6ykfUu4ae7IolWR2F7dl6M24HcbX3slu
 uMudqPE
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

ever since I started working extensively with worktrees, I end up with
these funny gc problems, like broken links and stale reflogs.

Is it maybe possible that the reflogs (which are per-worktree now) are not
traversed completely when gc'ing (which is *not* per-worktree)?

Ciao,
Dscho
