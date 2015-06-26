From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 7/7] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 11:16:13 -0700
Message-ID: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
References: <1435337896-20709-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435337896-20709-8-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 20:16:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8YAn-0003od-Md
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 20:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbbFZSQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 14:16:17 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33502 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbFZSQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 14:16:16 -0400
Received: by ieqy10 with SMTP id y10so80993288ieq.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=s059pZzGu8+b2+FEmWkXs2pq1zNzjB8ptQNO2To59Mw=;
        b=VQyqK+JgC04a1XiP/2o1XHZonCJRx3SFfXbgImI3UNs9YVHVNPnAwNOScqGTRVD84f
         qLesOLdX+39ACWlbLSYpOV0iiJr+jUGNAXwMKj9GpmkjHRiHLG7nAj085AvL3Pr+oEh6
         fhzqEp2P2kdyaM9HtrWo7I6YA3TNQTxPbA2A9pjehkWQIb77ngiNh88AFIprWfSEaTZS
         r8+CyNoWgj/u5qxnEza/yts24sej6+L8MvTmwFe26JO2oQH2znY8Am8zzvQC8JfmS7qF
         YjuckJ3eHfEmMFtpNmHkSr461ShLGPoiNbWjNfb/j5cOQIlsTW3B4BbgeMUNeQc8ZFqe
         fHmA==
X-Received: by 10.50.64.243 with SMTP id r19mr5113284igs.5.1435342575918;
        Fri, 26 Jun 2015 11:16:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id qh9sm1315628igb.20.2015.06.26.11.16.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 11:16:15 -0700 (PDT)
In-Reply-To: <1435337896-20709-8-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 26 Jun 2015 18:58:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272810>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 24171a5..b1ef41c 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -19,6 +19,7 @@ on the subcommand:
>   git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
>   git bisect (bad|new) [<rev>]
>   git bisect (good|old) [<rev>...]
> + git bisect terms <term-old> <term-new>

I think this is the other way around.

Other than that, this round looked OK to me.

Thanks.
