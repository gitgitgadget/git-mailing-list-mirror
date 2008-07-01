From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 7/7] Documentation formatting and cleanup
Date: Tue, 01 Jul 2008 14:34:23 -0700
Message-ID: <7vej6dmgps.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <Pine.GSO.4.62.0806301730230.7190@harper.uchicago.edu>
 <486A2C8C.5050204@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Jon Loeliger <jdl@jdl.com>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jul 01 23:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDnVd-0003Jq-Bz
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 23:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbYGAVeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 17:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYGAVeg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 17:34:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYGAVef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 17:34:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6194E250B4;
	Tue,  1 Jul 2008 17:34:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 51F21250AD; Tue,  1 Jul 2008 17:34:27 -0400 (EDT)
In-Reply-To: <486A2C8C.5050204@free.fr> (Olivier Marin's message of "Tue, 01
 Jul 2008 15:09:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7ED9770E-47B5-11DD-B430-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87066>

Olivier Marin <dkr+ml.git@free.fr> writes:

> Also, in Documentation/gitdiffcore.txt, you did:
>
>> -These are applied in sequence.  The set of filepairs git-diff-\*
>> +These are applied in sequence.  The set of filepairs `git-diff-*`
>
> but the file does not compile, now.

There are other places with the same breakage.

You would need something like this (using the {asterisk} macro I
wrote for updating the docs for another topic).  The patch shows only a
single use location but there are others in the same file.

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 10c1a15..40d43b7 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -8,6 +8,7 @@
 # the command.
 
 [attributes]
+asterisk=&#42;
 plus=&#43;
 caret=&#94;
 startsb=&#91;
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 71568ab..7169eee 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -23,7 +23,7 @@ that are easier to understand than the conventional kind.
 The chain of operation
 ----------------------
 
-The `git-diff-*` family works by first comparing two sets of
+The `git-diff-{asterisk}` family works by first comparing two sets of
 files:
 
  - `git-diff-index` compares contents of a "tree" object and the
