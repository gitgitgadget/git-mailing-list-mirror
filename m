From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 15:51:21 +0200
Message-ID: <vpq7hyzqf1i.fsf@bauges.imag.fr>
References: <C66A8B6B.20617%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 15:51:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKBq4-00085C-7I
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 15:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759322AbZFZNv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 09:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759306AbZFZNv0
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 09:51:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35623 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758257AbZFZNvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 09:51:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n5QDp0kj010422
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2009 15:51:02 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MKBpp-0004FH-4M; Fri, 26 Jun 2009 15:51:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MKBpp-00018C-2y; Fri, 26 Jun 2009 15:51:21 +0200
In-Reply-To: <C66A8B6B.20617%jefferis@gmail.com> (Gregory Jefferis's message of "Fri\, 26 Jun 2009 14\:27\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Jun 2009 15:51:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n5QDp0kj010422
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1246629062.72834@0by02/ifjF2pvoSyjUauDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122300>

Gregory Jefferis <jefferis@gmail.com> writes:

> This defines the merge driver but not the mergetool.  A mergetool is
> presumably an interactive tool that helps you clean up failed automatic
> merges.

This is why I quoted the title of the section

>>        Defining a custom merge driver

Just tried it with 

[merge "filfre"]
       name = feel-free merge driver
       driver = gedit %O %A %B
       recursive = binary

It did launch gedit interactively during the merge.

-- 
Matthieu
