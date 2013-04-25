From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Re* [PATCH 5/7] git-log.txt: rewrite note on why "--" may be required
Date: Thu, 25 Apr 2013 10:47:25 +0530
Message-ID: <CALkWK0m2__SZmpyQqLjkJuMWtPuD4=Oo7QrYovq_Fw6fpHEXXQ@mail.gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
 <1366608631-21734-6-git-send-email-artagnon@gmail.com> <7vmwsn8ok4.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 07:18:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVEZR-00020D-De
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 07:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab3DYFSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 01:18:08 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:49619 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab3DYFSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 01:18:06 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so2331409iae.6
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6EjBwS6OQoHZsNh8o3z4dUtfXx3Sm7Z4UH5UM9jrRxg=;
        b=TES43Zx+7LRiQoqKvNg7Xq1mrm05Jdu705OEi5lqg3OiPxk7ma5V4z00ENohY9Myvp
         Wei6Qeba6xtIPrDAzKLs58NInR3vOS6haFF3vYuZ4D5dhL2phRq4O8BmEpr2yi9HLmOz
         EemZIH3TTAbBDIkeNekA1KQOvXSx5Cx26ChXbEcYG4i/Nu70lkplROi6e+cvm/eTxSIl
         2Ni/p+XrkXx48mBZjTzF4GSjGf72Ql+B1/HmdD7aEopBggamrcQBFPZzU5zfmZMFdhZQ
         7cTQPOAI7jQP1Q5cC5qfYojfA6/OhltsQsSulLKitMEm7Ho7nuX5O5slNceQjRDPLSXC
         pYSQ==
X-Received: by 10.50.72.65 with SMTP id b1mr4408531igv.63.1366867085824; Wed,
 24 Apr 2013 22:18:05 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 22:17:25 -0700 (PDT)
In-Reply-To: <7vmwsn8ok4.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222344>

Junio C Hamano wrote:
> It should be more like this [*1*]:
>
>         'git log' [<options>] [<revision range>] [--] [<path>...]

Agreed.  The backslash is unnecessary (I suspect it's something
carried over from earlier versions of asciidoc requiring this
escaping).

> It may be better to split the item into two, keep the current
> description of <path> under "<path>...::" heading, and have another
> heading for "--::" that talks about the disambiguation.  The "--"
> disambiguator is not solely for "your path might be mistaken as a
> revision without it", but also for "your revision might be mistaken
> as a path", but both the old and the new text are fuzzy about the
> reason what "confusion" it is cautioning the reader.

I agree that the "confusion" paragraph after [--] [<path>] can be
improved, but putting [--] in a paragraph of its own sounds like an
overkill.  Apart from other things, it means that every single git
command would need an identical [--] paragraph for consistency.  We
can just keep the footnote following [--] [<path>] in some commands,
using discretion.
