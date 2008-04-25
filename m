From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] Introduce fast forward option only
Date: Fri, 25 Apr 2008 11:59:14 -0700
Message-ID: <7v7ielpxq5.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0804232253g3ff8665dk89e2ddcc38353752@mail.gmail.com>
 <m3lk32p5z9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:00:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpT9g-0000Rm-N5
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 21:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760834AbYDYS70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 14:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757040AbYDYS70
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 14:59:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759598AbYDYS7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 14:59:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA4B24A5E;
	Fri, 25 Apr 2008 14:59:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 13BC94A5B; Fri, 25 Apr 2008 14:59:16 -0400 (EDT)
In-Reply-To: <m3lk32p5z9.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 25 Apr 2008 03:46:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> "Sverre Hvammen Johansen" <hvammen@gmail.com> writes:
>
>> This feature is needed for git integration with accurev.
>> See the documentation for an explanation of this feature.
>
> I'd rather have description of the change in the commit message
> itself.  You can add "See the documentation for details", but the
> basic description, like:
>
>    This commit introcudes fast forward option 'only'.  With --ff=only
>    merge succeeds only if it resolves to fast-forward merge.
>  
> It would be nice to have described either in commit message, or in the
> documentation, _why_ it is needed for integration with AccuRev,
> i.e. what features of AccuRev or of integration requires this.

Including this message, I agree with what Jakub said as comments to this
series.  Readers of "git log" 6 months from now should not have to suffer
"See Documentation", and reviewers of this series right now should not
have to guess why it is a good idea and is worth reviewing by actually
reading the patch.
