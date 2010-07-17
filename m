From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2010, #03; Fri, 16)
Date: Sat, 17 Jul 2010 23:15:04 +0800
Message-ID: <AANLkTimx6k1Dy4tAsKDn7RliZdJTqggqufS9Ap4DYY_0@mail.gmail.com>
References: <7vaapqr6a7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 17:15:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa96t-0004FJ-Bm
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 17:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994Ab0GQPPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 11:15:22 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64753 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034Ab0GQPPP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jul 2010 11:15:15 -0400
Received: by qyk35 with SMTP id 35so807115qyk.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gPAjai7Rh/9HSlrobuMf3B+/voXLUVbLK5qS3o+0zUY=;
        b=bb8Z2C5eD9vS0XXhuI5HvLHFP9lizGuQLCfQuseLpQk9QqMTPlodSg67uzfCZJfkgG
         hEJ6oov0sAgJ8bm+bSfT4+N8gdeIWdpXmAA/ekX8jFub3J/zyZXVdOCo+zwFFWiCFg0Y
         LoWnc/vvAZRoN6YvSRBD5WhSAytA1eT/o+2FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IC+LAhRfqRQBmZPPy/HxDIaQlB4J/Uz1cs7Vs92uHP51VAkrtdF8CqbqPyPnt959/2
         OLXV8hkaaypSQwzsOcWnrAPyyfQz4oVtKSpmNW4gpFdMS7W8JyYZaZb7kW+z7sNhjiIn
         0VmlUGXL+No4MiUsBjyPtGvAzYlsSCc+os1wg=
Received: by 10.224.65.91 with SMTP id h27mr2062047qai.13.1279379704713; Sat, 
	17 Jul 2010 08:15:04 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Sat, 17 Jul 2010 08:15:04 -0700 (PDT)
In-Reply-To: <7vaapqr6a7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151185>

Hi Junio,
On Sat, Jul 17, 2010 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> --------------------------------------------------
> [Stalled -- would discard unless there are some movements soon]
>
> * by/log-range-diff (2010-07-12) 18 commits
> =A0. Minimum fix to make by/log-range-diff topic at least compile
> =A0. add test cases for '--graph' of line level log
> =A0. line.c output the '--graph' padding before each line
> =A0. add parent rewrite feature to line level log
> =A0. make rewrite_parents an external function
> =A0. some document update
> =A0. add two test cases
> =A0. add --always-print option
> =A0. map/print ranges along traversing the history topologically
> =A0. print the line log
> =A0. map/take range to parent
> =A0. add range clone functions
> =A0. export three functions from diff.c
> =A0. parse the -L options
> =A0. refactor parse_loc
> =A0. add the basic data structure for line level history
> =A0. parse-options: add two helper functions
> =A0. parse-options: stop when encounter a non-option

I will send a new series of this patches tomorrow. I have several
graduate parties these days, so I am sorry for the delay!

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
