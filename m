Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3652920133
	for <e@80x24.org>; Mon,  6 Mar 2017 15:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbdCFPjR (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 10:39:17 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33343 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753642AbdCFPjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 10:39:14 -0500
Received: by mail-yw0-f182.google.com with SMTP id v76so23199657ywg.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 07:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=VSI27i4AAmuJIrfTw2+ZMb4DGQ/w1BB5n2xfJUXX66g=;
        b=Tb7TsSc4W28QRBelOhhmanxjqmTGNVyc6agBErpTUbUjLdOWZNqxYGnCTdrIzOnvx2
         pWRfmFseW0sg8G/sIQl1LhH59BH7V8h35ttHnEJiOcHQAXem05kWEAoxPvAtvcZItgYd
         3/JXh4WVwCo3LTtHDMXiulu4OYhb6isNPKIlwbL7IYz8Dsoeubx8isjCQQto/dVQekY2
         wLXAp7bd7PQNQO8qPGDgTk3HFzwZwdRoon8AEKT4LIb6pZyaiJsPGK0IJ9hapPQrYgMH
         z8Gb/t6imN0YclaspT72Iuxi68S0AEa5koRn07eEWqR2HEXZI7kXODEi6URqe6TjHwTq
         Z9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=VSI27i4AAmuJIrfTw2+ZMb4DGQ/w1BB5n2xfJUXX66g=;
        b=kxSo3p3HwrWtss80n2MP3PaPB1NEQ7baq/WBW0lsj0zynky3pne2kw2SFwGIDqWHVF
         t/jWidJuyJxo2x9nF4gTI62mJaB0F3lvvuyA+7u1BPTkthpo01T3xkxGffz+clT3QIZ3
         KQIyesgx7ucR5lo5/L42Vvv6P6DLHmV4V8imd76R7WaZLTnX+Z5OjfJA4MfQKkJJo6fq
         wXZJjT0BXXTooBgdT/x6XyyP8oSZ/3g+/FNOK2/q6OMyfgCzsCM/yuLE0mOXa9113g3+
         Diq+qynjwvTQMISssu80QhUHn+dz+6WYXbVYxu/+1QjnigyurWX2KzbDU4ihigIkNOGT
         YjiA==
X-Gm-Message-State: AMke39lRxkVm/nJpwIYx1FjH6JtWjoejMxDSqeIHRYpCjMLemrOA39R36UJNUhlI+0hXpB1TG1lqRPr5A0DZOA==
X-Received: by 10.37.171.139 with SMTP id v11mr11346036ybi.45.1488814743587;
 Mon, 06 Mar 2017 07:39:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.3.211 with HTTP; Mon, 6 Mar 2017 07:38:33 -0800 (PST)
In-Reply-To: <CAOJpByWRg1V85CJsX2akuvbKuqFBoGJO+XJu01Kq0KNwuM-YFA@mail.gmail.com>
References: <CAOJpByWRg1V85CJsX2akuvbKuqFBoGJO+XJu01Kq0KNwuM-YFA@mail.gmail.com>
From:   Christian7573 <cag4561@gmail.com>
Date:   Mon, 6 Mar 2017 09:38:33 -0600
Message-ID: <CAOJpByWFKbWE=HtNVpqDgfoqo1ajNttstNpRaUHT7a5AjObuJg@mail.gmail.com>
Subject: Fwd: HTTP Dumb Push?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a way for git to push to a server using the dumb protocol?
Perhaps using the PUT method to upload files?
Just wondering cause I just set up a dumb server and pushing to it
doesn't work. If that isn't an option, where can I get a smart server?
