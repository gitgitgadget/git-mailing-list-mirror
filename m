From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 11:35:05 +0100
Message-ID: <8739at8qw6.fsf@thomas.inf.ethz.ch>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<20120202084859.GC3823@burratino>
	<CAMP44s0w1eXWWaMT3WAfLxFHPQvc9dp33cyJ=T2im6g7rsrKhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:35:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsu1A-0005Um-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab2BBKfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 05:35:21 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:13428 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224Ab2BBKfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 05:35:08 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 2 Feb
 2012 11:35:03 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 2 Feb
 2012 11:35:05 +0100
In-Reply-To: <CAMP44s0w1eXWWaMT3WAfLxFHPQvc9dp33cyJ=T2im6g7rsrKhw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 2 Feb 2012 12:12:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189617>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Feb 2, 2012 at 10:48 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Exactly, and "completion: avoid default value assignment on : true
> command" tells *nothing* to most people. Why is this patch needed? Do
> I care about it?
>
> OTOH "completion: be nicer with zsh" explains the purpose of the patch
> and people that don't care about zsh can happily ignore it if they
> want, and the ones that care about zsh might want to back port it, or
> whatever.

Perhaps you could compromise on

  completion: work around zsh word splitting bug in : ${foo:=$(bar)}

?


> | tl;dr: $__git_porcelain_commands = $__git_all_commands
>
> Wrapping it up, to make clear what happens.

I think this is not good style for a commit message.  Apart from the
very trendy use of tl;dr, it doesn't even properly summarize the cause
*or* the user-visible symptom.  It just states how the confusion
propagates somewhere in the middle of the code.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
