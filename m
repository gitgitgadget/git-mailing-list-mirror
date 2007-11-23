From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git --prune --aggresive
Date: Fri, 23 Nov 2007 12:15:50 +0100
Message-ID: <vpq3auxxleh.fsf@bauges.imag.fr>
References: <200711231058.46578.jnareb@gmail.com>
	<200711231108.16676.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 12:17:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvWWy-0005Gi-77
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 12:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbXKWLQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 06:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbXKWLQv
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 06:16:51 -0500
Received: from imag.imag.fr ([129.88.30.1]:50246 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537AbXKWLQu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 06:16:50 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lANBFqmD002757
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 23 Nov 2007 12:15:52 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IvWVi-0000I8-H4; Fri, 23 Nov 2007 12:15:50 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IvWVi-0000t6-Er; Fri, 23 Nov 2007 12:15:50 +0100
In-Reply-To: <200711231108.16676.jnareb@gmail.com> (Jakub Narebski's message of "Fri\, 23 Nov 2007 11\:08\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 23 Nov 2007 12:15:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65894>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
>> 2396:[gitweb/web@git]# git gc --aggresive --prune
>> usage: git-gc [--prune] [--aggressive]
>> 2397:[gitweb/web@git]# git gc --prune --aggresive
>> usage: git-gc [--prune] [--aggressive]
>> 2398:[gitweb/web@git]# git --version
>> git version 1.5.3.5
>> 
>> Either usage string should be fixed, as it suggests that you can specify 
>> both --aggresive and --prune, or git-gc should.
>
> I'm very sorry, my mistake: --aggresive instead of --aggressive.
> Please disregard this message...

Now, for the cool thing: with the latest git, I get the following.

$ git gc --aggresive --prune 
error: unknown option `aggresive'       <----- this is what you wanted.
usage: git-gc [options]

    --prune               prune unreferenced objects
    --aggressive          be more thorough (increased runtime)
    --auto                enable auto-gc mode

$ _

Thanks, parse_options.[ch]!

-- 
Matthieu
