From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Mon, 5 Apr 2010 09:46:47 -0500
Message-ID: <k2lfabb9a1e1004050746if7efaa74k62be6c1f3f97053@mail.gmail.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com> 
	<1270392557-26538-1-git-send-email-avarab@gmail.com> <20100404224324.GB12655@gmail.com> 
	<y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com> 
	<7vy6h2wsvg.fsf@alter.siamese.dyndns.org> <h2rfabb9a1e1004041915u3754016cr10e874c12f2a24e6@mail.gmail.com> 
	<7vy6h2pn51.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 16:47:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NynaA-000736-2F
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 16:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab0DEOrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 10:47:12 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:60331 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab0DEOrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 10:47:09 -0400
Received: by gxk9 with SMTP id 9so3000665gxk.8
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=mvjmUmCkr3uSBflpAS/1y8AfyQhyNRAIJL/UodMGS0c=;
        b=EKG9eN39hQStvqKTT+8nXpinacyXVn21zxGZEWOkEOKJgNxqn0GkFNHiig14jKGsub
         CmMQYJlqTiBxILJcu8+Xv5sXmV0MVWvNJgcK81eBSvRe36Ey7NJ6+p5E17LP0K+9jt5N
         gQy6etaoPuxe+7IcAEvYWWQMQOmapQn8GZBc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=g6i8zqsXT6RKor/yStJOLe9mMM3j43hxNg40OK7CQXu0ej4xiMp/F56RWc21EnzDHl
         Fjku/FpyUcLnWY0RVsikc9b2jZI/+R4uEc9foFsaFyyycoI7ashfWHRe/wMDOIiGZBYO
         VRUVdfXlUagg0RHkIFk6ZM7QPgS+6ihxyOZXw=
Received: by 10.100.206.13 with HTTP; Mon, 5 Apr 2010 07:46:47 -0700 (PDT)
In-Reply-To: <7vy6h2pn51.fsf@alter.siamese.dyndns.org>
Received: by 10.101.135.38 with SMTP id m38mr6945043ann.248.1270478827281; 
	Mon, 05 Apr 2010 07:47:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143988>

Heya,

On Sun, Apr 4, 2010 at 22:57, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> You contradict yourself:
>
> I personally don't mind very much removing --allow-empty, though.

Ah, hmm. I vaguely remember some discussion in the past about empty
commits, but I'm not sure what the conclusion there was? I think it
was something like "if you want to create a marker, use tags instead,
there's really no reason to be using --allow-empty". Wasn't there some
use case for "--allow-emtpy" when creating an unrooted branch with an
empty starting point, or somesuch?

-- 
Cheers,

Sverre Rabbelier
