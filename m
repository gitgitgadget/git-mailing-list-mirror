From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn testsuite: use standard configuration for Subversion tools
Date: Sat, 02 May 2009 04:56:28 -0700
Message-ID: <7vtz437m6r.fsf@alter.siamese.dyndns.org>
References: <BfKhGHDBpSzjNF/dt4ZDx88u9wI@BjOYljNjUB0FD+/Fw7pzaXMw/Hc>
	<7vfxfowugm.fsf@gitster.siamese.dyndns.org>
	<Z0zFdWIzyQzuBQjCf+Jk/nJtvIw@BjOYljNjUB0FD+/Fw7pzaXMw/Hc>
	<7viqkkv43t.fsf@gitster.siamese.dyndns.org>
	<GzXVCxlG1vigUEGxhNBLVXNYljM@AnOk+mYbmYVORDu5SWQWxomMUcc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, normaperson@yhbt.net,
	git@vger.kernel.org
To: rea-git@codelabs.ru
X-From: git-owner@vger.kernel.org Sat May 02 13:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0Dpb-0000xA-CT
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 13:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbZEBL43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 07:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbZEBL42
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 07:56:28 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:44924 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbZEBL41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 07:56:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090502115627.CPGB25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 May 2009 07:56:27 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id mbwT1b0024aMwMQ03bwT3t; Sat, 02 May 2009 07:56:27 -0400
X-Authority-Analysis: v=1.0 c=1 a=2hLPIl38GrsA:10 a=9iCuYjaEHQQA:10
 a=hJJxPVmbRO_wGLc7inIA:9 a=--XhfhuTJAaTRzGaznQA:7
 a=H8g4XNYlrh__XwLU8lXf1TQKRGYA:4
X-CM-Score: 0.00
In-Reply-To: <GzXVCxlG1vigUEGxhNBLVXNYljM@AnOk+mYbmYVORDu5SWQWxomMUcc> (Eygene Ryabinkin's message of "Sat\, 2 May 2009 14\:36\:29 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118132>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

>> > What are your concerns, 'local'?
>> 
>> Exactly.
>
> It exists in Bash and in *BSD /bin/sh.  It does not exist in Korn shell
> (at least, I am failing to find one).  I can just remove 'local' from
> the function, since it plays no big role, but generally I don't like to
> pollute parent namespace by local variables.  Certainly, if 'local' will
> break some known shell -- I'll refrain from using it in this script.

Yup, please.  This is "it is not even in POSIX, so let's not use it"
category.
