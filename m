From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 08/19] parse-option: rename parse_opt_with_commit()
Date: Mon, 22 Jun 2015 21:08:41 +0530
Message-ID: <CAOLa=ZQZ763F9AFpkGZ-ay2_q_3YCYXMuf_gYg-sQd=N-kyebA@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-8-git-send-email-karthik.188@gmail.com>
 <CAPc5daVpqDC4K6ne=E_cdzG0NhfEYLucWdxVwKMf9WtDxzPUnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 17:39:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73oa-0005VZ-TX
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbbFVPjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:39:12 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34777 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbbFVPjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:39:10 -0400
Received: by oigx81 with SMTP id x81so124406762oig.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=st88ktvMyqsO2LFgQ3Yb2pz0k1pPFZkRznyeMFAKN5U=;
        b=zBnmQEI0SPwPJKTzcGALdQBLGv1MkpdBZJ1PvbAT0GkEEucD6M2ISrZeKnVBJb32ua
         jLZskCxxSDUzy5TrOgzmExrfXtwAuJdUrY6Zb47udHuGY77/SNeWALYlZIB9YNbH5mo/
         aiWKkyr0WGSuc+lGjsehLMGwi80FID7LBLPQtyrkcWEzJKDaVbPOGSwtucZR62GJoLgH
         rBbs5OKWo1h5Zes+Ac4fcVZnOVAnZNwE5WZ4JQV2rYQaT876LQgfczIbVaPYg5+YcYvP
         YVZpu3C6KILrisA0xRnHW6Wsmk9W5fSA/T0qUMd61JX/lgbPiHx3T2uM4iizkXfdbizA
         BWqQ==
X-Received: by 10.182.22.33 with SMTP id a1mr25418827obf.41.1434987550378;
 Mon, 22 Jun 2015 08:39:10 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 22 Jun 2015 08:38:41 -0700 (PDT)
In-Reply-To: <CAPc5daVpqDC4K6ne=E_cdzG0NhfEYLucWdxVwKMf9WtDxzPUnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272391>

On Mon, Jun 22, 2015 at 6:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Sun, Jun 21, 2015 at 1:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Rename parse_opt_with_commit() to parse_opt_commit_object_name()
>> to show that it can be used to obtain a list of commits and is
>> not constricted to usage of '--contains' option.
>
> I think that is a brilliant idea, but unlike the other function you
> added earlier
> that can do only one object and adopts "last one wins" rule, this is cumulative,
> and that fact should be made clear to the developers in some way, no?

Will add a comment :) Thanks!



-- 
Regards,
Karthik Nayak
