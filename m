Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8127C2047F
	for <e@80x24.org>; Mon, 24 Jul 2017 05:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbdGXFLJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 01:11:09 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34876 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdGXFLH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 01:11:07 -0400
Received: by mail-yw0-f193.google.com with SMTP id l82so888406ywc.2
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 22:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MH+Sw4Tvw7WsQs8k4FQrt38A6W4AiR9EC873iRpnXoc=;
        b=WcvSS4uOdNN+oQrGptTqKRKi4YGPs5KL+fMBwqL7KDtuq6wTNjJrvCcQDg3ctysUcm
         NuJBMHqr5aVrtpSSGgjRQ6HYJtdCgLfU1OpP1I4zwnElHob3W1/5hubVUP/2l8RuiqXp
         5fGvzlvhaXph7nCzzvgSaO2np7OnAQaEocqCoPmOQk7UPWRbLgXsamXrt2/laVP5QWbw
         YamPj+ruPxXNyMf/GSTtRiZDgdXG0Z7ZAHhkysoa9S1YeMooit4+PTZZFqiT05zA+q9I
         VChh6OtVe+IIQRUqykNHua2BWJC7Y0fPfnOdpI7hPEpLTajjnEPJEYG2lpI1Fi5veWSW
         dMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MH+Sw4Tvw7WsQs8k4FQrt38A6W4AiR9EC873iRpnXoc=;
        b=prs2CYqZfm37jCtRn7Kam6JiARx72rVKU1xdU7VVkgfB3GatB2EaFgvClISpEd58hF
         aUfMfxrdpKLgHx3aIJ4PzLG0uamWmTG8CwxD60TlkBQ1qURDZFpKkGAVdHIgpdBEakNs
         3MG1xdyHKOH2LReUqpH9tmB5Mq1fHCsj5OYl+zY7j1gsbVYabHqDM8bObkvAnDOwvz6q
         qKl6B6aI9o/5yxA4Omx1ohNAoZ6l/m2KiZsX7w3rmIgLUwc6gd1ZPcLF+8WFZHSQU+8P
         0G1MB3iDKF70kpQjZ2V25qdJtyZKQDHzHFlTbZ+h3yW0zFXJUT8XMFn/ADsmghR6aQJh
         5d+Q==
X-Gm-Message-State: AIVw112E5DOQTtacFUxGnq63GtYghd5gp6LjfFgsbbt5CuvRJJyTzcMT
        FvJ+6bwT8XUBfY36iOrXCQHZYgW7Pfr5rs9u/A==
X-Received: by 10.129.132.201 with SMTP id u192mr12332270ywf.256.1500873067199;
 Sun, 23 Jul 2017 22:11:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.41.70 with HTTP; Sun, 23 Jul 2017 22:11:06 -0700 (PDT)
From:   tonka tonka <tonka3100@gmail.com>
Date:   Mon, 24 Jul 2017 07:11:06 +0200
Message-ID: <CAEor4NHDNL4CQP_FpCuJ_3F86-A3P8i=yvp1AZr-NKt0i1=cXw@mail.gmail.com>
Subject: change the filetype from binary to text after the file is commited to
 a git repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everybody,

I have a problem with an already committed file into my repo. This git
repo was converted from svn to git some years ago. Last week I have
change some lines in a file and I saw in the diff that it is marked as
binary (it's a simple .cpp file). I think on the first commit it was
detected as an utf-16 file (on windows). But no matter what I do I
can't get it back to a "normal text" text file (git does not detect
that), but I is now only utf-8. I also replace the whole content of
the file with just 'a' and git say it's binary.


Is the only way to get it back to text-mode?:
* copy a utf-8 version of the original file
* delete the file
* make a commit
* add the old file as a new one

I think that will work but it will also break my history.

Is there a better way to get these behavior without losing history?

Best regards
Tonka
