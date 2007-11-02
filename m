From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 2 Nov 2007 13:48:47 +0100
Message-ID: <A862668C-7895-489A-B13B-597084CAEE11@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.o
 rg> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <0C176853-8848-46C8-AD7A-97F73274DC29@wincent.com> <Pine.LNX.4.64.0711021213370.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 13:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Invyo-0006uF-Ky
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 13:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbXKBMuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 08:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbXKBMuN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 08:50:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:35195 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbXKBMuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 08:50:12 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA2ClPfL027949;
	Fri, 2 Nov 2007 13:49:42 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA2ClPp9023479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 2 Nov 2007 13:47:25 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0711021213370.4362@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63112>


On Nov 2, 2007, at 1:14 PM, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 2 Nov 2007, Wincent Colaiuta wrote:
>
>> Of course, it's too late too change now, but it would be nice if the
>> mirror of "fetch" were "send". (I know it's been commented in the  
>> past
>> that the fact that "push" and "pull" aren't mirror operations has
>> surprised quite a few people.)
>
> Could you please just do
>
> 	git config --global alias.send push
>
> and be done with it?

This would certainly be the easiest. But I think the following
is probably more in line with Wincent's comment:

	Makefile builds git-send instead of git-push
	git config --global alias.push send
	[ wait some time ]
	git config --unset alias.push

The comment was about how to avoid surprises for people that
are new to git, not how to let long-time users have an alias
for push.

The _only_ real solution I see right now, is to stop the
discussion and leave "git push" as is. I strongly believe that
the git community in its majority will refuse to rename push;
though I have no evidence for this.

	Steffen
