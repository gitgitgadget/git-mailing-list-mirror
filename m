From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v4] blame: add support for --[no-]progress option
Date: Mon, 23 Nov 2015 19:10:06 -0600
Message-ID: <CAOc6etaxxLUio4yt4aYuG-3xFCXMHqSHKPbxnE43hXuVuGQ-zw@mail.gmail.com>
References: <1448327277-29385-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 02:10:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a127Y-0003lB-I5
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 02:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbbKXBKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 20:10:07 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33146 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbbKXBKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 20:10:06 -0500
Received: by pabfh17 with SMTP id fh17so2674003pab.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 17:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1PkKREwg+WweW5FfUhC4GajOMy9Vg7QeBWgtKTGIpes=;
        b=TuLp9lbdh+2CyM/F1t5T8RJUBotgjMu1rTSnvzBYMu5AkPrE9UjnP6B33a4e02LQEL
         SNqj89elhZPYsUHe/HHJFGZwH6SuzfUM+pHlwnJrLCU72cWYi06vrUpPxljpYyUl+I1G
         CMBJzonpqP6WqFPFArMDrBGd42YpF5tDUPSKslPmW1k/vT4D4ObgkZ9RNMqt5FMI3PGg
         Lst5d/ddB97Qx/q/Er5gQ/6pKRV8xvjAV8ZU9HAbomvdgJeVFgijm2e93AQK1CxRDgtc
         CLUjEh2JJ67f4MZ3Jvabe8fuxZguIG6rf+aJ1hDNxlvy6Qpr5kL5yrXbKiQ1u4xc7Pep
         PcKw==
X-Received: by 10.98.1.6 with SMTP id 6mr19449774pfb.132.1448327406471; Mon,
 23 Nov 2015 17:10:06 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Mon, 23 Nov 2015 17:10:06 -0800 (PST)
In-Reply-To: <1448327277-29385-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281606>

On Mon, Nov 23, 2015 at 7:07 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>  {
>         struct rev_info *revs = sb->revs;
>         struct commit *commit = prio_queue_get(&sb->commits);
> +       struct progress_info *pi = NULL;

Switched to using  pointer to make it more elegant.
