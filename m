From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Tue, 26 Aug 2008 11:44:42 +0200
Message-ID: <4d8e3fd30808260244i2eb6c36anaa74771a9649445@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
	 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
	 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
	 <279b37b20808260124q5b1c834cna1afd328766adf1@mail.gmail.com>
	 <4d8e3fd30808260145k56f5d8dcmbbbd6bcaeaa878a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 11:45:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXv7V-0001Jf-6M
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 11:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYHZJoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 05:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbYHZJoo
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 05:44:44 -0400
Received: from mail-gx0-f29.google.com ([209.85.217.29]:33791 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYHZJon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 05:44:43 -0400
Received: by gxk10 with SMTP id 10so3406352gxk.13
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OjYn3WAgIq4wAZ9vriMeX5UiErkh1U7QcVZZAch5wMQ=;
        b=nS0YTPkvDliC+tB334Ucps+kNL4rAq7Jdz/GHyLHNeU22TCoWonuL64Z8fGWtIyUdP
         9RVjUSvVe03+OWZRw69SnsWJvMm8ZsTztI2Z+ww3t33EeZjJiZSCMbO2sad88HaTgk5w
         DhsyBNC1BZ5O7TQK8Nf/2XIviYm1xmSAsnT7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wq5SatwiYLTJnAtedrQG9mNtFmlJZ+0gMWKpP+kdQddY6xNdgzxg5lzzfPcecYPsxP
         FMoOnUsfA4paeSVIZjtRfsOVggVSX99Hzb14KW1kFPYvgedw+qsyh4UVL0+Az2GeP940
         q8vd3SU6Fr5hBmh8ubNxsGJyaVo/48gEgXdUU=
Received: by 10.142.180.19 with SMTP id c19mr1918329wff.322.1219743882232;
        Tue, 26 Aug 2008 02:44:42 -0700 (PDT)
Received: by 10.142.148.17 with HTTP; Tue, 26 Aug 2008 02:44:42 -0700 (PDT)
In-Reply-To: <4d8e3fd30808260145k56f5d8dcmbbbd6bcaeaa878a6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93729>

On Tue, Aug 26, 2008 at 10:45 AM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> On Tue, Aug 26, 2008 at 10:24 AM, Eric Raible <raible@gmail.com> wrote:
>> On Tue, Aug 26, 2008 at 1:16 AM, Paolo Ciarrocchi
>> <paolo.ciarrocchi@gmail.com> wrote:
>>> +If Alice wants to visualize what Bob did since their historie forked
>>
>> s/historie/histories/
>
> Thanks, fixed.

commit 83f4407bb8e8785d7fc62119010d1412e7cd6508
Author: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Date:   Tue Aug 26 10:13:36 2008 +0200

    Gittutorial update.

    Changes to gitturolia according to the discussion on
    the git mailing list

diff --git a/gittutorial.txt.txt b/gittutorial.txt.txt
index 48d1454..279ca46 100644
--- a/gittutorial.txt.txt
+++ b/gittutorial.txt.txt
@@ -321,10 +321,51 @@ pulling, like this:

 ------------------------------------------------
 alice$ git fetch /home/bob/myrepo master
-alice$ git log -p ..FETCH_HEAD
+alice$ git log -p HEAD..FETCH_HEAD
 ------------------------------------------------

 This operation is safe even if Alice has uncommitted local changes.
+Note that HEAD, that means your current state, can be dropped on either
+side of the two-dot range notation.
+This means that Alice can also inspect what Bod did issuing the following
+command:
+
+------------------------------------------------
+alice$ git log -p ..FETCH_HEAD
+------------------------------------------------
+
+Alice can use gitk to compare what both of them did:
+
+------------------------------------------------
+$ gitk HEAD FETCH_HEAD
+------------------------------------------------
+
+This shows both histories leading to Alice's current state (HEAD) and the
+state Alice just fetched from Bob (FETCH_HEAD).
+
+If Alice wants to visualize what Bob did since their histories forked
+she can issue the following command:
+
+------------------------------------------------
+$ gitk HEAD..FETCH_HEAD
+------------------------------------------------
+
+Two commits written with two dots in between means "show
+everything that is reachable from the latter but excluding
+anything that is reachable from the former".
+
+Alice may want to view what both of them did since they forked.
+She can use three-dot form instead of the two-dot form:
+
+------------------------------------------------
+$ gitk HEAD...FETCH_HEAD
+------------------------------------------------
+
+This means "show everything that is reachable from either one, but
+exclude anything that is reachable from both of them".
+
+Please note that these range notation can be used with both gitk
+and "git log".

 After inspecting what Bob did, if there is nothing urgent, Alice may
 decide to continue working without pulling from Bob.  If Bob's history



Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
