From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Meaning of double + and - in Gitk's diff pane
Date: Mon, 21 Mar 2011 20:45:26 +0100
Message-ID: <4D87AAD6.6000704@dirk.my1.cc>
References: <4D879B25.9090300@dirk.my1.cc> <7vr5a0p8n1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:45:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1l2p-0006xF-Cl
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1CUTpf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 15:45:35 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:47052 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab1CUTpd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 15:45:33 -0400
Received: from [84.176.60.154] (helo=[192.168.2.100])
	by smtprelay05.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Q1l2e-00086y-2q; Mon, 21 Mar 2011 20:45:28 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7vr5a0p8n1.fsf@alter.siamese.dyndns.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169650>

Am 21.03.2011 20:37 schrieb Junio C Hamano:
> Dirk S=C3=BCsserott<newsletter@dirk.my1.cc>  writes:
>
>> I regularly use gitk to get an overview. Great tool.
>> But sometimes it shows me in the diff pane lines preceeded
>> with two + or - signs or they are colored in blue or black
>> or printed in bold. I think this is true for merge commits
>> with conflicts.
>
> Look at the bottom summary of this message for a brief summary:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=
=3D15527
>
> If you want to know more about how the multi-way diff is condensed, y=
ou
> would find this message from Linus in the same thread illuminating:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=
=3D15600
>
> (Ignore the bottom part where Linus complains about gitk output---the=
 old
> implementation in gitk has gone long time ago).
>
> And also this one, again from Linus:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=
=3D15491
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Junio, thanks. When I've found the time, I'll probably condense Linus'
explanations and submit a documentation patch. It's not explained
in the actual git docs, right?
