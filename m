Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103102022D
	for <e@80x24.org>; Sun, 26 Feb 2017 15:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbdBZPTV (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 10:19:21 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33064 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbdBZPTU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 10:19:20 -0500
Received: by mail-wr0-f196.google.com with SMTP id g10so7274866wrg.0
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=Z2aP3L763AGNcZrv1D73+tjeoSKe4ArLPHMxfDFmecg=;
        b=KPaJVoS9voMvWGe+/QLdmn+r6OzjjV0BEGKU9RE5eijuZ48QtG09iBxXQhbOMXm7Ej
         E4fADCyfIBwIqMZp04r6byKJQGN3ajuOSOhpVQNAwsvl0DWNShk255kF3n4EkZJ8M7IJ
         yAWmo765k/fwAifds93MLcJjAIeJefpIuT9HGwHlbzSkHGRsXlWVD5CUaolRywnhtKGI
         jeGimjb4b5vYF0Sy6E4RblVV5guIFvKUl3G8/KHPICIXN10sle7ASaUoM8Afi1sp3il3
         UP6gbnd6cwjcS9GaCvcozi20JZkWtIX/yD3Fuy0u4pDTAjwq6M5cHLj0TfWFu/cEPFY+
         SW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Z2aP3L763AGNcZrv1D73+tjeoSKe4ArLPHMxfDFmecg=;
        b=sANtKrXmVrplOqxpLzDwXtkl/OgBu5NlVeMUYVP8jWjnfiiDtITLtLrZXNmy0D57Ae
         WL0k3S3Z/81qrvAUTPpjIUgtRUkVoG7FwyRYvVBcJe+U11gPaSlAtZE59K0+OJkQOEz4
         ZXtB87UE+dkz7vf4mXVXBgpAvhbjtpqdRBV8i/RR79Ja5utJuCYZBY6lINrX4sUFqTGp
         ywrB7jE0OdXB5Gv4ieDoDk5d81DJsrsRxjwFR4WGMisykv5mc8h28OAu51adn9SiT2cf
         kL8OzXRz5K+lKKV2TojWvsB89rBhOFDmmu/E2FRJcWZLeGbCar8x1NklztItsgWuSpMO
         CcBw==
X-Gm-Message-State: AMke39lCFI2jLke2NCfuphYskp3v5S1vPgXGXS3l8GOKcX3M4A+yCXhQlwWB4z3151QTPQ==
X-Received: by 10.223.129.74 with SMTP id 68mr10034316wrm.183.1488122358117;
        Sun, 26 Feb 2017 07:19:18 -0800 (PST)
Received: from [192.168.5.102] ([87.116.180.111])
        by smtp.gmail.com with ESMTPSA id g40sm18627418wrg.19.2017.02.26.07.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Feb 2017 07:19:17 -0800 (PST)
Subject: Re: Reference for quote "creating branch is not the issue, merging
 is", in context of Subversion/Git
To:     =?UTF-8?Q?Michael_H=c3=bcttermann?= <michael@huettermann.net>,
        git@vger.kernel.org
References: <c25bc18c-d599-93fd-0bad-23e1240e081e@huettermann.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <32232f89-a6f8-be30-278a-bdfedae0716a@gmail.com>
Date:   Sun, 26 Feb 2017 16:19:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <c25bc18c-d599-93fd-0bad-23e1240e081e@huettermann.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Michael,

On 26/02/2017 12:40, Michael Hüttermann wrote:
> Linus Torvalds made a statement regarding merging/branching and stated
> (as far as I know) that "creating branch is not the issue, merge is", in
> context of Subversion/Git.
> I do not find the origin source for that. Can you please help and point
> me to a statement or article where Linus elaborated on this?

Could it be that you think of "Tech Talk: Linus Torvalds on Git"[1]
(held on May 3, 2007)?

To give you some clue, here`s an excerpt from Linus' talk/presentation
(taken from the transcript[2] containing the whole thing):

  "... Subversion for example, talks very loudly about how they do CVS
  right by making branching really cheap. It's probably on their main
  webpage where they probably say branching in subversion is O(1)
  operation, you can do as many cheap branches as you want. Nevermind
  that O(1) is actually with pretty large O I think, but even if it
  takes a millionth of a second to do branching, who cares? It's the
  wrong thing you are measuring. Nobody is interested in branching,
  branches are completely useless unless you merge them, and CVS cannot
  merge anything at all. You can merge things once, but because CVS
  then forgets what you did, you can never ever merge anything again
  without getting horrible horrible conflicts. Merging in subversion is
  a complete disaster. The subversion people kind of acknowledge this
  and they have a plan, and their plan sucks too. It is incredible how
  stupid these people are. They've been looking at the wrong problem
  all the time. Branching is not the issue, merging is..."

This specific branch/merge performance talk starts at 50:20[3], where
the part quoted above comes at 51:34[4].

Please note that there`s more context before and after this excerpt
that puts it all into the meant perspective, so you may really want
to watch/listen/read the whole thing anyway.

Regards,
Buga

[1] https://www.youtube.com/watch?v=4XpnKHJAok8
[2] https://git.wiki.kernel.org/index.php/LinusTalk200705Transcript
[3] https://youtu.be/4XpnKHJAok8?t=3020
[4] https://youtu.be/4XpnKHJAok8?t=3094
