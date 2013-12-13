From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] send-pack.c: mark a file-local function static
Date: Fri, 13 Dec 2013 07:58:46 +0700
Message-ID: <CACsJy8DnVUc2xQGD4hr2tuFhaGj4kuc=63xxmmUwq1bkFtztOw@mail.gmail.com>
References: <52AA43AA.9030703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 13 01:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrH6B-0001hE-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 01:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab3LMA7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 19:59:20 -0500
Received: from mail-qe0-f48.google.com ([209.85.128.48]:36390 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab3LMA7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 19:59:17 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so1045290qeb.21
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 16:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8y7LOA9XXoh+u5kfuqUNwffMib+X+Yc71yN9O6jISP8=;
        b=DYiI0Xdo9vPlXhXTGBtUg/kWO+FASKvlmHj17Gwccxv8W6fs7HSE5NhhC1S1RGjUbt
         4DDato6lcDXFLWn7FXT8RXWoRQqmqpqxoZFKpEDk7zOS0YPWBaktvid2shYhDFGGbUr5
         o+tQJzXenxR4/7eltt6qck4CjyGN/uMTTO1OZ7YQ7nDbEzIADo+tylMMrNuYi/r3b5b5
         cn7gA6k8AeF+1CX0Kxg595yi+9oIZw2SWylym9iVgbCjwP2yQtaZ37kR6M2aevWg7tZT
         R9nLiUxHyX77BFcSYIrYKyWX43ffD56oMw3J456xaKBiX1DkWY3E4lgmHrqvsGrxPzgv
         UhLQ==
X-Received: by 10.224.61.1 with SMTP id r1mr11244621qah.97.1386896357124; Thu,
 12 Dec 2013 16:59:17 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 12 Dec 2013 16:58:46 -0800 (PST)
In-Reply-To: <52AA43AA.9030703@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239253>

On Fri, Dec 13, 2013 at 6:15 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> BTW, I have not been following these patches, but I noticed that the
> 'remove_nonexistent_ours_in_pack()' function has no callers. (There are
> two commented out callers - but they seem to have *always* been commented
> out ;-) ). So, step 5 is no longer required? :-D

It's more of an optimization than a requirement, to avoid expensive
calculation later. Uncommenting is possible but I need to pass the
pack file name around a bit.
-- 
Duy
