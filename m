From: Junio C Hamano <gitster@pobox.com>
Subject: Re: core.autocrlf and merge conflict output
Date: Sun, 22 Jun 2008 18:54:24 -0700
Message-ID: <7vk5ggkjan.fsf@gitster.siamese.dyndns.org>
References: <g3miho$se5$1@ger.gmane.org>
 <7vy74xj7ww.fsf@gitster.siamese.dyndns.org> <g3mvbh$mmj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 03:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAbHm-0005dI-Hs
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 03:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbYFWBye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 21:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbYFWBye
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 21:54:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbYFWByd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 21:54:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 723261F650;
	Sun, 22 Jun 2008 21:54:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CF2071F64F; Sun, 22 Jun 2008 21:54:27 -0400 (EDT)
In-Reply-To: <g3mvbh$mmj$1@ger.gmane.org> (Edward Z. Yang's message of "Sun,
 22 Jun 2008 21:47:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 524EDE62-40C7-11DD-A556-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85826>

"Edward Z. Yang" <edwardzyang@thewritingpot.com> writes:

> Junio C Hamano wrote:
>> Is this an old news before 249c61a (merge-recursive: respect core.autocrlf
>> when writing out the result, 2008-06-09) happened?
>
> Apparently, yes. :o) Thus are the perils of working off a "downstream"
> branch. I'll go bug the git/mingw/4msysgit.git maintainers to get this
> change merged in. Thanks!

Did cherry-picking that particular commit locally fixes the issue for you?
