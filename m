From: Holger Hellmuth <holger@gspranz.de>
Subject: Re: Command-line interface thoughts
Date: Tue, 14 Jun 2011 00:33:37 +0200
Message-ID: <4DF69041.9060100@gspranz.de>
References: <201106051311.00951.jnareb@gmail.com> <201106102035.42525.jnareb@gmail.com> <4DF29EA5.60502@ira.uka.de> <201106131215.24343.jnareb@gmail.com>
Reply-To: hellmuth@ira.uka.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:33:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWFhh-0008S1-SY
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 00:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab1FMWds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 18:33:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:49431 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab1FMWdr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 18:33:47 -0400
Received: from [192.168.2.231] (dslb-088-066-038-210.pools.arcor-ip.net [88.66.38.210])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MCucZ-1QNDQZ1IzT-009Ygd; Tue, 14 Jun 2011 00:33:44 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <201106131215.24343.jnareb@gmail.com>
X-Provags-ID: V02:K0:cE7HmMD3+gNaCGU60v/8uFi0rnFpLlRUuZuCdoZk37s
 nfiQVSfd/4OYyumWo3H5WtAgSG0/Tu2AXXJ2myW7vkK1N5Pl4n
 bGYy99hvvRvZDllkOT2Z7uSS/KH1LqxFXRtT/SAxbzhSmvZVz9
 BBh6SzqypILo2J9iL6A2reeUdhHmZl2LEytuo3QzK7twRzA/Ci
 fB0sPTZ342doHMpDMTDgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175736>

Am 13.06.2011 12:15, schrieb Jakub Narebski:
> For other people getting the reverse of changes can be certainly
> suprising (I though I added this, not deleted...).  When you specify
> endpoints manually, there is a chance to get them in wrong direction.
> Especially that there is NEXT WTREE but HEAD NEXT.

Other people have that problem anyway when they use 'git diff <commit>
<othercommit>'. Or when they use linux diff, where the man page doesn't
even specify which direction it compares. Obviously someone thought that
"--- a.txt,  +++ b.txt" or the direction of '>' and '<' give enough hints.

[...]
> BTW. there is code for 'git put'.  Where is code for git diff targets?

Do you accept perl code? ;-) I've never seriously coded in C

Holger.
