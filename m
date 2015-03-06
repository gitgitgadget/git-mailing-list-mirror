From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 6 Mar 2015 18:24:34 +0700
Message-ID: <20150306112434.GA10703@lanh>
References: <20150218191417.GA7767@peff.net>
 <54E6C78D.3070506@alum.mit.edu>
 <20150220072924.GC8763@peff.net>
 <vpqpp94exb5.fsf@anie.imag.fr>
 <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
 <CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
 <75FBE31490904D8EA82F5C445F1F33E1@PhilipOakley>
 <CAPc5daV_igiExbvY1eH0T2SKxgawO86F0eZyoai_QK-dXc5fDg@mail.gmail.com>
 <CAGZ79kZzB8-r2a4VGG23GL1ZqxY7c34391vMwVr09MnCV6Hqcg@mail.gmail.com>
 <xmqqsidk3r17.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:24:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTqMW-0002eB-8V
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 12:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793AbbCFLYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 06:24:06 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:41594 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783AbbCFLYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 06:24:03 -0500
Received: by pablj1 with SMTP id lj1so44653224pab.8
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W4DX0uZvjJG6nvnNNWZWl9CXGU0oufY6n6itzM9LPME=;
        b=YzXsJnoJK9v4T/Tb50at5O8IZX58tVkJFa+CMT11ZTyll+nB9ItWptLaAinbLM4Are
         7fqPkW0panaA+CM/KOZ5R4iDzj43LzxlUL5T6QMe0MFfdYO5/D5gJEYbU2Y6YxKMoerl
         GfNs/Zs3a8BlsRhr2X0hVN5ALT71GBwOWyPPE9KZD3TN9sxDZ8apgoUVGj4URpSYmcPk
         +U4nOd0oZYi6YPfnbsNVSa5yvfxnlrp776bl9IZl0PBD8T7OCyPv2yeGVazYlqanMtFH
         LmTSs+KHqtuktipdlx3mvRMETUjMl+u9EykcoNDeGN3gzBjrwb9BbhxCP5+tSO29sx13
         RFBg==
X-Received: by 10.69.16.234 with SMTP id fz10mr24569169pbd.53.1425641042502;
        Fri, 06 Mar 2015 03:24:02 -0800 (PST)
Received: from lanh ([115.73.230.115])
        by mx.google.com with ESMTPSA id 7sm1759142pdj.16.2015.03.06.03.23.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2015 03:24:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Mar 2015 18:24:34 +0700
Content-Disposition: inline
In-Reply-To: <xmqqsidk3r17.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264912>

On Wed, Mar 04, 2015 at 10:19:16PM -0800, Junio C Hamano wrote:
> But we would need some way to say a set-based cut-off; I do not
> think using --since for that purpose is a good idea, though, because
> that is already taken for date-based cut-off, and mixing them
> together will introduce confusion.

I agree. Although I look at this from the implementation perspective:
mixing the two would make it really hard to detect which is which.
Speaking of implementation..

On Thu, Mar 5, 2015 at 5:28 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> I do have plenty of topics to finish up. But I wanted to see how this
> feature would look like. I needed to write some code for that and for
> straightening my thoughts. Totally untested, but I think it looks coo=
l :)
>
> I think this feature is feasible. The protocol and UI are still up in
> the air. Plenty of work for any student who wants to pick this up.

I think students are losing the chance to have this fun now. A rough
implementation is available at

    https://github.com/pclouds/git/tree/shallow-since

if anybody wants to try out. I don't post it here yet because while it
seems to be working in my limited tests, there could be some corner
cases to sort out, bugs and style violations. Also tests to be added.

Documentation changes below. --not and --since can be mixed. Neither
of them can be used with --depth though, but I'd consider it a
temporary limitation.

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index b09a783..ec68374 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -13,6 +13,15 @@
 	to the specified number of commits from the tip of each remote
 	branch history. Tags for the deepened commits are not fetched.
=20
+--since=3D<date>::
+	Deepen or shorten the history of a 'shallow' repository to
+	include all reachable commits that are after <date>.
+
+--not=3D<revision>::
+	Deepen or shorten the history of a 'shallow' repository to
+	exclude commits reachable from a specified remote branch or tag.
+	This option can be specified multiple times.
+
 --unshallow::
 	If the source repository is complete, convert a shallow
 	repository to a complete one, removing all the limitations
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..fc094c6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -187,6 +187,14 @@ objects from the source repository into a pack in =
the cloned repository.
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions.
=20
+--since=3D<date>::
+	Create a 'shallow' clone with a history after the specified time.
+
+--not=3D<revision>::
+	Create a 'shallow' clone with a history, excluding commits
+	reachable from a specified remote branch or tag.  This option
+	can be specified multiple times.
+
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index 4f8a7bf..3649301 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -179,6 +179,24 @@ This capability adds "deepen", "shallow" and "unsh=
allow" commands to
 the  fetch-pack/upload-pack protocol so clients can request shallow
 clones.
=20
+deepen-since
+------------
+
+This capability adds "deepen-since" command to fetch-pack/upload-pack
+protocol so the client can request shallow clones that are cut at a
+specific time, instead of depth. Internally it's equivalent of doing
+"rev-list --since=3D<time>" on the server side. "deepen-since" cannot =
be
+used with "deepen".
+
+deepen-not
+----------
+
+This capability adds "deepen-not" command to fetch-pack/upload-pack
+protocol so the client can request shallow clones that are cut at a
+specific revision, instead of depth. Internally it's equivalent of
+doing "rev-list --not <rev>" on the server side. "deepen-not"
+cannot be used with "deepen", but can be used with "deepen-since".
+
 no-progress
 -----------
