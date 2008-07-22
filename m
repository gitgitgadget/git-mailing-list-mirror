From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about
 prefixing pathspec
Date: Mon, 21 Jul 2008 17:32:20 -0700
Message-ID: <7vd4l6sqqz.fsf@gitster.siamese.dyndns.org>
References: <20080720233956.GH10151@machine.or.cz>
 <20080721075618.14163.45309.stgit@localhost>
 <7v1w1nvf7q.fsf@gitster.siamese.dyndns.org>
 <20080721210452.GP10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 22 02:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL5om-00054K-HA
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 02:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbYGVAc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 20:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbYGVAc2
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 20:32:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbYGVAc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 20:32:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B5B2B36553;
	Mon, 21 Jul 2008 20:32:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D2A6136552; Mon, 21 Jul 2008 20:32:22 -0400 (EDT)
In-Reply-To: <20080721210452.GP10151@machine.or.cz> (Petr Baudis's message of
 "Mon, 21 Jul 2008 23:04:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A85438B4-5785-11DD-94C5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89421>

Petr Baudis <pasky@suse.cz> writes:

>> 	commit.  E.g.
>> 
>> 		$ cd some/deep/path
>> 		$ git ls-tree --name-only -r HEAD~20
>> 
>> 	will list the files in some/deep/path (i.e. where you are) 20
>> 	commits ago, just like running "/bin/ls" there will give you the
>> 	list of files you have right now.
>
> Frankly, I think this is overdoing it. I'm all for being positive, but
> it is obvious why this is good thing when you inspect a root tree and
> there's no need to be too wordy about it...

I mildly disagree.

If the person had truly understood that, why do we even have this thread
to begin with?

Description on *what* it does (i.e. "like what ls -a does in the current
working directory" we have in the Description section) obviously was not
good enough.  It will be better understood if you describe *why* it does
it that way at the same time.
