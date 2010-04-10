From: Vitaly Berov <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Sat, 10 Apr 2010 10:32:55 +0400
Message-ID: <4BC01B97.5080601@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com> <4BBB53F5.9010106@op5.se> <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com> <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com> <alpine.LFD.2.00.1004061705390.7232@xanadu.home> <4BBC1E15.9040403@gmail.com> <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi> <4BBC3EEC.6010702@gmail.com> <alpine.LFD.2.00.1004071009180.7232@xanadu.home> <4BBC981F.1000802@gmail.com> <alpine.LFD.2.00.1004071048340.7232@xanadu.home> <4BBECD31.9080307@gmail.com> <alpine.LFD.2.00.1004091525480.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 08:33:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0UG8-0007dc-Qv
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 08:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab0DJGdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 02:33:32 -0400
Received: from lo.gmane.org ([80.91.229.12]:39832 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab0DJGdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 02:33:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O0UG2-0007cV-BW
	for git@vger.kernel.org; Sat, 10 Apr 2010 08:33:30 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 08:33:30 +0200
Received: from vitaly.berov by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 08:33:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 195.218.191.171
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004091525480.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144519>

On 04/09/2010 11:30 PM, Nicolas Pitre wrote:
> On Fri, 9 Apr 2010, Vitaly Berov wrote:
>
>> Hi,
>>
>> On 04/07/2010 06:55 PM, Nicolas Pitre wrote:
>>>
>>> Then playing with core.deltaBaseCacheLimit instead would be quite
>>> interesting.
>> It's difficult to play with parameters because only receiving objects phase
>> takes 1.5-2 hours.
>
> Huh...  I guess that's over 100Mbps ethernet?
>
> 57GB / 1.5h ->  approx 10MB/s

Yes

Vitaly
