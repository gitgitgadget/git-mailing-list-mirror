From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 09:06:37 -0500
Message-ID: <CAMP44s1jtqGXhFN+KqODR-ooe1BiyQNVD=08nDF0poBc+madxw@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8BRYHkSj1YR9mW=_tdKX_+xKNxpVx+RNYEdoW3S36w=8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UimSC-0006I8-0F
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab3FAOGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:06:40 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:43927 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3FAOGj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:06:39 -0400
Received: by mail-wi0-f173.google.com with SMTP id hi5so1466902wib.12
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=59GCg20XGKbRl8Z2F6esQp2Vdr2sgIbUgBpEixA8ocE=;
        b=zvmA60uDIxXYFZZkCvEK+MrTZSc4WBHAVprmx93ci7Zt3rmXlAJoerMWNjoWpk2OAp
         v/zYOfCBn0LPkRJj/rzLquDgwlHqI4U/eZkoij6E527qbHsRHo/nf1V05Bx4UAFbeWCZ
         Mn29IRXR9WF45/TZ7X6+Knz0K+D/tjxEKNJXWOcSt66z3iZZfV6QMmFsT6KEjgsWLZy+
         ZBMgUX66a+YrY9/DUiyAOax3YoVCpDAGomiLK0kSmgA80PXaMYOkBip5rJzN/KfKIoLC
         qcHy0/1oW+xRyW+bqECq8huji/HZeDLQBrs3V/pOOgCE1Ntx4PF5w+h/krKa094wqR1y
         5zCg==
X-Received: by 10.194.122.225 with SMTP id lv1mr13289737wjb.21.1370095597956;
 Sat, 01 Jun 2013 07:06:37 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Sat, 1 Jun 2013 07:06:37 -0700 (PDT)
In-Reply-To: <CACsJy8BRYHkSj1YR9mW=_tdKX_+xKNxpVx+RNYEdoW3S36w=8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226129>

On Sat, Jun 1, 2013 at 9:03 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 1, 2013 at 8:51 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Nobody is checking for specific error codes; it's the errno that's
>> important.
>
> Have you just disregarded the in-code comment you just removed with
> one statement?

Who cares about the comment? As I said, nobody is checking for those codes.

> Did you check all its callers?

Yes, that's why I said nobody is checking for those codes.

-- 
Felipe Contreras
