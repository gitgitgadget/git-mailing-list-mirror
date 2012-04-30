From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/3] sequencer: export commit_list_append()
Date: Mon, 30 Apr 2012 23:07:21 +0200
Message-ID: <4F9EFF09.5010201@lsrfire.ath.cx>
References: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com> <20120425111435.GA21579@sigill.intra.peff.net> <4F985D0A.9020100@lsrfire.ath.cx> <4F98600F.6000404@lsrfire.ath.cx> <xmqqobqfbhae.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Mueller <mmueller@vigilantsw.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 23:07:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOxoi-000142-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 23:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab2D3VH2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 17:07:28 -0400
Received: from india601.server4you.de ([85.25.151.105]:57774 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab2D3VH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 17:07:27 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 824362F805D;
	Mon, 30 Apr 2012 23:07:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <xmqqobqfbhae.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196607>

Am 26.04.2012 00:03, schrieb Junio C Hamano:
> I however wonder if we can name "next" a bit better, but cannot come =
up
> with a good name.  It is the location that holds the pointer to the n=
ew
> tail element if we append one.  Some places may call it "tail" but th=
at
> gives a wrong impression that it points at the element at the end.

Perhaps tail_next?  And it's perhaps a good idea to include it in the=20
struct instead of letting callers maintain it separately.

Ren=C3=A9
