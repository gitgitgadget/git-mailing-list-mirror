From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Curious about details of optimization of object database...
Date: Fri, 09 Jan 2009 18:55:58 +0100
Message-ID: <vpqzli01hzl.fsf@bauges.imag.fr>
References: <20090109174623.GC12552@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chris@seberino.org
X-From: git-owner@vger.kernel.org Fri Jan 09 19:09:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLLnO-0003aY-Si
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 19:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbZAISH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 13:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbZAISH6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 13:07:58 -0500
Received: from imag.imag.fr ([129.88.30.1]:45854 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbZAISH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 13:07:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n09I3jix025788
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Jan 2009 19:03:46 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LLLaQ-0001MJ-4G; Fri, 09 Jan 2009 18:55:58 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LLLaQ-0000fG-1r; Fri, 09 Jan 2009 18:55:58 +0100
In-Reply-To: <20090109174623.GC12552@seberino.org> (chris@seberino.org's message of "Fri\, 9 Jan 2009 09\:46\:23 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 09 Jan 2009 19:03:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105024>

chris@seberino.org writes:

> I'm told a commit is *not* a patch (diff), but, rather a copy of the entire
> tree.

Conceptually, yes. But obviously, the storage format (pack) does what
people usually call "delta-compression", which is basically storing
only the diff against another, similar object.

-- 
Matthieu
