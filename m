From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv3 03/13] xread_nonblock: add functionality to read from
 fds nonblockingly
Date: Mon, 21 Sep 2015 23:27:45 -0700
Message-ID: <CA+P7+xp-D-N8W7GL6Rp9F-GHJ5O5jS6_icqB4DQGsiU5Zn5HEg@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com> <1442875159-13027-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 08:28:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeH3k-0006wn-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 08:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777AbbIVG2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 02:28:07 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33032 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147AbbIVG2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 02:28:06 -0400
Received: by igbkq10 with SMTP id kq10so93906089igb.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 23:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rRHuid7Kq01gtSF57Nwqvrh8FtE0e6ucAAZR4ZprYoE=;
        b=b8fMHTPey+arxYOdeAfyMIwGDOh3p+omPm36QmAG0nzfshC6mp5IGxqsD3vQc6rbQz
         lG4tzGT/CHYOYDGrKVyT3th7qhD6V9dMsqK2UwOxkZi82UTH97jepNZEMWaKGMrRpOa7
         q8FrtlD1z2bzrYXltHw5gaQQTIOjUr7FVOjebzK5drMpqG6oOaeOSHD9VqOnI7Hpi0RM
         fDLZ8zSyq/400Dy1kLt3BkCDpJxDQjIn/gR5Lzy4ULyXGd1aPCQ0KDJL+rPR9FRMutfj
         zAQBN+/xHqHF+UttRSK1NotAaFo1psxQ0RaTmbkIxxqUA3ApJaxKIimgUo8sPR34NQ9v
         bgdg==
X-Received: by 10.50.70.106 with SMTP id l10mr14142688igu.73.1442903285121;
 Mon, 21 Sep 2015 23:28:05 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 21 Sep 2015 23:27:45 -0700 (PDT)
In-Reply-To: <1442875159-13027-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278380>

On Mon, Sep 21, 2015 at 3:39 PM, Stefan Beller <sbeller@google.com> wrote:

Maybe change the title to "without blocking" instead of "nonblockingly"?

Regards,
Jake
