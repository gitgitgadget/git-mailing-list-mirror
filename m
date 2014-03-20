From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Mar 2014, #04; Thu, 20)
Date: Thu, 20 Mar 2014 23:03:09 +0100
Message-ID: <532B659D.9010604@web.de>
References: <xmqq4n2sy3ux.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, apelisse@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 23:03:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQl3j-0003CG-OO
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 23:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759702AbaCTWD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 18:03:27 -0400
Received: from mout.web.de ([212.227.15.3]:63130 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759424AbaCTWD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 18:03:27 -0400
Received: from [10.0.2.15] ([217.41.18.1]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Maazp-1Wfoxx1a37-00KCKX; Thu, 20 Mar 2014 23:03:24
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <xmqq4n2sy3ux.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ZleKdVJYJssjYDhPf9ksueuz5GmJql5ZlUfXMtxHWLChk3uJzbD
 BrfP+JNqlLG2iR7zF0HReQ0t0A95b2I70RdtSCq4QmfPf7MKI3wo/193R7Yo+3NMSFnzKn+
 vr1FX1Ai7ARemNAeyyssfDzfBLIaiGgF7jktEO/ot3giAq7M/rZsdLbZBffT4NQ6g7Ad/Ad
 8b6KV5bRk2ZYgR2ifrEbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244590>

On 03/20/2014 10:09 PM, Junio C Hamano wrote:
> * ap/remote-hg-skip-null-bookmarks (2014-03-19) 1 commit
>   - remote-hg: do not fail on invalid bookmarks
>
>   Will merge to 'next'.
Hmm, am I the only one who has 11 failures in test-hg-hg-git.sh,
like this:
(Tested under Debian 7, commit 04570b241ddb53ad2f355977bae541bd7ff32af5)



master cde5672] clear executable bit
  Author: A U Thor <author@example.com>
  1 file changed, 0 insertions(+), 0 deletions(-)
  mode change 100755 => 100644 alpha
WARNING: Ignoring invalid bookmark 'master'
To hg::../hgrepo-git
  ! [remote rejected] master -> master
error: failed to push some refs to 'hg::../hgrepo-git'
not ok 1 - executable bit
[]
# failed 11 among 11 test(s)
1..11
