From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] branch -v: Prevent garbage output on remote refs
Date: Sun, 6 Jul 2008 12:13:19 -0400
Message-ID: <337634A4-0B60-4803-8EE9-6D0B377F5AEE@silverinsanity.com>
References: <1215336279-99480-1-git-send-email-benji@silverinsanity.com> <7vhcb3fhqx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 18:14:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFWsV-0000I4-RN
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 18:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757338AbYGFQNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 12:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757331AbYGFQNV
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 12:13:21 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54019 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317AbYGFQNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 12:13:21 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 2A8A31FFC021;
	Sun,  6 Jul 2008 16:13:15 +0000 (UTC)
In-Reply-To: <7vhcb3fhqx.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87536>


On Jul 6, 2008, at 6:07 AM, Junio C Hamano wrote:

> Thanks, but I have pushed out a slightly different change.
>
> -- >8 --
> branch -r -v: do not spit out garbage

Looks good, and more importantly works.  Cherry-picked it from pu onto  
next.  Hopefully it'll move there on it's own soon.

~~ Brian
