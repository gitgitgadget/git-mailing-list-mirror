From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Unexpected cherry-pick behaviour
Date: Sat, 14 Dec 2013 14:53:30 -0000
Organization: OPDS
Message-ID: <3FFF08967D2E480FA6B0E0EE3A72A8D9@PhilipOakley>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com><xmqqvbywts9d.fsf@gitster.dls.corp.google.com><7050e7272bb83d083a56a2c391228ed8@matos-sorge.com><CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com><beee32a53ece8b839578703deb851eaa@matos-sorge.com> <CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "git" <git@vger.kernel.org>,
	<git-owner@vger.kernel.org>
To: "Antoine Pelisse" <apelisse@gmail.com>,
	"Paulo Matos" <paulo@matos-sorge.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 15:52:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrqa7-0006nz-Rz
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 15:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab3LNOwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 09:52:36 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:5734 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753602Ab3LNOwf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Dec 2013 09:52:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtgYAM5vrFJOl3cg/2dsb2JhbABZgwo4g1iFPrAaAQECAQGBGhd0giAFAQEEAQgBARkVHgEBHAULAQEDBQIBAw4HBQIFIQICFAEECBIGBxcGARIIAgECAwGHXwMJDAmyIJBCDYcYgSmLXRmBeoJ1NYETAQOPHocNgxuLKoU6gyo8
X-IPAS-Result: AtgYAM5vrFJOl3cg/2dsb2JhbABZgwo4g1iFPrAaAQECAQGBGhd0giAFAQEEAQgBARkVHgEBHAULAQEDBQIBAw4HBQIFIQICFAEECBIGBxcGARIIAgECAwGHXwMJDAmyIJBCDYcYgSmLXRmBeoJ1NYETAQOPHocNgxuLKoU6gyo8
X-IronPort-AV: E=Sophos;i="4.95,485,1384300800"; 
   d="scan'208";a="430613160"
Received: from host-78-151-119-32.as13285.net (HELO PhilipOakley) ([78.151.119.32])
  by out1.ip04ir2.opaltelecom.net with SMTP; 14 Dec 2013 14:52:33 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239308>


----- Original Message ----- 
From: "Antoine Pelisse" <apelisse@gmail.com>
<snip>
>
> You can also have a look at what is currently being applied:
>
>    $ git diff :1:gcc/tree-ssa-threadedge.c 
> :3:gcc/tree-ssa-threadedge.c
>
> By the way, does anybody know a better way to do that ? I happen to do
> that quite a lot when fixing complex conflicts and the command is
> quite inconvenient (I always end-up forgetting which numbers to use,
> etc..).

Would this be a good use of the
    * Magic pathspecs like ":(icase)
that was recently released (v1.8.5  2Dec13)  so that the merge stages 
can be named.

I'm not sure that the three 'merge stages' have well defined short names 
yet though.

[1] 
http://schacon.github.io/gitbook/5_advanced_branching_and_merging.html
[2] https://www.kernel.org/pub/software/scm/git/docs/git-merge.html see 
True Merge 4.

Aside: the 'merge stages' terminology does overlap the common user 
discussion of commit staging e.g. $gmane/236127 (Officially start moving 
to the term 'staging area'). Any pathspec magic names should reflect the 
concept being indicated rather than the implementation - a thorny 
problem.

>
> Hope that helps,
> Antoine
> --

Philip 
