From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 28 Jul 2008 11:25:07 +1200
Message-ID: <46a038f90807271625x35c561fdv6dc6b2c312f45fa1@mail.gmail.com>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
	 <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
	 <200807260512.40088.zippel@linux-m68k.org>
	 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
	 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Roman Zippel" <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 01:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNFcw-0007xb-Cc
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 01:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbYG0XZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 19:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYG0XZJ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 19:25:09 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:30166 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbYG0XZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 19:25:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5388666wfd.4
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xXeE/osm4HaFxN40Red+QOEKfWjL4Tajb2WtKbc54YQ=;
        b=nfREAIvVZrGDbz9Dv1HVTqgzpQDZdi2JRnGYZAM8P6cFX0QP9vB8ixHXYg4fJ/t+xC
         tQUtA4t+B6fLUABwUz5aHxEmxU2Gpn6rmdx4R9zqTMB5Lti23yBsDcmLU9TruEwZ2HQm
         KzOrMRka/CnenTt/hjlSuhfSTMhv91xq0XAHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Npj1LKAFPd4Vm02SXV/z1OVyFSK7AGIdF7IYIgk22XulFpijxn3S1MGnqFEiAa68UI
         pfv9n1/o+koGnX/lvlCtkgvC2FS6BUaGYejRGYJ0Y+4lzdJlK4wEDNi58puAtZoDq/P+
         ctjfGB1QTH8K8nV5x5cVga5uESZd8gA9YFYpE=
Received: by 10.142.187.8 with SMTP id k8mr1363201wff.226.1217201107603;
        Sun, 27 Jul 2008 16:25:07 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Sun, 27 Jul 2008 16:25:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90376>

On Mon, Jul 28, 2008 at 11:14 AM, Roman Zippel <zippel@linux-m68k.org> wrote:
> Why are you dismissing what I wrote without even giving it a second
> thought? I didn't bother with the initial example, because it's so
> simple, that it's no real challenge.

I can't speak for anyone else, but you do have to keep in mind that a
solution to this has to be rather fast - and I mean fast in git terms,
not in scripting-language-fast terms.

That you can do it Ruby - and I may be able to do it Perl - has little
bearing on what can be done inside the git log machinery with a small
performance penalty.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
