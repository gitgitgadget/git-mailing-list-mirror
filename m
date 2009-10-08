From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log -S not finding all commits?
Date: Thu, 08 Oct 2009 13:57:49 +0200
Message-ID: <vpq63aqxflu.fsf@bauges.imag.fr>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se>
	<362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl>
	<vpqbpkixgea.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Daniel <mjucde@o2.pl>
X-From: git-owner@vger.kernel.org Thu Oct 08 14:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvroV-000447-Sq
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 14:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951AbZJHMB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 08:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757940AbZJHMB7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 08:01:59 -0400
Received: from imag.imag.fr ([129.88.30.1]:53242 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757900AbZJHMB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 08:01:59 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n98BvnOp027531
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Oct 2009 13:57:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Mvrcz-00062R-ID; Thu, 08 Oct 2009 13:57:49 +0200
In-Reply-To: <vpqbpkixgea.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu\, 08 Oct 2009 13\:40\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 08 Oct 2009 13:57:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129688>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> git log -p --format="%s\n%x00"  | perl -0 -ne 'print if(/whatever-you-search/);'

git log -p -z is better than my --format= indeed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
