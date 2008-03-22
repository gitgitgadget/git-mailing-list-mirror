From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'Use of uninitialized value in string' line 651 git-send-email
 (from the 'next' branch)
Date: Sat, 22 Mar 2008 12:55:33 -0700
Message-ID: <7vr6e2h6tm.fsf@gitster.siamese.dyndns.org>
References: <f36b08ee0803180644r23c21a21y9d753492be2189ec@mail.gmail.com>
 <7vprtr44hj.fsf@gitster.siamese.dyndns.org>
 <f36b08ee0803220207j60eacbbet279c62f642cdaed0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 20:56:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd9pG-0006lr-1q
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbYCVTzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbYCVTzm
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:55:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYCVTzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:55:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D4151702;
	Sat, 22 Mar 2008 15:55:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0904A15BC; Sat, 22 Mar 2008 15:55:34 -0400 (EDT)
In-Reply-To: <f36b08ee0803220207j60eacbbet279c62f642cdaed0@mail.gmail.com>
 (Yakov Lerner's message of "Sat, 22 Mar 2008 11:07:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77847>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> On Wed, Mar 19, 2008 at 8:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Does it happen with "master" as well?
>
> Yes. Happens both in master and in next, when patchfile begins
> either with empty line, or with paragraph indented by 1 space.

Thanks for responding, but I think this was already identified by Frank to
be a malformed user input and not a bug, wasn't it?
