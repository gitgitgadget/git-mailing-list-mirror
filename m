From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Fri, 22 Feb 2008 18:35:08 +0100
Message-ID: <87ir0gx5bn.fsf@rho.meyering.net>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>
	<87skznhqk6.fsf@rho.meyering.net>
	<7vzlts9ag8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSboT-0001uS-Ay
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761881AbYBVRfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 12:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758387AbYBVRfO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:35:14 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:48371 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758325AbYBVRfL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 12:35:11 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4112717B597
	for <git@vger.kernel.org>; Fri, 22 Feb 2008 18:35:10 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2541C17B59D
	for <git@vger.kernel.org>; Fri, 22 Feb 2008 18:35:10 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id A9ECF8400;
	Fri, 22 Feb 2008 18:35:08 +0100 (CET)
In-Reply-To: <7vzlts9ag8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 Feb 2008 09:18:15 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74740>

Junio C Hamano <gitster@pobox.com> wrote:
> Jim Meyering <jim@meyering.net> writes:
>> ...
>> Here's an updated patch:
>> ...
>> Date: Thu, 31 Jan 2008 18:26:32 +0100
>> Subject: [PATCH] Avoid unnecessary "if-before-free" tests.
>>
>> This change removes all obvious useless if-before-free tests.
>
> Thanks.  I'll queue this probably in 'next' for now, but we
> would want a conditional workaround for git-compat-util.h before
> we push it out to 'master'.

Ok.
Would you like an autoconf test to check for working free?
