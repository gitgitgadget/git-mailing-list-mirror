From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 11:46:31 -0700
Message-ID: <7vod6qtgfs.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
 <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
 <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoffrey Irving <irving@naml.us>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <geoffrey.irving@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:48:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Qgd-0001cL-B1
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYE1Sqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYE1Sqr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:46:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbYE1Sqq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:46:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 43C8E57D7;
	Wed, 28 May 2008 14:46:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8646A57D5; Wed, 28 May 2008 14:46:39 -0400 (EDT)
In-Reply-To: <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com> (Geoffrey
 Irving's message of "Wed, 28 May 2008 11:28:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BBD35C8-2CE6-11DD-8E31-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83126>

Geoffrey Irving <geoffrey.irving@gmail.com> writes:

> On May 28, 2008, at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> "Geoffrey Irving" <irving@naml.us> writes:
>>
>>> Would it be straightforward
>>> to add an option to "git cherry" to ignore differences in metadata?
>>> The cherry documentation doesn't give its criteria for when commits
>>> match, and I'm not familiar enough with the code yet to figure out
>>> those criteria directly from cmd_cherry in builtin-log.c.
>>
>> cherry does not look at metadata at all.  It compares patch-ids.
>
> Can you define what a patch-id is?

$ man git-patch-id
