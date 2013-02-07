From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Thu, 07 Feb 2013 18:45:45 +0100
Message-ID: <5113E849.8000602@elegosoft.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 18:51:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3VdV-0007so-EV
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 18:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002Ab3BGRv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 12:51:26 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:38956 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160999Ab3BGRvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 12:51:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 946EBDE074;
	Thu,  7 Feb 2013 18:51:23 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mFJAY4hJnBFM; Thu,  7 Feb 2013 18:51:23 +0100 (CET)
Received: from [192.168.1.233] (f052158234.adsl.alicedsl.de [78.52.158.234])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 2CFA2DE073;
	Thu,  7 Feb 2013 18:51:23 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130109 Thunderbird/17.0.2
In-Reply-To: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
X-Enigmail-Version: 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215703>

On 02/07/2013 05:14 PM, Ramkumar Ramachandra wrote:

> This has been annoying me for a really long time, but I never really
> got around to scratching this particular itch.  I have a very common
> scenario where I fork a project on GitHub.  I have two configured
> remotes: origin which points to "git://upstream" and mine which points
> to "ssh://mine".  By default, I always want to pull `master` from
> origin and push to mine.  Unfortunately, there's only a
> branch.<name>.remote which specifies which remote to use for both
> pulling and pushing.  There's also a remote.<name>.pushurl, but I get
> the feeling that this exists for an entirely different reason: when I
> have a server with a highly-available read-only mirror of the
> repository at git://anongit.*, and a less-available committer-only
> mirror at ssh://*.
> 
> How about a branch.<name>.remotepush that specifies a special remote
> for pushing, falling back to branch.<name>.remote?

Additionally, it would be nice to have branch.<name>.push or similar
to configure a default destination branch for push. Gerrit users usually
want to track refs/heads/master but push to refs/for/master for example.
