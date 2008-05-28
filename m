From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in git-log --date=short --pretty=format:"%ad"
Date: Wed, 28 May 2008 08:11:58 -0700
Message-ID: <7vd4n6wji9.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0805281535560.8172@adsl.cgsecurity.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christophe GRENIER <grenier@cgsecurity.org>
X-From: git-owner@vger.kernel.org Wed May 28 17:13:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1NKu-0000x3-79
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 17:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbYE1PMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbYE1PMP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 11:12:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYE1PMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 11:12:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AD6E65C4F;
	Wed, 28 May 2008 11:12:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 061035C4D; Wed, 28 May 2008 11:12:09 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805281535560.8172@adsl.cgsecurity.org>
 (Christophe GRENIER's message of "Wed, 28 May 2008 15:49:35 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 73175A60-2CC8-11DD-BAAC-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83098>

Christophe GRENIER <grenier@cgsecurity.org> writes:

> According to the git-log man page, we can configure how date are
> displayed:
>
> --date={relative,local,default,iso,rfc}
>   Only takes effect for dates shown in human-readable format,
>   such as when using "--pretty".
>
> But it doesn't work when a user supplied format is used:

Sorry, in theory, perhaps they could, but it doesn't and it never did.
The output is working as designed and intended.

You probably could send a patch to add %aT and %cT that are defined as
"author/committer date in the format specified with --date=<this> option";
but "%ad" and "%cd" are defined to emit "author/committer date always in
the default format".
