From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.txt: update description of the configuration
 mechanism
Date: Thu, 14 Feb 2013 09:10:45 -0800
Message-ID: <7v4nhe3joq.fsf@alter.siamese.dyndns.org>
References: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr>
 <511D0D88.6010302@drmicha.warpmail.net> <vpqzjz6ampm.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U62L2-00037Q-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 18:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068Ab3BNRKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 12:10:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755903Ab3BNRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 12:10:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94B8EB31F;
	Thu, 14 Feb 2013 12:10:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L7Rxs7wymg/s3bXr4XtPtgIIe4Q=; b=aysFWW
	nnQxRiuq2l/dWtdByHJlunUokFMeyLGUTbf2FhsBgs3gYfksFold8W4cmX8ymf/u
	wyhkixacXlKForpRk2YyQFKQUli5L727hqY0+0BuKua7hK8o7imEq5n+xKcF9wHL
	acOGgKglMMG1kfklvGIibefq4qQ/xr2ZNUyig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qs5+HLrkP14JKB43SuMm3/IucoEKhZy7
	J/EQisSPZBo9rKhUBJ8eV4rSaVdT4S5ZaNGpub53Whvq2GkSYCeb05EE6YPpjMpl
	ixuk9D170LP8JZlhbrkD6KCXl7AcgxGZ0Xvc5i8LEhyiDR+HzyTMih4B/3Btp0iY
	pv7nyXobzsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88D83B31E;
	Thu, 14 Feb 2013 12:10:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0906AB31C; Thu, 14 Feb 2013
 12:10:46 -0500 (EST)
In-Reply-To: <vpqzjz6ampm.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Thu, 14 Feb 2013 17:23:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7951DF36-76C9-11E2-8AC4-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216324>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> If the XDG config file ever become the default, then sure, it will have
> to be promoted instead of ~/.gitconfig in git.txt (and I'll be all for
> it when it's time, even though I can foresee a few flamewars ;-) ), but
> I don't think we should do that now.

We are giving an overview to list what things are possible and what
words the reader should be familiar with in this part of the manual.
The fact that configuration can be done per user and per repository
is a relevant thing to know at the conceptual level.

But the exact location of per-user and per-repository configuration
files does not matter in this context and is best left to the
git-config documentation.


 Documentation/git.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0b681d9..2d975e3 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -535,10 +535,9 @@ include::cmds-purehelpers.txt[]
 Configuration Mechanism
 -----------------------
 
-Starting from 0.99.9 (actually mid 0.99.8.GIT), `.git/config` file
-is used to hold per-repository configuration options.  It is a
-simple text file modeled after `.ini` format familiar to some
-people.  Here is an example:
+Git uses a simple text format to store customizations that are per
+repository and are per user.  Such a configuration file may look
+like this:
 
 ------------
 #
@@ -553,13 +552,13 @@ people.  Here is an example:
 ; user identity
 [user]
 	name = "Junio C Hamano"
-	email = "junkio@twinsun.com"
+	email = "gitster@pobox.com"
 
 ------------
 
 Various commands read from the configuration file and adjust
 their operation accordingly.  See linkgit:git-config[1] for a
-list.
+list and more details about the configuration mechanism.
 
 
 Identifier Terminology
