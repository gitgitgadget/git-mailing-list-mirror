From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 14:33:35 -0700
Message-ID: <3B610A5B-DE74-4DB1-A61D-13AAF167E36C@sb.org>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino> <20101104205307.GA8911@home.lan>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:33:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7RI-0006U3-4T
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab0KDVdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:33:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43618 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab0KDVdi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 17:33:38 -0400
Received: by pwj7 with SMTP id 7so363894pwj.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 14:33:38 -0700 (PDT)
Received: by 10.142.86.9 with SMTP id j9mr1311976wfb.104.1288906418168;
        Thu, 04 Nov 2010 14:33:38 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm519835wfa.11.2010.11.04.14.33.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 14:33:37 -0700 (PDT)
In-Reply-To: <20101104205307.GA8911@home.lan>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160773>

On Nov 4, 2010, at 1:53 PM, Yann Dirson wrote:

> Eric Raible suggested:
>> How about:
>> 
>> #  e [<commit>], edit [<commit>] = use commit (if present) but pause to amend
> 
> Other commands do not mention commit (or other things) as a synopsis would.
> What about:
> 
> #  e, edit = use commit (if specified) but pause to amend/examine/test

I like this. My only remaining concern is the original "shell" version let you
put in a comment (though this was not yet documented) that would be printed when
you were sent back to the shell. This was a useful reminder as to what step you
were on. But when we overload "edit", this functionality is lost. I won't fight
for it if nobody else here thinks it's worthwhile, but I did want to point that
out.

-Kevin Ballard