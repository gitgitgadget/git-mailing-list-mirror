From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Mon, 28 Jan 2013 01:16:34 -0800
Message-ID: <CAJDDKr4BT_1YnnfJv-YFHOpWhYpuA_5CMRw_hPTiowMr49RLKQ@mail.gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
	<5F78436DB1994B6DA686EC1BFA96B54E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:17:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzkpp-0004GW-9M
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 10:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab3A1JQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 04:16:37 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:58395 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab3A1JQg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 04:16:36 -0500
Received: by mail-we0-f172.google.com with SMTP id x10so1372930wey.3
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 01:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=hw2pc/mRFSAEM0IUnOggzhqhPruXtKe24HcxD+56mh0=;
        b=LKJhQHGe5vmtB5qeZ9cNC0U5jKZE5K8EcmBsyzVqIXb94ApQoXj0yPzSjbJqgQcmjA
         /l+uaacZ4a+dUsJO6ogGmHRBgOKgcT6CTP4JeG3bD8hBgnxB4i2fhT6ZC06iO3AorbgO
         dpe+l20L2FD6CMvqG48rAl2WBUn0dgMUlsnXCgeI6S/wNOmI+IDPF2i45pfg8CsLG3Hh
         Ioku/OLZA9PfPyFArT/Q3t04SnrMogQFT4Nq4C8MKekWpew+I3HfWa09Cx7govDe4rAl
         n6SE1UBgTijjyZzWRX1wJic+3gHEpr2uHJfMK3GL/9hQJMCTe6HOjuAZUprDmgD1o+op
         e2YQ==
X-Received: by 10.194.76.7 with SMTP id g7mr19851728wjw.50.1359364594359; Mon,
 28 Jan 2013 01:16:34 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Mon, 28 Jan 2013 01:16:34 -0800 (PST)
In-Reply-To: <5F78436DB1994B6DA686EC1BFA96B54E@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214821>

On Mon, Jan 28, 2013 at 12:20 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "David Aguilar" <davvid@gmail.com>
> Sent: Monday, January 28, 2013 12:52 AM
>
>> This is round two of this series.
>> I think this touched on everything brought up in the code review.
>> 4/4 could use a review as I'm not completely familiar with the
>> makefile dependencies, though it seems to work correctly.
>
>
> Does this 4/4 have any effect on the Msysgit / Git for Windows documentation
> which simply refers [IIRC] to HTML documenation made by Junio?
>
> That is, how easy is it to create a 'default' set of docs, rather than
> personalised documenation. Or have I misunderstood how it is working?

It doesn't have any effect on Msysgit. The resulting documentation
lists all available tools, on all platforms.
-- 
David
