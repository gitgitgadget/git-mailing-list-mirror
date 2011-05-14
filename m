From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 2/2] Submodules: Don't parse .gitmodules when it contains,
 merge conflicts
Date: Sat, 14 May 2011 19:46:27 +0200
Message-ID: <4DCEBFF3.4040809@web.de>
References: <4DCEACF8.50503@web.de> <4DCEAD52.60707@web.de> <BANLkTinvkxDYqNs3Pv0CniGtAHm5dJf0wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 19:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLIvu-0004Rw-4L
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 19:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab1ENRrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 13:47:12 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41239 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab1ENRrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 13:47:11 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6CA3718EC709D;
	Sat, 14 May 2011 19:46:27 +0200 (CEST)
Received: from [93.240.103.149] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QLIv5-0001nF-00; Sat, 14 May 2011 19:46:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <BANLkTinvkxDYqNs3Pv0CniGtAHm5dJf0wg@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/iOjemvQ6Fq0f2aS95ldq29Pz/PAGO1ClqL+zF
	A2mhh9s7E8Qi8p2Linwjh0mkbUh/8iv1ZeoDcypKhAm4AYOxpG
	HyDHwujBHr73Z//J+1cQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173597>

Am 14.05.2011 18:59, schrieb Nguyen Thai Ngoc Duy:
> On Sat, May 14, 2011 at 11:26 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Commands like "git status", "git diff" and "git fetch" would fail when the
>> .gitmodules file contained merge conflicts because ...
> 
> Side note. .gitattributes and .gitignore likely suffer the same.
> Perhaps the unmerged check in this patch can be generalized for reuse.

Interesting thought. But adding conflict markers in those files
doesn't break anything the way it did for .gitmodules, so this
looks like a non-issue.
