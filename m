From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 09:04:32 +0200
Message-ID: <525E3A80.5000500@viscovery.net>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org> <20131015231427.GF9464@google.com> <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com> <20131015235739.GI9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 09:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWL9w-00026n-H7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 09:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759976Ab3JPHEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 03:04:40 -0400
Received: from so.liwest.at ([212.33.55.16]:3362 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379Ab3JPHEj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 03:04:39 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VWL9l-0002gL-JV; Wed, 16 Oct 2013 09:04:33 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3861016613;
	Wed, 16 Oct 2013 09:04:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20131015235739.GI9464@google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236235>

Am 10/16/2013 1:57, schrieb Jonathan Nieder:
> Junio C Hamano wrote:
> 
>> You just made these two that the user clearly meant to express two
>> different things indistinguishable.
>>
>> 	opt.sh -S
>>       opt.sh -S ''
> [...]
>> And that is exactly why gitcli.txt tells users to use the 'sticked'
>> form, and ends the bullet point with:
>>
>>    An option that takes optional option-argument must be written in
>>    the 'sticked' form.
> 
> Yes, another possibility in that vein would be to teach rev-parse
> --parseopt an OPTIONS_LONG_STICKED output format, and then parse with

Aren't you people trying to solve something that can't besolved? What does

  git commit -S LICENSE

mean? Commit the index and sign with the key-id "LICENSE" or commit just
the file "LICENSE" with the default key-id?

-- Hannes
