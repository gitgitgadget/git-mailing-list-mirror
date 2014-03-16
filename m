From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Sun, 16 Mar 2014 18:30:49 -0000
Organization: OPDS
Message-ID: <EA1EF5746EA7414CAE1320AA61100178@PhilipOakley>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Ramkumar Ramachandra" <artagnon@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 19:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPFpb-0000BJ-Vh
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 19:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbaCPSak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 14:30:40 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:61681 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755415AbaCPSaj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2014 14:30:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ak5LAHjsJVMCYJvU/2dsb2JhbABZgwY7EAODSoU+uTkBAQIBAQuBCRd0aQEBgR8BARQBBAEBAQECAQgBARkVHgEBHAULAgMFAgEDFQUCBSECAhQBBBoGBxcGARIIAgECAwGFOAcBggcNAwkMCbAZhVmUbheHPIEpjT81gkE1gRQEjzqbO4MtPQ
X-IPAS-Result: Ak5LAHjsJVMCYJvU/2dsb2JhbABZgwY7EAODSoU+uTkBAQIBAQuBCRd0aQEBgR8BARQBBAEBAQECAQgBARkVHgEBHAULAgMFAgEDFQUCBSECAhQBBBoGBxcGARIIAgECAwGFOAcBggcNAwkMCbAZhVmUbheHPIEpjT81gkE1gRQEjzqbO4MtPQ
X-IronPort-AV: E=Sophos;i="4.97,665,1389744000"; 
   d="scan'208";a="604249005"
Received: from host-2-96-155-212.as13285.net (HELO PhilipOakley) ([2.96.155.212])
  by out1.ip06ir2.opaltelecom.net with SMTP; 16 Mar 2014 18:30:36 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244205>

From: "Junio C Hamano" <gitster@pobox.com>
> --------------------------------------------------
> [Stalled]
>  ...
> * po/everyday-doc (2014-01-27) 1 commit
> - Make 'git help everyday' work
>
> This may make the said command to emit something, but the source is
> not meant to be formatted into a manual pages to begin with, and
> also its contents are a bit stale.  It may be a good first step in
> the right direction, but needs more work to at least get the
> mark-up right before public consumption.

I'm not sure what elements you feel need adjustment. At the moment the 
markup formats quite reasonably to my eyes, both as an HTML page and as 
a man page.

That said, the (lack of) introduction could do with a paragraph to 
introduce the "guide". I have something in draft..

I had a thought that it may be worth a slight rearrangement to add a 
section covering the setting up of one's remotes, depending whether it 
was forked, corporate, or independent, but the lack of resolution on the 
next {publish/push} topic makes such a re-write awkward at this stage. 
(Ram cc'd)

Some guidance would be a help.

>
> Will hold.
>
>
> * jk/branch-at-publish-rebased (2014-01-17) 5 commits
> - t1507 (rev-parse-upstream): fix typo in test title
> - implement @{publish} shorthand
> - branch_get: provide per-branch pushremote pointers
> - branch_get: return early on error
> - sha1_name: refactor upstream_mark
>
> Give an easier access to the tracking branches from "other" side in
> a triangular workflow by introducing B@{publish} that works in a
> similar way to how B@{upstream} does.
>
> Meant to be used as a basis for whatever Ram wants to build on.

To me 'publish' didn't fel right, though the later 'push' suggestion 
felt honest.
(http://git.661346.n2.nabble.com/RFC-PATCH-format-patch-introduce-branch-forkedFrom-tp7601682p7603725.html)

>
> Will hold.
>

> --------------------------------------------------
> [Cooking]
>
>
> * po/git-help-user-manual (2014-02-18) 1 commit
> - Provide a 'git help user-manual' route to the docbook
>
> I am not sure if this is even needed.

My rhetorical question would be "what should 'git help user-manual' do?" 
for the beginner, and do we have a sort of policy on ensuring that the 
majority of user documentation should be available (or at least 
referenced) via the 'git help' mechanism?

It feels odd to make the user-manual the one manual that can't be served 
via the git man pages.

>
> Will discard.
>

--
Philip 
