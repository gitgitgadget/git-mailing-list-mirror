X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 19:43:39 +0100
Message-ID: <200611281943.40354.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <ekhrhi$g6t$1@sea.gmane.org> <456C809C.3050503@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 28 Nov 2006 18:42:20 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lC3A/2zBKNzu/8QemERCdyo8osfny8JwaZ3tgVnYKa+AsmTRY4fIYO8gsUQCXpc1mz38xWJyR3eTUIk/gvV0ZsTKIrFnsBx/wakzsOzIHPInxYNkWuqfTVe02hkRRcru75Rl+0Iam90le7gFj+WxxUpCFKo6dt0Y3U49ixycwLA=
User-Agent: KMail/1.9.3
In-Reply-To: <456C809C.3050503@utoronto.ca>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32563>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp7uA-0001rf-DH for gcvg-git@gmane.org; Tue, 28 Nov
 2006 19:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758737AbWK1SmA convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006 13:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758741AbWK1SmA
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 13:42:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:8065 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758737AbWK1SmA
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 13:42:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1560481uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 10:41:58 -0800 (PST)
Received: by 10.67.99.1 with SMTP id b1mr2102674ugm.1164739317644; Tue, 28
 Nov 2006 10:41:57 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 50sm19826207ugb.2006.11.28.10.41.56; Tue, 28 Nov
 2006 10:41:57 -0800 (PST)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Sender: git-owner@vger.kernel.org

Dnia wtorek 28. listopada 2006 19:31, Aaron Bentley napisa=B3:
> Jakub Narebski wrote:
>>>I notice that blame has an option to limit the annotation to recent
>>>history.  I can only assume that is for performance reasons.  bzr
>>>annotate doesn't need a feature like that, because annotations are
>>>explicit in bzr's storage format.
>>
>> But you don't have content movement tracking.
>>
>>>                                  I expect that even if we were to
>>>extend annotate to track content across files, it would still be so =
fast
>>>that we wouldn't need it.
>>
>>
>> I think not.
>=20
> There's no question that determining content movement could involve
> opening a lot of revisions, but you wouldn't need to examine:
>=20
> 1. revisions that didn't alter any lines being examined
> 2. revisions that altered only the file in question
> 3. revisions with multiple parents, because any lines attributed to t=
hat
> merge will be the outcome of conflict resolution.  (Other lines will =
be
> attributed to one of the parents)
>=20
> I'll admit though, that when I was thinking of this, I was thinking o=
f
> annotation-based merging, a scenario in which the number of lines bei=
ng
> examined is typically extremely low.

Well, I gues that with "annotate friendly" (weave or knit) storage
annotate/blame would be faster. But fast annotate was not one of the
design goals of git.

How fast is "bzr annotate"?
--=20
Jakub Narebski
