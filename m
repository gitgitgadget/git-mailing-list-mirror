From: Hannu Koivisto <azure@iki.fi>
Subject: Re: git bisect view's use of DISPLAY environment variable in Cygwin
Date: Wed, 29 Oct 2008 01:26:19 +0200
Organization: NOYB
Message-ID: <83ej20cndw.fsf@kalahari.s2.org>
References: <83wsfs1y6v.fsf@kalahari.s2.org>
	<c07716ae0810281015s47741fdqec4c3bed3313bb6a@mail.gmail.com>
	<83skqg1uc9.fsf@kalahari.s2.org>
	<c07716ae0810281213k432d82d8i468f54ae03146b88@mail.gmail.com>
	<83iqrccpmk.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 00:27:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuxyT-0006bJ-Fg
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 00:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbYJ1X03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 19:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYJ1X03
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 19:26:29 -0400
Received: from main.gmane.org ([80.91.229.2]:41384 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbYJ1X02 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 19:26:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KuxxC-0003C4-7W
	for git@vger.kernel.org; Tue, 28 Oct 2008 23:26:26 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 23:26:26 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 23:26:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:+5RVJ8qd0RBuBIXXSRNzDuqrBSA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99330>

Hannu Koivisto <azure@iki.fi> writes:

> "Christian Couder" <christian.couder@gmail.com> writes:
>
>> On Tue, Oct 28, 2008 at 6:51 PM, Hannu Koivisto <azure@iki.fi> wrote:
>>> "Christian Couder" <christian.couder@gmail.com> writes:
>
>> We need at least a way to detect we are under Cygwin, because we won't
>> change the current behavior for all platforms.
>> Is checking for the CYGWIN environment variable enough?
>
> No, because it may not be set.  I would probably do it at compile
> time using __CYGWIN__ definition.  I don't know what's the status

Argh, I didn't realize git-bisect is a shell script.  For detecting
Cygwin in shell scripts I have tested if `uname` matches CYGWIN*.
For detecting Windows I have tested if PROCESSOR_ARCHITECTURE is
set.  There may well be better ways.

-- 
Hannu
