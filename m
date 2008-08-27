From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Wed, 27 Aug 2008 09:58:00 +0200
Message-ID: <4d8e3fd30808270058g3379174bn9efe09f550aa0721@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
	 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
	 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
	 <7viqtnabld.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Raible" <raible@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 09:59:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYFvo-000723-QX
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 09:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbYH0H6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 03:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYH0H6E
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 03:58:04 -0400
Received: from qb-out-0506.google.com ([72.14.204.227]:9773 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbYH0H6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 03:58:01 -0400
Received: by qb-out-0506.google.com with SMTP id f11so304512qba.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qSe5Sk22lBAABPvDPJbLRtCEOnnL/5PyxH5DySdkOQg=;
        b=aFhIkkSW17qugre8Wn/ygYt4DzNVI4CYi4Qmqj9FcsI2sgPOraAzMgLsWKgp6MlurY
         IFdXMTo9bsTyCETwDBaqSyNCqJ/BAeid4O7ED5UsHMwgswR++85xlaVx4+wTresuJntS
         yKF9wkCt0MZMr7TGToc4yKT6m48vV2fPQStMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GZD3l7rprmv0IQziKl/fpGh9L+gyopixxv1x1A5TwvwZj31fZF8L+EH5uSbbZPT5KE
         yK1JKX/eQGTNQ7fESrj286spm4kAjjkLZVfHB2yVNOkFX4lG900GkNa8UNf8NVwCwXaK
         D8woJ6KLGKYy3ZK9+wYpj9dBBfosbUvdrN7W0=
Received: by 10.114.195.19 with SMTP id s19mr5638747waf.110.1219823880530;
        Wed, 27 Aug 2008 00:58:00 -0700 (PDT)
Received: by 10.114.135.2 with HTTP; Wed, 27 Aug 2008 00:58:00 -0700 (PDT)
In-Reply-To: <7viqtnabld.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93868>

On Tue, Aug 26, 2008 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
[...]
> So here are the tweaks I would suggest:
>
>  * Show only "git log -p HEAD..FETCH_HEAD" here;

OK.

>  * After "This operation is safe ... local changes.", say "The range
>   notation HEAD..FETCH_HEAD" means "show everything that is reachable
>   from the FETCH_HEAD but exclude anything that is reachable from HEAD.
>   Alice already knows everything that leads to her current state (HEAD),
>   and reviewing what Bob has in his state (FETCH_HEAD) that she has not
>   seen with this command";

Makes sense.

>  * Drop "This means..." and "log -p ..FETCH" example;

OK.

>  * Replace the explanation for the two-dot range notation after "gitk
>   HEAD..FETCH_HEAD" with "This uses the same two-dot range notation we
>   saw earlier with 'git log'".
>
>  * And finally, if we wanted to, we can top about omission of HEAD in
>   either end of the range notation.  Just before "Please note that these
>   range notation...", say "Because viewing range between your current
>   state and something else is common, you can omit HEAD from either side
>   of two- or three-dot range notation.  I.e. 'git log ..FETCH_HEAD' is a
>   shorthand for 'git log HEAD..FETCH_HEAD', and 'gitk ...FETCH_HEAD' is a
>   shorthand for 'gitk HEAD...FETCH_HEAD'.

Right now I dind't mention the shorthand, I'm not sure whether it's
worth to mention
it in this first tutorial.

What do you think of this whitespace damaged patch?
BTW, does anybody know if/how to inline a patch using the web
interface of Gmail?

--8<---
diff --git a/gittutorial.txt.txt b/gittutorial.txt.txt
index 48d1454..384972c 100644
--- a/gittutorial.txt.txt
+++ b/gittutorial.txt.txt
@@ -321,10 +321,37 @@ pulling, like this:

 ------------------------------------------------
 alice$ git fetch /home/bob/myrepo master
-alice$ git log -p ..FETCH_HEAD
+alice$ git log -p HEAD..FETCH_HEAD
 ------------------------------------------------

 This operation is safe even if Alice has uncommitted local changes.
+The range notation HEAD..FETCH_HEAD" means "show everything that is reachable
+from the FETCH_HEAD but exclude anything that is reachable from HEAD.
+Alice already knows everything that leads to her current state (HEAD),
+and reviewing what Bob has in his state (FETCH_HEAD) that she has not
+seen with this command
+
+If Alice wants to visualize what Bob did since their histories forked
+she can issue the following command:
+
+------------------------------------------------
+$ gitk HEAD..FETCH_HEAD
+------------------------------------------------
+
+This uses the same two-dot range notation we saw earlier with 'git log'.
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
--8<---

-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
