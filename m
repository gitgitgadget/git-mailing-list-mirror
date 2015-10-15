From: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Thu, 15 Oct 2015 10:12:41 +0200
Message-ID: <561F5FF9.3070906@orange.fr>
References: <561C1132.3090606@orange.fr> <vpqsi5fx2gr.fsf@grenoble-inp.fr> <561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com> <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <CA+P7+xoDia6PC+qJeVn3sD5g4jk7KRuDAPOcEHvrntd+ndUraA@mail.gmail.com> <CANoM8SVAGQ4AL9wBiBMaAu0GvaotC8rhn-rWQhLjsyWr4DnXmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 10:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmdel-0005bx-Gi
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 10:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbbJOIMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 04:12:49 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:42659 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbJOIMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 04:12:44 -0400
Received: from [127.0.0.1] ([213.178.77.178])
	by mwinf5d29 with ME
	id VLCh1r00k3qpEb103LCijc; Thu, 15 Oct 2015 10:12:42 +0200
X-ME-Helo: [127.0.0.1]
X-ME-Auth: ZGV2ZWwuZngubGViYWlsQHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 Oct 2015 10:12:42 +0200
X-ME-IP: 213.178.77.178
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CANoM8SVAGQ4AL9wBiBMaAu0GvaotC8rhn-rWQhLjsyWr4DnXmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279653>



On 13/10/2015 20:00, Mike Rappazzo wrote:
> It seems reasonable that this could be added as a feature of
> interactive rebase.  The todo list could be automatically adjusted to
> "reword" for those commits which are referring to other commits within
> the same rebase.  As each commit is re-written, a mapping could be
> kept of old sha1 -> new sha1.  Then when one of the reworded commits
> is being applied, the old sha1 -> new sha1 mapping could be used to
> add a line to the $COMMIT_MSG.

Even for non-interactive rebase, it could work.
