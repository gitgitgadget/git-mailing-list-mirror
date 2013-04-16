From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] fast-export: add --signed-tags=warn-strip mode
Date: Mon, 15 Apr 2013 21:50:42 -0700
Message-ID: <CAGdFq_gCeE8gRxmRYkGkm+kn6_Vo22_8g7+eLMuj-+pKjJjPcA@mail.gmail.com>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk> <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
 <CAGdFq_jCO_+qj87rtcFyFG2tot8Ah2706X2dm82F6=GBV-g6nw@mail.gmail.com> <7vk3o3nktl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxrc-0006pH-9v
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab3DPEvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:51:24 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:57439 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab3DPEvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:51:23 -0400
Received: by mail-ia0-f171.google.com with SMTP id f27so74136iae.30
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 21:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=l7rPaE6vq0AIAK4j1lAJKa0KgYfYsUGqUh8m/nyXgTI=;
        b=oZJLGz9AcW0C/9p0egy895tJkLBWFLn197f62JoxPzP9Qq3uMSjrAlwDhxAYd1M/yW
         GpkckavsNAsTJRVRJAa0jAgsIfCMh5M7RtsktvCFqLKrxEieIXlALhoQDBLNhL2KGai1
         1EOxzvHvfm82SBNb+Qvrqry+kmhJuM734nx6kf+uYsEKkLT12GVQOS8TtAPF9U1Z6OOa
         A0frLYrP8cfAnDJsjDstFhmtH/d1Ua95DsFIaIjtMYFplnUU3n+R5OinfBSyAabvJ1f3
         E2Hk67YmuIF5+x9h6JPBwjuqzHDQtpxaNJXh/bkfgq85F5Ci0a3qSfa9XDE27guWsi6/
         u59A==
X-Received: by 10.50.57.5 with SMTP id e5mr380765igq.57.1366087882958; Mon, 15
 Apr 2013 21:51:22 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Mon, 15 Apr 2013 21:50:42 -0700 (PDT)
In-Reply-To: <7vk3o3nktl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221364>

On Mon, Apr 15, 2013 at 9:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When you see 78 in the output and you know you have 92 tags in the
> repository, is that sufficient to let you go on, or do we also need
> an easy way to tell which ones are those 78 that were stripped and
> the remaining 14 were not stripped?
>
> There is no reason to worry about "some signed tags are stripped but
> not others", so it feels that the number alone should be sufficient,
> I guess.  If those remaining 14 weren't stripped, that is (at least
> at the moment) by definition because they are unsigned, annotated
> tags.

Or because they were not exported? Perhaps "78 tags stripped, 92
exported in total".

--
Cheers,

Sverre Rabbelier
