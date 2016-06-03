From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Fri, 3 Jun 2016 23:16:41 +0100
Organization: OPDS
Message-ID: <6C6F62CA4181453BA51BB362DAA5C0C1@PhilipOakley>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org><1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org><9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley> <xmqqd1nyqnr6.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	<git@vger.kernel.org>, <erwan.mathoniere@grenoble-inp.org>,
	<samuel.groot@grenoble-inp.org>, <tom.russello@grenoble-inp.org>,
	<Matthieu.Moy@grenoble-inp.fr>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 00:17:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8xOu-0001oB-Lh
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 00:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbcFCWQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 18:16:49 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:14691 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbcFCWQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 18:16:46 -0400
Received: from PhilipOakley ([2.96.202.56])
	by smtp.talktalk.net with SMTP
	id 8xOUbn9JKUnEI8xOUbWTQn; Fri, 03 Jun 2016 23:16:43 +0100
X-Originating-IP: [2.96.202.56]
X-Spam: 0
X-OAuthority: v=2.2 cv=btQOPwSi c=1 sm=1 tr=0 a=Gr2UeF9n3zA/PrLseKPsnw==:117
 a=Gr2UeF9n3zA/PrLseKPsnw==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=XcpDTPfKAAAA:8 a=LWSQNB7Wj_Lb_rZ8Y68A:9
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=JBJrJOrNVNaeAkU5v-im:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPox3e0XpuM3ZDDZmLX0OeLCCWN8ie8Prmcsu2mg+8epoQq3Hqw1GJ46BiLr11Yr/SSAsY2oLdIwouMzI1ERtjo3C65+9vDWytvQXSlUggFksD4/dwqs
 giOPKRcS+ZDUFW7b/lVGhHibDuTOnpebJLRX7cQg8m2aAJP4x+2zt+QbUapygTYD1zR3aO34QPRu8h2ZTGghpj0PoU3xTX9Hpn63mL8SM6hOaqlVXsEKUAbT
 9lAu4DN4cdemLsRRaj+YLK+gH/yjy8WpLyKep8K4qsh0vbNV9rSv4UGWjdRfCoBq9vQ18o6jjfBkT9Jka2frwIuupcXL0pkzOdO0kiHUd6xL2ICIKIKNS7L4
 3UYLDDKDjxVQSMabaBYinm+tEKgfrv/C0wlclN1i1dTNAU/YWHx8YMd/t05NtmIBM4H1xqro
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296419>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> That said, trying to find a good name for that 'third place' is not easy.
>> It's neither upstream, nor downstream (for Junio - the maintainer special
>> case - git.git would be his downstream). The me/git repo is like a
>> ferryman's landing across the other side of the river flow, a safe 
>> harbour
>> if you will.
>
> You raise a good point here.
>
> To me, the git.git public repository that everybody pulls from is
> just like me/git for everybody else.  It is a place where you
> publish your work.  I think the @{push} notation during its design
> phase was once called @{publish} instead.

I'd agree that your git/git is actually an @{publish} repo, and to my mind 
is a formal 'downstream' for you.

However your gitster/git repo feels like it would match the me/git 
viewpoint, in that while it  is 'open', it isn't really a formal publishing 
place. Certainly I don't think that I 'publish' what's in my personal github 
repos, which I use as an open backup (and any PR's I put to the G4W project 
repo are referenced from there).

I did have a look at various thesaurus words 
(//www.thesaurus.com/browse/repository) that might be usable and found:-
depot, haven, shelter, sanctuary, wharf, bunker, vault, which are all 'near' 
but not quite right, if only home-depot wasn't taken I'd suggest that!

>
> A "downstream" that is the opposite of "upstream" is not something
> you would configure and control.  They are those who call you
> "upstream".  You know and actively configure who your "upstream" is
> and pull from there.  You do not have direct control who are the
> people who are pulling from you.
>
> So in that sense, "downstream" exists as a concept that is just as
> valid as "upstream", but unlike "upstream", "downstream" does not
> manifest itself as something you explicitly tell Git about, either
> from the command line, in the remotes definition, or in the
> configuration files.

Certainly for contributors, a configured 'downstream' repo doesn't make 
sense, but I do think it's worthwhile for maintainers, Leiutenants, and 
dictators who do have a specific publishing place. 
