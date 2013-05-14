From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Wed, 15 May 2013 01:32:45 +0530
Message-ID: <CALkWK0nT-0LG2jaM+Y2R6+brYeFTuPsoDT+R17Ag_jnEwee32Q@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
 <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
 <CALkWK0nR1=Pgv0AY78p7n17C-VVvbc6BfJ4y_Df1ciZoc-xR-Q@mail.gmail.com>
 <7vppwtid3n.fsf@alter.siamese.dyndns.org> <CALkWK0=U8hySDc=OhQu6PjDNJ_fk3UBW8tmNowntghHS2-VbmQ@mail.gmail.com>
 <7vd2stibix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 22:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLRa-0002Sq-3z
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059Ab3ENUD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:03:26 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:34786 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENUDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:03:25 -0400
Received: by mail-ia0-f173.google.com with SMTP id k20so1152230iak.18
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=q5bqaptAIUOGxDm0Y4hJOnQiK9S+QeqvfWvi3fcO2cE=;
        b=0FqMHJFdb+Zw9PFi+9rdAiAVzBzvHP4d0zpvCFpN6Nee3iCP4ObqxBDn2PBAHS40S1
         ZJpqN9kyKZqnN5a5IhEKuskv11p/hMjT0pDf/RcEpEzMNrcdxRJsy45qyiLc8rTaWLbd
         LYmby4OYJeLoW4QQsUfw76/sLSRRxp8rgnxIKLQ1zYlQIYjy52Q8KpUv9bfyT9Fh+TUV
         gs7AJ3ofqNZk+KQc1HvEiRXgygUQCggapTL9b4CTFTXGd2iufeR0a2c0CihzokrLhO2Y
         lS8xhVMfgY4NLDdwwl3GxT0PGCWtOSELzLPgAX3KutaG6+qFU13KxTUaPNpIPyyg/vrj
         LUpA==
X-Received: by 10.50.33.19 with SMTP id n19mr3326632igi.44.1368561805321; Tue,
 14 May 2013 13:03:25 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 14 May 2013 13:02:45 -0700 (PDT)
In-Reply-To: <7vd2stibix.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224330>

Junio C Hamano wrote:
> When a commit moves a file wholesale without affecting the block of
> code you are interested in, you know that whole block came from the
> file in the old tree at pre-rename location without looking at
> anywhere else.  That is why renamed but pickaxe-uninteresting
> filepairs are dropped.
>
> When a commit moves (some lines of) the block of code you are
> interested in from one file to another, it may have been a single
> instance moving to another place, but it may well have been multiple
> copies consolidated into one (the new copy, pickaxe digging from
> future to past may see "disappearing").  That is a significant event
> worth digging into further by first stopping there and then
> inspecting the whole change with --pickaxe-all to see what changes
> that are similar to the change in question exist in the other parts
> (notice the multiple) of the tree.

Makes sense.  I wasn't looking at it from a macro perspective.

Yeah, I constantly re-read 217 and your follow-up.
