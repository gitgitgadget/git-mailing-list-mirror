Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C5E202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 18:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932986AbdKAS7c (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 14:59:32 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:49017 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbdKAS7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 14:59:30 -0400
Received: by mail-oi0-f50.google.com with SMTP id m198so6022954oig.5
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tLquGilvhUnC/Am/6Ph/Dr3lcBMEwatoeuexiNLf/RM=;
        b=CUtMPNPsoCY5ZSVgBRSh/ZfTUqHtwr8NkFFNHOcMr8dIWEUmTO1Psupjk8TF3lkk+5
         LLcwuyLA+3EQqhG1rQ4lwYlTbafypMA/QA3u35fhn5G0Vxl3V8Roo5+ZLuRxUCoCVtqb
         MS88famFRoBEBOE5YEsfowe2OZkPyP81hAA7+EW+gT/anyEKcaXfBHfoqq+iVjUmhbZw
         LDv7pYpHIwncsMDeaTTiReZDjb/Xd8TkHaNPFqRQOAN7A/m7e7Klt4Hpa4v/6rVRdDk6
         NmqnWuBqqfjcDHDjxUE23YOf/+ZBNaAKGMDJ3iU7VqNcZ/MdacRYUzu6bZRVA1nDz2+J
         jniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tLquGilvhUnC/Am/6Ph/Dr3lcBMEwatoeuexiNLf/RM=;
        b=g3D5K07+7PQD1gPpcczmvv9PZVixKiMLWqMP9Y2HE42+kI8dk/It6kfXXCcdB11602
         h7D8sL6iV/Z7UJZKpV1J6MNxl1FIqRwa/DXZUHQnCZKjagVH/p3lwOb1SV0Zf/Y1pz3e
         oHVIoJb3/ZQdN7YNn2jS8dV4VwNUHBrXiIVxF2vTug4pM9+dVzubND3PWIqsNHFexNz5
         t6sLBzIsaHdRyoI3zZ/jGrEwZOxAIM85khi39aqVvfzl35TtbqpNfrZOpjsPer4J37rx
         Qd1FoO9jACYB05vL/O7iaiWB35MbTUO0bpy72Ao7vr0v3xhfsZWdsd8R4KFD4dkEthm/
         SKWw==
X-Gm-Message-State: AMCzsaVbHhbfjgCybSwWYMf27xASOZN4JAgyIcnsn5hwLtzXsMVjqK4/
        wR3jM+R4L/nyBccTnZkt/nQUdusk7CVFKGlu+QkJJg==
X-Google-Smtp-Source: ABhQp+RuuF7NQlINRjekXF2jeKjmZiVaOINwpH60VixO/QSAqch2Zis7MI95vHq8VT7YrMFTyrSDD+dUl9s3cj3Uu6g=
X-Received: by 10.202.208.7 with SMTP id h7mr487186oig.398.1509562769044; Wed,
 01 Nov 2017 11:59:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.42.110 with HTTP; Wed, 1 Nov 2017 11:59:28 -0700 (PDT)
From:   Matthew Orres <matthew.orres@gmail.com>
Date:   Wed, 1 Nov 2017 14:59:28 -0400
Message-ID: <CAKbB5OwxQ4XtLXuu2w3QmuKryA=3iHupz=y0m2E1NH+Dwzd8Xw@mail.gmail.com>
Subject: Git 2.15.0 on OSX 10.12.6: gui multi-select stage
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using 2.15.0 on OSX 10.12.6, when I open git gui, and then attempt to
stage multiple files as such:

* Left click first file
* CMD+Shift+Click last file to multi-select all files
* CMT+T (shortcut for Stage to Commit)

Only the file I selected with the first Left Click is staged and my
selection disappears.

I'd be happy to provide more system-level info if there's issues with
reproducing this on other machines.
