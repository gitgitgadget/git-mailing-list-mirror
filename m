From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] Documentation/git-checkout: Update summary to reflect current
	abilities
Date: Mon, 24 Mar 2008 03:06:20 +0000
Message-ID: <20080324183347.16465.93600.julian@quantumfyre.co.uk>
References: <7vtziw3k9a.fsf@gitster.siamese.dyndns.org>
	<47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu>
	<20080323182102.GA22551@bit.office.eurotux.com>
	<87r6e1b6c8.fsf@mid.deneb.enyo.de> <20080324001617.GB24943@mit.edu>
	<20080324014030.GA24695@atjola.homenet>
	<20080324021411.GE24943@mit.edu>
	<20080324030946.9328.76091.julian@quantumfyre.co.uk>
	<7vbq54vzhe.fsf@gitster.siamese.dyndns.org>
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:40:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdraj-0001lr-R7
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 19:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763353AbYCXSjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 14:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760708AbYCXSjN
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 14:39:13 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:32881 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763353AbYCXSjL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 14:39:11 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id C39F2C6365
	for <git@vger.kernel.org>; Mon, 24 Mar 2008 18:39:09 +0000 (GMT)
Received: (qmail 27352 invoked by uid 103); 24 Mar 2008 18:38:09 +0000
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.025081 secs); 24 Mar 2008 18:38:09 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 24 Mar 2008 18:38:09 +0000
X-git-sha1: 3972d940af73ad0dcc94454f4ff29c9e09a443c5 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <7vbq54vzhe.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78076>

For a while now, git-checkout has been more powerful than the man-page
summary would suggest (the main text does describe the new features),
so update the summary to hopefully better reflect the current
functionality.  Also update the glossary description of the word checkout.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
On Mon, 24 Mar 2008, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> diff --git a/Documentation/git-checkout.txt
b/Documentation/git-checkout.txt
>> index 4014e72..1b8caf1 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -3,7 +3,7 @@ git-checkout(1)
>>
>>  NAME
>>  ----
>> -git-checkout - Checkout and switch to a branch
>> +git-checkout - Checkout/update/refresh items in the working tree
>
> Hmm.
>
> The glossary may be a good place to define what the verb "checkout" means.
> I think using that defined word without adding "/update/refresh" to
> muddy its meaning would be more appropriate, after we establish what
> "checkout" means in the glossary.
>
> So how about saying "Check out a whole branch, or paths to the work tree"
> or something like that?

Ok, so more like this?  I've updated the glossary entry for checkout too,
though I'm thinking that there ought to be a clearer way to explain it ...

 Documentation/git-checkout.txt |    2 +-
 Documentation/glossary.txt     |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4014e72..e11cddb 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -3,7 +3,7 @@ git-checkout(1)
 
 NAME
 ----
-git-checkout - Checkout and switch to a branch
+git-checkout - Checkout a branch or paths to the working tree
 
 SYNOPSIS
 --------
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index ab4caf4..51b6353 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -45,9 +45,12 @@ GIT Glossary
 	"changesets" with git.
 
 [[def_checkout]]checkout::
-	The action of updating the <<def_working_tree,working tree>> to a
-	<<def_revision,revision>> which was stored in the
-	<<def_object_database,object database>>.
+	The action of updating all or part of the
+	<<def_working_tree,working tree>> with a <<def_tree_object,tree object>>
+	or <<def_blob_object,blob>> from the
+	<<def_object_database,object database>>, and updating the
+	<<def_index,index>> and <<def_HEAD,HEAD>> if the whole working tree has
+	been pointed at a new <<def_branch,branch>>.
 
 [[def_cherry-picking]]cherry-picking::
 	In <<def_SCM,SCM>> jargon, "cherry pick" means to choose a subset of
-- 
1.5.4.4
