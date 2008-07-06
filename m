From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: [PATCH] Fix grammar in git-rev-parse(1).
Date: Sun, 6 Jul 2008 22:34:21 +0200
Message-ID: <237967ef0807061334t681ad234vdb37cfe56af2e483@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 22:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFax6-0006lo-Pk
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 22:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbYGFUeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 16:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756916AbYGFUeX
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 16:34:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:47954 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385AbYGFUeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 16:34:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2362396rvb.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=PAQvWjdgkggc5ge5w5LTLi3xvOO5D08yhPA9fNk5X8c=;
        b=KmGp4/FY+yt/Gm3Rnwy8IcFiVMnENin6BJLMl3llFvZsJiRdjE9nzGVNV8019lvoD7
         jQ9kGG/qazXTFdpl2ojsLl+BTc4+W0/ooWAuMRK+Z6B3ngKFngooGtdLMw6zPRlcIs47
         ZbxN8Ko9f22GxGX4pEBpspxt10sxmIBttqIf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Mq1Uf49TSbLB3xhn7RAUE7VDoqD+o2gytUUSikWuEkh9dmYEC4AvlsU3dPMIh6LEUf
         PK0KZvtRPVbYR5trn87NWp81lL5+RKuOinqE1l5ox91M4NCFMFz27LHdzBMAZkrzS5wh
         3+Kv7ysY2DQ15tntHE0N2wO/ffQnbrJp3YiqE=
Received: by 10.141.168.16 with SMTP id v16mr1674344rvo.233.1215376461705;
        Sun, 06 Jul 2008 13:34:21 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Sun, 6 Jul 2008 13:34:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87551>

---
 Documentation/git-rev-parse.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 59e95ad..ba65bfa 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -301,9 +301,9 @@ It is the set of commits that are reachable from
either one of
 `r1` or `r2` but not from both.

 Two other shorthands for naming a set that is formed by a commit
-and its parent commits exists.  `r1{caret}@` notation means all
+and its parent commits exist.  The `r1{caret}@` notation means all
 parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
-its all parents.
+all of its parents.

 Here are a handful of examples:

-- 
1.5.6.GIT


2008/7/6 Junio C Hamano <gitster@pobox.com>:
> "Dmitry Potapov" <dpotapov@gmail.com> writes:
>
>> On Fri, Jun 20, 2008 at 2:05 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>>
>>> There is shortcut for rev^..rev, namely rev^! (I'm not sure if it is
>>> documented anywhere, though),
>>
>> The latter is not exactly a shortcut for the former.  You can try it at any
>> merge commit, and you will see different log. For instance, in Git repo:
>> ...
>> So, I believe, rev^! means --first-parent rev^..rev
>
> Not quite.  From Documentation/git-rev-parse.txt:
>
>    SPECIFYING RANGES
>    -----------------
>
>    Two other shorthands for naming a set that is formed by a commit
>    and its parent commits exists.  `r1{caret}@` notation means all
>    parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
>    its all parents.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Mikael Magnusson
