From: Jan Engelhardt <jengelh@inai.de>
Subject: RE: [RFC] Support for HP NonStop
Date: Wed, 19 Sep 2012 09:24:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209190923020.32503@nerf07.vanv.qr>
References: <005501cd822d$bf844bb0$3e8ce310$@schmitz-digital.de> <7v4nnsyrp7.fsf@alter.siamese.dyndns.org> <005701cd8239$1a828300$4f878900$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 09:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEEdw-0002hB-KF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 09:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab2ISHYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 03:24:12 -0400
Received: from ares07.inai.de ([5.9.24.206]:49069 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab2ISHYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 03:24:12 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 12A1896A10B5; Wed, 19 Sep 2012 09:24:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id E6B4396A10B4;
	Wed, 19 Sep 2012 09:24:10 +0200 (CEST)
In-Reply-To: <005701cd8239$1a828300$4f878900$@schmitz-digital.de>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205912>


On Friday 2012-08-24 22:43, Joachim Schmitz wrote:
>
>> By the way, is "int" wide enough [for intptr_t/uintptr_t],
>> or should they be "long"?
>
>int and long have the same size, 32-bit, here on NonStop.
>But we do have 64-bit types too. Not sure which to take though.

intptr_t is supposed to hold a void * pointer, so should be
at least as big.
