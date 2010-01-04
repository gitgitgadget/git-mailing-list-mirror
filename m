From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: RFC: display dirty submodule working directory in git gui and
 gitk
Date: Mon, 04 Jan 2010 20:21:14 +0100
Message-ID: <4B423FAA.8070106@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <fcaeb9bf1001040951r3f797750o5ebd25e93c0272ea@mail.gmail.com> <4B423633.6090603@web.de> <7viqbhelmh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:21:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRsUY-0007Bx-LC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 20:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab0ADTVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 14:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628Ab0ADTVV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 14:21:21 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:38311 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab0ADTVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 14:21:21 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9E7531442AE14;
	Mon,  4 Jan 2010 20:21:15 +0100 (CET)
Received: from [80.128.60.62] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NRsUN-0006Od-00; Mon, 04 Jan 2010 20:21:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7viqbhelmh.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19RtqOo3DnApicCmZkzUl1958l4A0FF6r3OBxKB
	bBLqdmptRYHaAml5Pxcf0NLnNaje8Pbdy9F5Fu7vOuOvtLncZ4
	EVW8f/LFMCBCkubS04LA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136139>

Am 04.01.2010 20:05, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 04.01.2010 18:51, schrieb Nguyen Thai Ngoc Duy:
>>> Incidentally I was just drafting git-super.sh it see how far it goes.
>>> The goal was to implement some cross-module operations over time. "git
>>> super status", "git super commit" and others could be handy.
>>
>> Hm, i'm not sure if this will really help us. I would rather see "git
>> status" and friends do the right thing for submodules too. Maybe this
>> has to be configurable but i think the separate commands that one has
>> to use for submodules now are part of the usability problems we are
>> seeing.

> Both will be valid approaches to work toward the same goal.  A separate
> prototype implementation can be a way to easily figure out what the
> desired features are.

> For the past 12 months, you and Johan Herland were the people who had more
> than one patches with substance to git-submodule.sh and I would really
> appreciate and at the same time want to encourage experimentation by
> people like you who are heavy users with need for a better submodule
> support.

Right. It was not my intention to discourage such experimentations with
my reply. I'm sorry if my email made this impression.
