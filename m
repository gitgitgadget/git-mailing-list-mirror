From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 00:09:05 +0300
Message-ID: <CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<7v7gxftn78.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 23:09:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJtAj-0006Td-Gt
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 23:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab2DPVJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 17:09:09 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60220 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab2DPVJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 17:09:07 -0400
Received: by eekc41 with SMTP id c41so1424731eek.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oNa7PXcXyhVG3Kx/mSP2qXIPsTCgtryXydkMZP80JZk=;
        b=NWCZ2Hs24TgEJDcERqOpuNL0H3zFKaiJNAr6c1adAVA1ckRt9MP+tJAhHPko4RbSrF
         gAWXuxV9J8wMlIPfAOc1iQFZXjuerL0VWbBsFvm0PWZ0kA4HhMiBSFiZYcDElK8ljkj2
         ssHlwAhuG51AsEDoc67+tZ7ztMt8eMEI1S+quXWQvau/1TunOzniL9qIzBJYwK+4osyx
         RJysaasQdocaCjoEW0Jpw1HLQPIGRmKjpnfdmQCx+RFSCgjJwjNozSSopEHRsnm9Zt4D
         76himPxAaKYLi5BsVIqxHl9/cX+XjXikIJZCczuudc6ljRfHYvyJcCt9eJNWwFHgeMZB
         C04g==
Received: by 10.213.104.132 with SMTP id p4mr895522ebo.101.1334610546051; Mon,
 16 Apr 2012 14:09:06 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 14:09:05 -0700 (PDT)
In-Reply-To: <7v7gxftn78.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195695>

On Mon, Apr 16, 2012 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Earlier I said "Ok" to you based on that assumption; somebody may have his
> own git_complete that rebuilds a test integration branch (i.e. completes
> it) and having the name git_complete exported by us will indirectly affect
> her fingers if she installs bash_completion and Git package on her system.

She might have had the same problem if she named it _git_complete.
That might be unlinkely, but I also find it unlikely that anybody
would have a git_complete function. In fact, I find it unlikely that
people would write shell functions like that; it's much easier to
write scripts and put them in $PATH.

Even more, I just added a foobar() function in my profile, and I also
added a foobar() function in /etc/bash_completion.d/git. I don't see
my function replaced in any way, even after typing and completing
'git' commands. I don't know how that's possible, but that's why I
don't like to take these types of claims as face value.

Cheers.

-- 
Felipe Contreras
