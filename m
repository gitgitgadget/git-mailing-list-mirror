From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] bash prompt: test the prompt with newline in repository path
Date: Fri, 16 Aug 2013 19:44:07 -0400
Message-ID: <CAPig+cTRKs8_f4Acg6=Le=_ePb1MroL61XUXa9bZG0HKYgrL7w@mail.gmail.com>
References: <1376649395-24363-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Aug 17 02:13:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAU97-0007Sh-Cl
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 02:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157Ab3HQANW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 20:13:22 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34941 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab3HQANU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 20:13:20 -0400
Received: by mail-lb0-f181.google.com with SMTP id o10so1793666lbi.40
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 17:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=MYRCAO65BC7xCuipXXBi6GIYWeAgfCmoe8lWC5FJ8oQ=;
        b=k7fLN7ymWSIqteV27aV6BFh/Erwc63hnEYwa/GqNm0YhbsVJ1sgHEvwcv3xAbiuSlL
         rNxrxmWlRSdLQRdmRXv6YfiRJYSsKTn6tZzaa0xh8rkFKBwRcrsNYNhQYI9spLOdKRVe
         ptyr9jmZBwe6diMwDjVdTIKC/+rnR4wq4Tqm8HgR3SgiT83DaQYN62bduMZ+/jQ1u6Pj
         PSzmPY87+K5cKnDGoM5EJUYyOms3sBQIaYEaxkCpF28P/g2CoZVAeVoXr2Ec0qE0EIok
         TT39rArWvFl5bTpYMjQmAaPXKXahnG7N1OOyn5Fz+nCj2tJDWpbzL0yYFGeD47vnpPT+
         3uUA==
X-Received: by 10.112.87.68 with SMTP id v4mr152516lbz.2.1376696647755; Fri,
 16 Aug 2013 16:44:07 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 16 Aug 2013 16:44:07 -0700 (PDT)
In-Reply-To: <1376649395-24363-1-git-send-email-szeder@ira.uka.de>
X-Google-Sender-Auth: xKnDNux9h7_5YW157PPou_0YgAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232448>

On Fri, Aug 16, 2013 at 6:36 AM, SZEDER G=E1bor <szeder@ira.uka.de> wro=
te:
> This subtlety really warrants its own test, especially since I didn't
> explait it in the log message or in an in-code comment back then, so

s/explait/explain/

> add a test to excercise the prompt with newline characters in the pat=
h
> to the repository.  Note that 'git rev-parse --git-dir' prints '.git'
> or '.' when at the top of the worktree or the repository,
> respectively, and only prints the full path to the repository when in
> a subdirectory, hence the need for changing into a subdir in the test=
=2E
>
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
