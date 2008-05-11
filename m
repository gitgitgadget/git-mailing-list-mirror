From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Make ECMerge use the settings as specified by
 the user in the GUI
Date: Sun, 11 May 2008 10:31:39 -0700
Message-ID: <7vy76g4uis.fsf@gitster.siamese.dyndns.org>
References: <482038C4.6050402@visageimaging.com>
 <183DBDB1-99BE-42C5-91DE-2488046164B7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@visageimaging.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun May 11 19:32:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvFPa-0006c8-B7
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbYEKRbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbYEKRbt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:31:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316AbYEKRbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:31:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9788035E8;
	Sun, 11 May 2008 13:31:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BD07E35E5; Sun, 11 May 2008 13:31:41 -0400 (EDT)
In-Reply-To: <183DBDB1-99BE-42C5-91DE-2488046164B7@zib.de> (Steffen
 Prohaska's message of "Sun, 11 May 2008 09:33:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21E734E4-1F80-11DD-A098-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81801>

Steffen Prohaska <prohaska@zib.de> writes:

> On May 6, 2008, at 12:53 PM, Sebastian Schuberth wrote:
>
>> When run from the command line, ECMerge does not automatically use
>> the same
>> settings for a merge / diff that it would use when starting the GUI
>> and loading
>> files manually. In the first case the built-in factory defaults
>> would be used,
>> while in the second case the settings the user has specified in the
>> GUI would
>> be used, which can be misleading. Specifying the "--default" command
>> line
>> option changes this behavior so that always the user specfified GUI
>> settings
>> are used.
>
> I tested the change and propose to take the patch.  I needed,
> however, to remove dos line endings from the patch before it
> applied cleanly.

Thanks, I did not have that "apply" problem.  

Queued.
