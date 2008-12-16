From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: hooks/post-update execs git-update-server-info
Date: Tue, 16 Dec 2008 01:27:24 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngke0vs.9c3.sitaramc@atcmail.atc.tcs.com>
References: <gi600m$tts$2@ger.gmane.org>
 <m3zlixcqrb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 02:29:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCOk7-0007Kw-MO
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 02:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbYLPB1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 20:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYLPB1k
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 20:27:40 -0500
Received: from main.gmane.org ([80.91.229.2]:35411 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbYLPB1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 20:27:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCOik-0001n8-Jk
	for git@vger.kernel.org; Tue, 16 Dec 2008 01:27:34 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 01:27:34 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 01:27:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103229>

On 2008-12-15, Jakub Narebski <jnareb@gmail.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:

>> shouldn't .git/hooks/post-update contain "exec git
>> update-server-info" (note the space not hyphen) instead of

> If I understand correctly hooks run with GIT_EXEC_PATH prepended to
> PATH, so everything should work; and it has to work to not force users

you're right -- it does.  There was something else wrong in
my quick-and-dirty testing that caused me to jump to the
wrong conclusion; sorry for the noise!
