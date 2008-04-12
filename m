From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/7] git-submodule: Extract functions module_info and
 module_url
Date: Fri, 11 Apr 2008 21:50:54 -0700
Message-ID: <7vve2nllqp.fsf@gitster.siamese.dyndns.org>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
 <7v4pa8qb2h.fsf@gitster.siamese.dyndns.org>
 <46dff0320804112005t9b3cd27gc250dddffb218076@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 06:51:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkXiT-00027q-JA
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 06:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYDLEvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 00:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbYDLEvI
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 00:51:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbYDLEvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 00:51:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4AC592D51;
	Sat, 12 Apr 2008 00:51:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9AA912D50; Sat, 12 Apr 2008 00:50:59 -0400 (EDT)
In-Reply-To: <46dff0320804112005t9b3cd27gc250dddffb218076@mail.gmail.com>
 (Ping Yin's message of "Sat, 12 Apr 2008 11:05:23 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79330>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Sat, Apr 12, 2008 at 6:30 AM, Junio C Hamano <junio@pobox.com> wrote:
>> ...
>>  Same comment applies to cmd_update() and cmd_status().  I would strongly
>>  suspect that status may want to ignore missing name/url and show the usual
>>  diff, as it does not even have to require the submodule to interact with
>>  any remote repository at all.  The user may be privately using the
>>  submodule and does not even need to push it out nor pull it from
>>  elsewhere, and in such a case, .gitmodules may not even be populated with
>>  an entry for that submodule, ever, not just as a "right in the middle of
>>  adding" status.
>
> This patch just does refactor, i do this in my sixth patch "Don't die
> when command fails for one submodule"

Fair enough.

As usual, the preferred order is to first refector, fix without
enhancement as necessary, then finally build on more solidified base.
