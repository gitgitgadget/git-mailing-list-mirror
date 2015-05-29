From: Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: Redirect "git" subcommand to itself?
Date: Fri, 29 May 2015 10:38:14 +0200
Message-ID: <87zj4n4w3t.fsf@gmail.com>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
	<xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 10:36:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyFmV-0000cc-LY
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 10:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbbE2Igk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 04:36:40 -0400
Received: from plane.gmane.org ([80.91.229.3]:57737 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481AbbE2Igi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 04:36:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YyFmL-0000VW-59
	for git@vger.kernel.org; Fri, 29 May 2015 10:36:33 +0200
Received: from host57-2.natpool.mwn.de ([138.246.2.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2015 10:36:33 +0200
Received: from chneukirchen by host57-2.natpool.mwn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2015 10:36:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host57-2.natpool.mwn.de
In-Reply-To: <xmqqoal5ii21.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 May 2015 18:53:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270216>

Junio C Hamano <gitster@pobox.com> writes:

>  * You can help yourself with something like this, I suppose:
>
>    [alias]
> 	git = "!sh -c 'exec git \"$@\"' -"
>
>    but I personally feel that it is too ugly to live as part of our
>    official suggestion, so please do not send a patch to add it as
>    a built-in alias ;-).

So I thought I was clever, but this didn't work:

% ln -s /usr/bin/git ~/bin/git-git  
% git git
fatal: cannot handle git as a builtin

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org
