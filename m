Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E1A207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 19:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbcJITWx (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 15:22:53 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34531 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbcJITWx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 15:22:53 -0400
Received: by mail-lf0-f48.google.com with SMTP id b81so87885356lfe.1
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CC4cNmw5+acWRrMqyfWwW7lx34iQDkI1jOOUw4JQGoY=;
        b=ZTJKZejCm8NXh7vjm8+nqaUqy5lCO0Oqsj6ejYksmeGkngzR0CNKrMdrmWCG+H11Ba
         PczDwZEjeca51s2e8FYqzH9sXQNCc8IgLk7m3X7Uz+xQwAbCLvzJ1Jj7fVvu4uvbOJIW
         s1qED8wXOxbfBjyOd23wvp2l+DHx5MtOtOPoEvObnL2yYFl3eKZ96w0NCat39/PLQbZf
         huo0WxIO7NSw9LGTOFLp9DZij++fsuaOObhtUqtzdlhLx+a4cHRDez4RaROFAw/kONrV
         9612VQL//opZjZHvEAMPez+nFcKlpYnDtenHqbh4XkBNkK91oyUFz2fwxuUP3LB9Tz8L
         fVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CC4cNmw5+acWRrMqyfWwW7lx34iQDkI1jOOUw4JQGoY=;
        b=PA9NAZ9q2Mkkl6tVCnHv4ZCZ2LmDmnqby8b3Q0iYFuVIUUq6n4iECUQL+2T3ugN7hr
         UBFxfHfLwyqz4XFruhr/I1VIoI8ROHhm+KHE51v3GALOCad2kSXv12jfZ0tWZOSTzYlK
         qyl4jLkXvG9lwDGv1DGHDBqVlLCacrvDVBeKOS9cgRUa10YIeC8zkrqyBhugsZxMNOS/
         O7cFmJktNQjbkPsmPNqhxHXXd2oseBeJYwMM+TC256Q8oY3XNo6nf7msI01wVH7Xr3XF
         5UBJkyNUQ+zxE/OpVZwMQ6lv5Tm9HqdgQUBkvaeRJeQsu0G5Nw7mfcT+lLJadkXvmrZW
         oV7w==
X-Gm-Message-State: AA6/9RnVJ1r4/gmq1j93sbU5Y9Gk0dWvocGBCxY2J/jUenqqwaWlJPmQirUsTcvObppP2akjjvvI9azg11etWA==
X-Received: by 10.194.115.230 with SMTP id jr6mr10385150wjb.3.1476040970925;
 Sun, 09 Oct 2016 12:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.143.33 with HTTP; Sun, 9 Oct 2016 12:22:50 -0700 (PDT)
In-Reply-To: <CAL4Sumj7r-RNXBi2Oh_=KAkcksM13sJjLzJEpszWXPXZ8hP6Kw@mail.gmail.com>
References: <CAL4SumgJbrirymt5+iyNbpo++xXfzJZRiHDm8=0+eCArpCX=DA@mail.gmail.com>
 <1476035501.26041.1.camel@kaarsemaker.net> <CAL4Sumj7r-RNXBi2Oh_=KAkcksM13sJjLzJEpszWXPXZ8hP6Kw@mail.gmail.com>
From:   "venv21@gmail.com" <venv21@gmail.com>
Date:   Sun, 9 Oct 2016 21:22:50 +0200
Message-ID: <CAL4Sumjc0Fo3JLBZxdM50Z3o8ZhGk731905Gxg=R=GXsPMKzmA@mail.gmail.com>
Subject: Re: Problem with submodules
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hm okay, it works with 2.10.0, when I remove the word 'epiphany' from
the urls in line 13 and 15

2016-10-09 21:15 GMT+02:00 venv21@gmail.com <venv21@gmail.com>:
> Sure, http://pastebin.com/bUFBDj0Q
