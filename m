From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH 0/2] Getopt::Long workaround in send-email
Date: Mon, 16 Feb 2015 10:58:44 +0100
Message-ID: <54E1BF54.2030609@statsbiblioteket.dk>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com> <1423858769-1565-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 10:58:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNIS4-0002HV-Fw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 10:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbbBPJ6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 04:58:49 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:18061 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377AbbBPJ6s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2015 04:58:48 -0500
Received: from [127.0.0.1] (130.225.25.246) by sbexch03.sb.statsbiblioteket.dk
 (130.225.24.68) with Microsoft SMTP Server (TLS) id 8.3.389.2; Mon, 16 Feb
 2015 10:58:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1423858769-1565-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263890>

On 13/02/15 21:19, Junio C Hamano wrote:
> I am inclined to squash these into one commit before starting to
> merge them down to 'next' and then to 'master', after getting
> Tested-by: from those with older Getopt::Long (prior to 2.32).
>
> Junio C Hamano (1):
>    SQUASH??? t9001: turn --no$option workarounds to --no-$option
>
> Kyle J. McKay (1):
>    git-send-email.perl: support no- prefix with older GetOptions
>
>   git-send-email.perl   | 10 ++++++++++
>   t/t9001-send-email.sh | 10 +++++-----
>   2 files changed, 15 insertions(+), 5 deletions(-)
>

Tested-by: Tom G. Christensen <tgc@statsbiblioteket.dk>

I replaced my original patch with this series on top of 2.3.0 and then 
did a build on RHEL3 (perl 5.8.0) and RHEL4 (perl 5.8.5).
On both platforms t9001 passes.

-tgc
