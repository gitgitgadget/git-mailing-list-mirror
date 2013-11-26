From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] bash prompt: add option to disable for a repository
Date: Tue, 26 Nov 2013 08:01:30 +0100
Message-ID: <5294474A.7070101@viscovery.net>
References: <1385212703-9611-1-git-send-email-hoxu@users.sf.net> <5290BEE7.2070901@kdbg.org> <CAOpY_XvN9GJw592MpbcZZ2hzUvSvTHNLebwMmQBK+N-Ez4xM_Q@mail.gmail.com> <20131125234344.GA4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Jonathan Nieder <jrnieder@gmail.com>,
	Heikki Hokkanen <hoxu@users.sf.net>
X-From: git-owner@vger.kernel.org Tue Nov 26 08:01:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlCeU-0006U1-0u
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 08:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300Ab3KZHBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 02:01:38 -0500
Received: from so.liwest.at ([212.33.55.18]:40197 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051Ab3KZHBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 02:01:36 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VlCeJ-000850-6S; Tue, 26 Nov 2013 08:01:31 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BDBA016613;
	Tue, 26 Nov 2013 08:01:30 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131125234344.GA4212@google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238373>

Am 11/26/2013 0:43, schrieb Jonathan Nieder:
> Heikki Hokkanen wrote:
> 
>> If running git config on each prompt seems too expensive, do you have
>> any better ideas?
> 
> Perhaps a GIT_PS1_NOT_FOR_THESE_REPOS=repo1:repo2:repo3 setting would
> work.

Yeah, but... I find the wish to show the bash prompt in some, but not all,
repositories so uncommon that I doubt that it must be a feature of
__git_ps1. There can be a wrapper function that does the repository
discovery and calls into __git_ps1 as needed. No current __git_ps1 users
need to be burdened.

-- Hannes
