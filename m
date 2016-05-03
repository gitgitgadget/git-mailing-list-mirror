From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] remote.c: specify correct plural form in "commit diverge" message
Date: Tue, 3 May 2016 11:43:41 +0700
Message-ID: <CACsJy8Bqs5dnKc=VPeuqPZ4OUWVdhYNbewWc5rs-R3FGoZuQ5g@mail.gmail.com>
References: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
 <1462234350-30902-1-git-send-email-pclouds@gmail.com> <CAGZ79kayCBNn8e5TzD+zhPEopOVTvsTUfy=_9UGP43vktsdFLQ@mail.gmail.com>
 <CACsJy8C0mFfHQ+GSdJyXLc=SArnxKfZCFV7LJkoqEPs0ekzDZg@mail.gmail.com> <20160503042008.GB30529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	ernesto.alfonsogonzalez@ge.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 06:44:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axSC1-0000mL-8N
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 06:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbcECEoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 00:44:13 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36695 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbcECEoM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 00:44:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id y84so732322lfc.3
        for <git@vger.kernel.org>; Mon, 02 May 2016 21:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YjO6I0Gs0FRh8FzFWxrmvy9U4e2Hxgk5d/aieC8G2/U=;
        b=P71YBD6aH9BVCuOYvL0phtJuIGNdIqs8HSgCXHr744AqC9L4knMfivNqhmdmj6lIb1
         rH/gBEqX5+3rtLUXC8vna4J1WOeqvFQxiqo9FcbEwe8dzWg9c+q4JQGZ4GWvkAY/zsdP
         NLmUwr0KI99L4Mir6XIv5KzRXI+ILhjVwfjP1HkGEQWYDiZz//JWfOxxQ6Lf1VHh7Q1E
         jYbksMPzogxluhIbrzp9LhBmJy7gW2s+5LRxhZIY8Dh7Jywq0A2/WcLOMAdl9ObFh3t5
         4wgmwqPOcWCKiNRNMsPLD6mIAYdrKw4i9+oei2ZYUKEYhmljL3smGcRKwS6uSALNthIL
         +T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YjO6I0Gs0FRh8FzFWxrmvy9U4e2Hxgk5d/aieC8G2/U=;
        b=ewdMEXOBw7xUqKRcqjtJZ7qCfMbpG+YC3Ql5cfBu8KX6bHG+YPCI5pUoo03XuQQ9kE
         askn9c93VEFEFyjinWCuWrKOkUAlxj1ZkuovVNsHs3J4YR8iQTVe17N0Gc8jpqMNdKa7
         wDnqGZ0Kfv0AYA2NDvXEZMQqRVUuDEjg6DLpGR2BVDWyiZVSY/vfzzum1YFvYWOCZ8Bu
         U519RgLpQ3gK9TKV8xBSow63ZM/rupFa070E4k5oD/0Egopr23raszabzmi/hMe9clfN
         rGWXuXmhypcUTkN7pl9pOR0OUrpxzphTx43OXR6dGZZTNcx3l2j8dkjjSS3nJlgImaZs
         yiWQ==
X-Gm-Message-State: AOPr4FUSiDIH+lpwcZ8E+XhnF4VS/mLml55NSdami3SjL8XaMPNq6PiDDXI4xEH3dWqT739lmnV7JO/Jo34Vdg==
X-Received: by 10.112.199.198 with SMTP id jm6mr203223lbc.80.1462250650811;
 Mon, 02 May 2016 21:44:10 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 2 May 2016 21:43:41 -0700 (PDT)
In-Reply-To: <20160503042008.GB30529@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293321>

On Tue, May 3, 2016 at 11:20 AM, Jeff King <peff@peff.net> wrote:
> Note that I do not think the singular case can ever trigger with your
> new code. We know that both "ours" and "theirs" are non-zero to get to
> this message, which means "ours + theirs" must be at least 2 (barring
> negative commit counts, of course :) ).
>
> So you could probably replace the Q_() with just a _().

Problem is there are languages with more than one plural form (and the
winner is Arabic with six(!) forms [1]). So even if singular form is
never used, I think we still should stick to Q_().

[1] https://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html
-- 
Duy
