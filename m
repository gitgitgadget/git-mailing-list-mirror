Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810611F45F
	for <e@80x24.org>; Thu,  2 May 2019 18:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBSfb (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 14:35:31 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:35308 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfEBSfb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 14:35:31 -0400
Received: by mail-it1-f178.google.com with SMTP id l140so5174547itb.0
        for <git@vger.kernel.org>; Thu, 02 May 2019 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AJV49aTi6g3FOixYaJPj5E4Xe8OJZyb6atNA69l4euw=;
        b=J+iX9eqFzM2Akx9RJS9IBricN0Mj3AawEzAEVQrD7urAoVd1DYaUDeQZG9sQfEdw4M
         I4Ed2zi1Nr+nhTpI3QGZKUkBUHKHAlqoxrz13n0TXx/RGFru5BbcvCjkgWI5ZvkR0mcw
         B7MQWelPNJA8PnRXrNrZzphnnSbYmaVdAhjarEQR4+MGmCX34PcZtUOSQlsGMnMv/s0l
         e2716Q9eT81pBFWLa7UnB2uZ79IyH5deXKF7jFhyZ8aJyvnqKXbRcRFGv7zlvh1HI2JJ
         q3YltSWPXf+ecZKvXbQV7XI4JsOEpGJZhF0dNnG7OKI/WgR1yZIAEvIzxXXLwZQdP4ix
         Zyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=AJV49aTi6g3FOixYaJPj5E4Xe8OJZyb6atNA69l4euw=;
        b=AgkgdMMeIXBHT6gTOuyG/nJH37KicF7B6D0HywSCUvgW2roL22s9jkbjKdCn2iPRXd
         UfvxwhD6ILUQcyJgYBhn3oB8gj4gAX1bovcFLOcDL8eIlPx5bQSHhKv9stD9kcfmCbRD
         raabvGzQ0Px20dkOnrQKZ3r61ql+oeSr0iZ9UCBsO53db43M0HMOyoFLb0d1YVz2E34N
         jAmXpUNxm+IiVbCFHZQg6foj4ocMpGq97lW88CNXvgCArPKpFLaZxrf8TMR6cvZhAH+q
         f5nQ0cFhgRcucbJnZKhWOTk5N+xwCADc53NK8eLbDgO8cjHhrVIjpwXmmou4b+qHXBaS
         BgBQ==
X-Gm-Message-State: APjAAAUxlImNZa3VuQ0Z5Qy7UgD1PcOa7qhoR4kal2jcRMG3m0A0lAHm
        rL6wyisb/fWKReIADezBUMDdldubBVZMKWD1S64=
X-Google-Smtp-Source: APXvYqy1uWreF5u1FbSA24bEPYZHPTV9LTUWzl6Zk7nNJwKFs8Ex9t+w3NjhS24QyiGoy+PmoRf5Mj1NeEOKYquSxYw=
X-Received: by 2002:a24:5905:: with SMTP id p5mr3735574itb.171.1556822130492;
 Thu, 02 May 2019 11:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8kec2N0fkt6cWChOEGtGkrOE5S+QuZnQnDP1eM9mg_EOQ@mail.gmail.com>
 <20190501223005.GB42435@google.com>
In-Reply-To: <20190501223005.GB42435@google.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 2 May 2019 14:35:11 -0400
Message-ID: <CAH8yC8=AB1E=U7vCTkOLELQ9z1vW2up_WCYziW25Uqe0jXZBaA@mail.gmail.com>
Subject: Re: install: gitweb.cgi was not found anywhere
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 6:30 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jeffrey Walton wrote:
>
> > I'm attempting to install Git 2.21.0 on Solaris 11.3 x86_64.
> > /usr/gnu/bin is on-path.
> [...]
> > gmake -C gitweb install
> > gmake[1]: Entering directory `/export/home/build/git-2.21.0/gitw
> > eb'
> > gmake[2]: Entering directory `/export/home/build/git-2.21.0'
> > gmake[2]: `GIT-VERSION-FILE' is up to date.
> > gmake[2]: Leaving directory `/export/home/build/git-2.21.0'
> >     GEN gitweb.cgi
> >     GEN static/gitweb.js
> > install -d -m 755 '/usr/local/share/gitweb'
> > directory /usr/local/share/gitweb created
> > install -m 755 gitweb.cgi '/usr/local/share/gitweb'
> > find: cycle detected for /lib/secure/32/
> [...]
> > install: gitweb.cgi was not found anywhere!
>
> Sounds like it's using "install" when it should be using "ginstall".
> config.mak.uname contains, under the SunOS category:
>
>         INSTALL = /usr/ucb/install

Thanks again Jonathan.

/usr/ucb/install no longer exists in Solaris 11.3 i86pc:

    solaris3:~$ ls -Al /usr/ucb/install
    /usr/ucb/install: No such file or directory
    solaris3:~$ uname -a
    SunOS solaris3. 5.11 11.3 i86pc i386 i86pc

The config files need to be patched:

# Solaris 11.3 no longer has /usr/ucb/install
for file in $(find "$PWD" -name 'config*')
do
    if [[ ! -f "$file" ]]
    then
        continue
    fi

    sed -e 's|/usr/ucb/install|install|g' "$file" > "$file.fixed"
    mv "$file.fixed" "$file"
    chmod +x "$file"
    touch -t 197001010000 "$file"
done

But I think I tracked it down to sane tool path. originally I was using:

    SANE_TOOL_PATH="..." \
    ./configure ...

When I changed it to:

    ./configure ... \
    --sane-tool-path="..."

most of the errors went away.

I also removed a bunch of old patches and hacks that don't seem to be
needed for Git 2.21.0. Between both of them I am building Git on
Solaris again.

Related to /usr/ucb, also see
https://blogs.oracle.com/solaris/preparing-for-the-upcoming-removal-of-ucb-utilities-from-the-next-version-of-solaris-v2
.

Thanks again.

Jeff
