From: Vitaly Berov <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 09:54:29 +0400
Message-ID: <4BBC1E15.9040403@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com> <4BBB53F5.9010106@op5.se> <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com> <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com> <alpine.LFD.2.00.1004061705390.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 07:55:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzOEJ-0003yx-Et
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 07:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab0DGFzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 01:55:04 -0400
Received: from lo.gmane.org ([80.91.229.12]:41665 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab0DGFzB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 01:55:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NzOE6-0003tx-PP
	for git@vger.kernel.org; Wed, 07 Apr 2010 07:54:58 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:54:58 +0200
Received: from vitaly.berov by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:54:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 195.218.191.171
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004061705390.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144197>

I suspected the security reasons.

Ok, we work in trusted environment. How can we turn this behavior off?

Vitaly

On 04/07/2010 01:09 AM, Nicolas Pitre wrote:
> On Tue, 6 Apr 2010, Vitaly Berov wrote:
>
>> Why does git compute checksums on the client side? Isn't it already
>> calculated on the "server" side?
>
> Yes.  But Git clients can't trust the server like that.
>
> The only way to make sure the server didn't send you crap data, or worse
> maliciously altered data, is actually to not transfer any checksum data
> but to recompute and validate the received payload locally.
>
> This being said, you should never have to wait 6 hours for that phase to
> complete.  It is typically a matter of minutes if not seconds.
>
>
> Nicolas
