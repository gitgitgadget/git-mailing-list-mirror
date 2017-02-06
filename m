Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6456A1FAF4
	for <e@80x24.org>; Mon,  6 Feb 2017 06:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdBFGP4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 01:15:56 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35780 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdBFGPz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 01:15:55 -0500
Received: by mail-vk0-f47.google.com with SMTP id x75so49432247vke.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 22:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3NDxaZJ0e99houmgR5MjGtUOZnCX88XaDMs7QMAx2v8=;
        b=oY8R3hsMhj891slERoOzse1EhQtDZHuCKDWNNwPoQ31OfDtGJJzY0jcFyWhWsUMq2o
         jTHwj7dUwkWVWmQy8OQE3lMHmaWrM1VfdsTzoq9rDLsUOvHeRUR6XoVXVVZnhgolreOP
         QIIBdl7VOx1YG/j9Lh2l9hEX3miERNeh1BmZugECPollbGfczhbQponI2MQdZwBIGaWJ
         6JztRGuKAUQO7O7NaJQ6xQADtzDAo8ELBcvNgiLuf3ORDssYSd9LOHSpb61JDJuC94t7
         BjdrQ718iJrOnl3cIGsVnqu5KUbsi1Ti6OadLW5WTuYZbfw+gWiWr+1R/9HQexhiqXAg
         6Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3NDxaZJ0e99houmgR5MjGtUOZnCX88XaDMs7QMAx2v8=;
        b=ZGkHAi73UaxUm7Ed9t+l3tNfER5qYCBT7c2B8sERwHWpRj2ErHBb7sveca0Q9XfZgj
         l3SJLOSD4WFqrnda0yNP8La2WXolAnWJ07FrQRBH+xLcYTuGFttkZxJojmflSvs3oxil
         IvRJZB2hVCRBQ9BFpizw2zuymU/it3EC8knFCn8miIfE6TWcBORzEj3FirDYEDO5YRTS
         RuRtZr6I9ZX+zzHpZf6SAygR7C/KfQzKBIG5YPwSZn3Lxf7K2GsZxoxkHQaIfenJucvt
         jlbmiSpc1CsDaUKrosriurFjhvpGuYWiwAusulb8IlBvEyXz63Rw/dx7+ZUPLxRe7ERr
         iDIw==
X-Gm-Message-State: AMke39nb9vD+Ov3PD5zY/nWFQXEo+30t8Ly8t8MGWXiqzoLrdvf2HycGj6BT019plWGYESJQLnq37q+yaQbitQ==
X-Received: by 10.31.169.16 with SMTP id s16mr3037299vke.21.1486361749093;
 Sun, 05 Feb 2017 22:15:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Sun, 5 Feb 2017 22:15:08 -0800 (PST)
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 6 Feb 2017 00:15:08 -0600
Message-ID: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
Subject: git/git-scm.com GH Issue Tracker
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've went through a bunch of open issues on the git/git-scm.com repo
(specifically, everything after #600) and I think the bulk of them can
be closed.

I've taken the liberty of classifying them as shown below.

- Sam


# Irrelevant but someone should take a look

693


# Irrelevant to git-scm.com and should be closed
# Each of these had had someone comment on it saying as much

939 912 906 905 901 896 894 886 885 884 883 879 877 871 868 865 861 840
837 834 828 813 811 807 796 795 790 774 751 748 745 744 729 727 721 719
711 690 686 686 674 673 671 667 660 653 635 631 621 615 613 612 611 610
609 608


# Resolved, duplicate, or non-issue

936 875 863 858 856 839 786 785 761 760 754 752 736 723 720 704 684 683
675 663 662 661 657 651 649 640 637 634 633 628 623 616 614 605 602 601


# Relevant and should be kept open

929 890 859 855 854 826 812 808 804 787 777 768 747 715 703 701 695 694
678 668 665 649 646 639 620 617
