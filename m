From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] perl/Git.pm: add parse_rev method
Date: Sun, 01 Jun 2008 21:59:26 -0700
Message-ID: <7vk5h8a0up.fsf@gitster.siamese.dyndns.org>
References: <1212241932-28605-1-git-send-email-LeWiemann@gmail.com>
 <1212290243-19393-1-git-send-email-LeWiemann@gmail.com>
 <1212290243-19393-2-git-send-email-LeWiemann@gmail.com>
 <4842DE78.7000006@gmail.com> <20080601215449.GC29404@genesis.frugalware.org>
 <484327FB.8080105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 07:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K329v-0007oj-H5
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 07:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYFBE7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 00:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbYFBE7r
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 00:59:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYFBE7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 00:59:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 551A436AC;
	Mon,  2 Jun 2008 00:59:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 31E34367F; Mon,  2 Jun 2008 00:59:39 -0400 (EDT)
In-Reply-To: <484327FB.8080105@gmail.com> (Lea Wiemann's message of "Mon, 02
 Jun 2008 00:51:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6D3FDB2-3060-11DD-8C8F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83487>

Lea Wiemann <lewiemann@gmail.com> writes:

> Miklos Vajna wrote:
>> Lea Wiemann <lewiemann@gmail.com> wrote:
>>> Is there *any* name for the identifiers you pass into git-rev-parse
>>> (like HEAD^2 or master:test/foo.txt)?
>>
>> `man git-rev-parse` calls them "revisions". Yes, even the commit:path
>> ones.
>
> True -- it's quite cringeworthy indeed. ;)  As long as it only affects
> the documentation for that particular method, I'll go with "revision".

I think that is sensible, and the method can stay parse_rev, not get_hash,
don't you think?
