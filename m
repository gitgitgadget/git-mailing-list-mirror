From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] symlinks.c: small style cleanup
Date: Sun, 07 Jun 2009 23:25:47 +0200
Organization: private
Message-ID: <86fxebwxb8.fsf@broadpark.no>
References: <1244374385-5253-1-git-send-email-barvik@broadpark.no>
 <alpine.DEB.1.00.0906071616060.26154@pacific.mpi-cbg.de>
 <7veitwatvy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 23:27:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDPtT-0008MV-DR
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 23:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbZFGV05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 17:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754456AbZFGV04
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 17:26:56 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:40723 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbZFGV04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 17:26:56 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KKW00HLK0WXK330@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 07 Jun 2009 23:26:57 +0200 (CEST)
Received: from localhost ([80.202.166.56]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KKW003G80WWO740@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 07 Jun 2009 23:26:57 +0200 (CEST)
In-reply-to: <7veitwatvy.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121004>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Sun, 7 Jun 2009, Kjetil Barvik wrote:
>>
>>> Add {}-braces around an else-part, where the if-part already has
>>> {}-braces.
>>
>> This is the wrong way round.  We prefer _not_ to add unnecessary braces, 
>> but do tolerate them from time to time.
>
> I am at fault not spelling this out so far, but we prefer to match the
> kernel style of having {} around a single-statment "else" body when the
> corresponding "if" side needs one (or vice versa).

  OK!

  I can also say that it looks better in my eyes to do it like this, so,
  Junio, please use this version of the patch, and forget about v2 of
  the patch posted some time later.

  -- kjetil
