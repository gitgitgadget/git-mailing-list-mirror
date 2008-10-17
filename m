From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit does not signoff using name supplied by --author
Date: Fri, 17 Oct 2008 16:58:07 -0700
Message-ID: <7vhc7ag4fk.fsf@gitster.siamese.dyndns.org>
References: <6a7ddf4e-8fcb-4a39-b4c5-1396cf702c8b@f40g2000pri.googlegroups.com>
 <0f761673-f0ec-4689-b1f1-8019d4540b0c@i20g2000prf.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bain <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:59:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqzEH-0003HF-8L
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbYJQX6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbYJQX6R
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:58:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbYJQX6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:58:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F063C70102;
	Fri, 17 Oct 2008 19:58:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 13F66700FC; Fri, 17 Oct 2008 19:58:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76ED50A0-9CA7-11DD-B21D-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98503>

bain <bain@devslashzero.com> writes:

>> If i use git-commit --author "A U Thor <author.example.net>" -s it
>> still uses my global author.name and author.email to add signoff
>> message.
>>
>> Is this expected behavior?
>
> Never mind...
>
> Looking at the code i found out commiter name/email is used to
> signoff, which is correct and can be different than author.

Actually we _do mind_.  The users should not have to look at the code to
find this out.

Send in a patch to clarify this in the documentation if it is not already
done, please.
