From: Richard Hansen <rhansen@bbn.com>
Subject: Re: What's cooking in git.git (Jun 2014, #01; Tue, 3)
Date: Tue, 03 Jun 2014 19:52:45 -0400
Message-ID: <538E5FCD.3060808@bbn.com>
References: <xmqqzjhtvdua.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 01:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WryVg-0008OL-2L
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 01:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934038AbaFCXws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 19:52:48 -0400
Received: from smtp.bbn.com ([128.33.0.80]:33278 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbaFCXwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 19:52:47 -0400
Received: from socket.bbn.com ([192.1.120.102]:34501)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WryVa-00004r-0Y; Tue, 03 Jun 2014 19:52:46 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id BDF4D40190
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqzjhtvdua.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250707>

On 2014-06-03 18:16, Junio C Hamano wrote:
> * rh/prompt-tests (2014-05-30) 10 commits
>  - t9904: new __git_ps1 tests for Zsh
>  - lib-prompt-tests.sh: add variable for string that encodes percent in PS1
>  - lib-prompt-tests.sh: put all tests inside a function
>  - t9903: move prompt tests to a new lib-prompt-tests.sh file
>  - t9903: move PS1 color code variable definitions to lib-bash.sh
>  - t9903: include "Bash" in test names via new $shellname var
>  - t9903: run pc mode tests again with PS1 expansion disabled
>  - t9903: move test name prefix to a separate variable
>  - t9903: put the Bash pc mode prompt test cases in a function
>  - t9903: remove Zsh test from the suite of Bash prompt tests
> 
>  Will merge to 'next'.

Please hold off on merging -- I just discovered some bugs while
conversing with the zsh developers about some zsh shell emulation stuff
I didn't fully understand.  (Surprisingly, the tests in that patch
series are actually run in zsh's sh emulation mode.)

Thanks,
Richard
