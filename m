From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Mon, 27 Jul 2015 07:39:58 +0700
Message-ID: <CACsJy8Bq3y25QsQbntpNcVz=TQziiXY-XQ88Y_Cps10YF8zrJA@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-2-git-send-email-Karthik.188@gmail.com> <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 02:41:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJWUN-0007YI-Iw
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 02:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbbG0Ak3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 20:40:29 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37952 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbG0Ak2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 20:40:28 -0400
Received: by iggf3 with SMTP id f3so57050242igg.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2015 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lUWhumeFosm1RomL1gCiLJAxKBjdj+tSLhWI+/TJjk0=;
        b=f6iN6XFWtDkTegQtNMHaWeSshSUoooXknGDVlxD5A/S5zEJzQSMJI313D0oZk4M0fj
         2uj5ebERPgaz5Av6Q9qoaBE2SAUY9D2pkD9w1rhjZH3J31FajEK9JmbC3R09dW+aZ9D+
         izSdexenixaX9mkxccGlJ4EGUCN63H8YWW8+7bpImg3iNY2Ctd0JS5z3CV10wYI38LzD
         27kTpDh7T/lHbGinRk905Lu1uUhU+SLcRbURjOSy53PbDM3TlNwZcf/BLl/tiUVdWyzk
         6/3p5BAavGlsA0S5eRlAfNqI97LRwyMf7vTs+YeW1PuiPOLrk6V2aPM4GotIWOl3KarQ
         qiIQ==
X-Received: by 10.50.142.69 with SMTP id ru5mr13770864igb.61.1437957627929;
 Sun, 26 Jul 2015 17:40:27 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Sun, 26 Jul 2015 17:39:58 -0700 (PDT)
In-Reply-To: <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274646>

On Sun, Jul 26, 2015 at 11:08 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> You can generate an interdiff with "git diff branchname-v4
> branchname-v5", for instance.

Off topic. But what stops me from doing this often is it creates a big
mess in "git tag -l". Do we have an option to hide away some
"insignificant:" tags? reflog might be an option if we have something
like foo@{/v2} to quickly retrieve the reflog entry whose message
contains "v2".
-- 
Duy
