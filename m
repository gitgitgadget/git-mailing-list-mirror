Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74181F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 23:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKOXDx (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 18:03:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45706 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfKOXDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 18:03:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so7340302pfn.12
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IIIDSg3K7A24Mi1tblduiO24vLhCuf+OHTefGovyQHU=;
        b=ORRMkvjUzjIFr4kyDStQuohZP6Dbe1BPH2teS1pxqTtQ7YvzthcgOYBdrohh9khK39
         io+EQ+zvnauTH0h03MujD2MkyqLH/SfnGE1Jxkba5L+CCiOkJjr2EGmTrBm4bfAhvI5I
         0Tc0dG13puzoQyriT0W0tlIBsW3PRsrh/yPX63SZyd/RPSxwdTU3Goc5TmshTWgceIpH
         HZah+i78WgG8P0wAbw7NKhbEYnxkiXH4x8nF5do9uRDJ+49z6I8hLG6m6qymqA45isDM
         gxlFRYD0wGDArTqCx47DQ6ot+52PuzavY8MF2kMVXhWwLL+6vgkwzbDR2TL/2v2K3wLy
         Fm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIIDSg3K7A24Mi1tblduiO24vLhCuf+OHTefGovyQHU=;
        b=sy0ww3TVmifU7nMZRDR8TUtY1M3bSyLapjOLnd4Qo+N2gq2QKJWB7pusuRZythHVW8
         jbj6ZfWsggdL2nEECCYMSbHx5cBJus42XQlxInWx1CSifOxYtZ+NanPGtJUleDgxW4wb
         UUkEoyLii/MVkNWtA+sQiotTeitsqy+pdXg2MgKfXlNJz66ytguNj//ha/dElofWfJ9c
         uC8+aRnJL51Yx862Kcwq/AENEbAc/SOTU9Hvtp9HZBYC2rgEtq4emU88nd14Zi2fwdbq
         1xK9J/QwI6strCLAKzVPB4XiE7/na0ehnINrVMYpxfqo3/SHh0Nb+s4Qq+irkfJd0DV5
         dIZg==
X-Gm-Message-State: APjAAAVPGd0/cgmqGOW6YlRqybEdh4WUBq87PyUBxXS6BycYJDQf3XJO
        zZxVn4NF9OhJ/2LoHetG8lQBsA==
X-Google-Smtp-Source: APXvYqwGqU7meORqihr5oHCQbV3xr/K843jU/EUXA58fVoRzipovAdkGUH2u2/WzTTuRY5R7/qxiIw==
X-Received: by 2002:a62:2a4c:: with SMTP id q73mr19982686pfq.94.1573859031587;
        Fri, 15 Nov 2019 15:03:51 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id s69sm10795436pgs.65.2019.11.15.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 15:03:50 -0800 (PST)
Date:   Fri, 15 Nov 2019 15:03:46 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Denton Liu <liu.denton@gmail.com>, t@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: add avenues for getting help
Message-ID: <20191115230346.GE22855@google.com>
References: <20191115215342.37408-1-emilyshaffer@google.com>
 <20191115220528.GA80935@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115220528.GA80935@generichostname>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 02:05:28PM -0800, Denton Liu wrote:
> Hi Emily,
> 
> On Fri, Nov 15, 2019 at 01:53:42PM -0800, Emily Shaffer wrote:
> > +==== https://public-inbox.org/git[git@vger.kernel.org]
> > +
> > +This is the main Git project mailing list where code reviews, version
> > +announcements, design discussions, and more take place. If you fail to receive
> > +help via the channels above, you can ask your question here. You can join by
> > +sending an email to majordomo@vger.kernel.org with "subscribe git" in the body.
> > +The Git list requires plain-text-only emails and prefers inline and
> > +bottom-posting when replying to mail.
> 
> Perhaps we could explicitly mention that subscribing to the list is
> optional and not required to post (especially since we CC everyone
> here)? New contributors may be intimidated by the volume of mail going
> through here so knowing that they don't have to subscribe might be
> helpful.

Yeah, good idea. I'll move the plaintext/posting order rules sentence in
front of the majordomo sentence, and add "optionally" to the beginning
of the majordomo sentence. Thanks.

 - Emily
