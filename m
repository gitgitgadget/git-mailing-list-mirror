From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Wed, 29 Jul 2015 09:16:40 +0530
Message-ID: <CAOLa=ZS+UoPG_50-QBNUCfW03tXZwVE3Tabk15O=Q=2+SV_GzA@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-1-git-send-email-Karthik.188@gmail.com> <CA+P7+xpU4KdmutkGDdiAaXFpzs4zq=f2rXhqxqogAPJqopjdRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 05:47:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKIKp-0001Rz-QJ
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 05:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbbG2DrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 23:47:11 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34493 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbbG2DrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 23:47:10 -0400
Received: by oigi136 with SMTP id i136so4467745oig.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 20:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LXl1Q6RiSm+h4KQ1SKpkUOQf1BinYnmk8lX/DmeQrYc=;
        b=m3pzYwveM6kyFIqLc+685UEr2V5A5SuXT/q63vKMRLKwJpVTLJUBDP4EK5ZiI6cJr2
         IhC6DnmwoTr61IXooYyN/ezCcW70896CRfAt8p9ET0miI4U5koQnm2DtLUFH5o8iRqRU
         oUqzdnwi+tEIrjcmgLcdGuF8F270n9qxiNyMLnacSP1YIxGYuFsG2uBSpUDQ0POARvwN
         br7voPcr6XVgUAucnmqjB+qRu4g0ovRw3jePpEQl2MUsfDyExC/ALqgA8M0ZgvuXwbyP
         G+qGhXR+yYb4uN2Gx8UOOVOAgoJubk1DKWYLM5FOMfFwWsYHhJIzvXIK3riSGHYftVY/
         KAqg==
X-Received: by 10.202.180.133 with SMTP id d127mr36216097oif.104.1438141629571;
 Tue, 28 Jul 2015 20:47:09 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 20:46:40 -0700 (PDT)
In-Reply-To: <CA+P7+xpU4KdmutkGDdiAaXFpzs4zq=f2rXhqxqogAPJqopjdRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274879>

On Tue, Jul 28, 2015 at 1:27 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 12:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Make 'branch.c' use 'ref-filter' APIs for iterating through refs
>> sorting. This removes most of the code used in 'branch.c' replacing it
>> with calls to the 'ref-filter' library.
>>
>> Make 'tag.c' use the 'filter_refs()' function provided by 'ref-filter'
>> to filter out tags based on the options set.
>>
>
> This patch doesn't do anything to tag.c, so you should update the
> commit message to remove this or replace it with s/tag/branch if it
> was intended to be about branch.c?
>
> Regards,

Copy-paste error, thanks for pointing out.

-- 
Regards,
Karthik Nayak
