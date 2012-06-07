From: Herman van Rink <rink@initfour.nl>
Subject: Re: subtree woes
Date: Thu, 07 Jun 2012 09:33:56 +0200
Organization: Initfour Websolutions
Message-ID: <4FD05964.9040102@initfour.nl>
References: <CAMSUDdYj=GJx3LwSq98bLLXpEDWjR9ssHi=rdh1Q=zopZzAm_w@mail.gmail.com> <CAMSUDdZ0BX8E26haZ-V-Grm42PaWFm3eXuSAJBcUg1LFvis7mA@mail.gmail.com> <CAMSUDdaKu7f+A3wwsWDOA1W071xunssixrWwCi1Uz21k4DFcBQ@mail.gmail.com> <CAMSUDdZAex23k7c94VaF7H9KuGxE01sFC6XCHq4c=7jUnms7-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Paul Harris <harris.pc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 09:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScXER-0005pG-B3
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 09:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab2FGHeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 03:34:03 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:48354 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab2FGHeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 03:34:01 -0400
Received: from [192.168.42.73] (initfour.xs4all.nl [80.101.157.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 44882195440A;
	Thu,  7 Jun 2012 09:33:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CAMSUDdZAex23k7c94VaF7H9KuGxE01sFC6XCHq4c=7jUnms7-Q@mail.gmail.com>
X-Enigmail-Version: 1.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199374>

On 05-06-12 09:09, Paul Harris wrote:
> Hello,
>
> I'm shifting my projects to use a subtree system, and I'm having some trouble.
> Looks like I'm hitting a subtree-merge bug, although I thought they
> were all fixed by now.
>
> I'm using cygwin, git 1.7.9 and apenwarr's git-subtrees repo.
> I've also tried git 1.7.10.msysgit.1 with apenwarr's git-subtrees.


Your origin/subtrees/zlib branch contains the zlib directory, not the
just the contents of that directory.

Please have a look in the contrib/subtree folder of git-core.
Work is ongoing to integrate apenwarr's code.

My latest stuff is in: https://github.com/helmo/git

-- 
Met vriendelijke groet / Regards,

Herman van Rink 
Initfour websolutions
