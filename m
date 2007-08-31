From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CVS-$Id:$ replacement in git?
Date: Fri, 31 Aug 2007 09:37:41 -0700
Message-ID: <7v8x7r1wyy.fsf@gitster.siamese.dyndns.org>
References: <46D82DC3.2030203@bioinf.uni-sb.de>
	<Pine.LNX.4.64.0708311732580.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Hildebrandt <anhi@bioinf.uni-sb.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9VH-0006PY-1z
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbXHaQhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758881AbXHaQhr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:37:47 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbXHaQhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:37:46 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 273C612BDA1;
	Fri, 31 Aug 2007 12:38:05 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708311732580.28586@racer.site> (Johannes
	Schindelin's message of "Fri, 31 Aug 2007 17:33:55 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57186>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 31 Aug 2007, Andreas Hildebrandt wrote:
>
>> But unfortunately, we internally rely heavily on the $Id:$ - expansion 
>> of CVS, that is the ability to have a line like
>> 
>> $Id:$
>> 
>> in the source file expanded to something like
>> 
>> $Id: HINFile.C,v 1.64 2005/02/09 13:02:41 oliver Exp $
>> 
>> The information we want to store in the file would be something like the 
>> SHA1 of the last commit that touched that file, the date when it 
>> happened and the person who commited it.
>
> Please see Documentation/gitattributes.txt, look for 'ident'.

Please do _not_ see that.  ident is about blob object name and
does not have anything to do with the commit, pathname,
committer, nor date, and this is deliberately so.
