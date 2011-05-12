From: Phil Hord <hordp@cisco.com>
Subject: Re: fast forward a branch from another
Date: Thu, 12 May 2011 12:58:32 -0400
Message-ID: <4DCC11B8.8000805@cisco.com>
References: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com> <7vsjsjdhud.fsf@alter.siamese.dyndns.org> <4DCC0A4F.7000800@cisco.com> <7vfwojdfta.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Frederich <eric.frederich@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:58:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKZDi-00028G-BZ
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 18:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047Ab1ELQ6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 12:58:32 -0400
Received: from sj-iport-3.cisco.com ([171.71.176.72]:64078 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426Ab1ELQ6b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 12:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=906; q=dns/txt;
  s=iport; t=1305219511; x=1306429111;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=rIsMXG81DDNWlqWGiYFiiniGS6XgOZ0iI7Cjpo7Je7E=;
  b=etd70Igt+CrBPCcerTVqC/mG/BGokcFIlP69JjyWDEMQrPtc/qnrSlUs
   OXNF4/YauXgQ/mzW6gv6oWf635sWVoMZkHItd4+9LLWUXJnoLF3AIpfmN
   0cMul5uSW9nv4Uq7qY6OJiEHxbDO5yCfJgohNFifQUiiWScnd/Y6ddFPk
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAAARzE2tJXG8/2dsb2JhbACleHepX54thhUEj3uEKIpd
X-IronPort-AV: E=Sophos;i="4.64,359,1301875200"; 
   d="scan'208";a="314295275"
Received: from rcdn-core2-1.cisco.com ([173.37.113.188])
  by sj-iport-3.cisco.com with ESMTP; 12 May 2011 16:58:30 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core2-1.cisco.com (8.14.3/8.14.3) with ESMTP id p4CGwUXb013507;
	Thu, 12 May 2011 16:58:30 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110419 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7vfwojdfta.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110512125832061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173484>


On 05/12/2011 12:49 PM, Junio C Hamano wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>> I don't see this feature listed in the git push [REMOTES] section.  Is
>> it documented somewhere else?
> Both "git help push" and "git help pull" will tell you in the "Git URLs"
> section that a local file path is a way to name a repository.  Therefore,
> you can say "git ls-remote $(pwd)" to list the the refs from the current
> repository. If you are in git.git directory, "git ls-remote ../git.git"
> does the same thing, so does "git ls-remote .".
>
> These are merely specializations of more general "git push $path $refspec"
> and nothing noteworthy.

Thanks for pointing out the obvious to me.  I guess I was thinking of it
as a parallel to '-', as in 'git checkout -', and simultaneously
distracted by the surprise realization that one can push from/to the
self-same repository.

Phil
