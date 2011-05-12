From: Phil Hord <hordp@cisco.com>
Subject: Re: fast forward a branch from another
Date: Thu, 12 May 2011 12:26:55 -0400
Message-ID: <4DCC0A4F.7000800@cisco.com>
References: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com> <7vsjsjdhud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Frederich <eric.frederich@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:27:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKYj7-000086-Pc
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 18:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937Ab1ELQ04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 12:26:56 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:15817 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab1ELQ0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 12:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=507; q=dns/txt;
  s=iport; t=1305217615; x=1306427215;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=vnVo9Pea75WavVb74OJT/zta+WHlSVBBocI3QJFa26o=;
  b=NKcbB9LcJB56AEaVZG9CUizVq75vB++RDHe6j+1C9GxZ6zgvmLMR+NtK
   h4xmX7Jw2cF3C3RsK6uEya7P/wwpED0jRE6veabB3wg69+BQhYkPD1wp5
   6cb8gCU0/IjtmJ5Urb52SulsV1joYsOY4cLa65h8EX6MK4EVbYn4PpOda
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAPwJzE2tJV2c/2dsb2JhbACleHepKp4khhUEj3uEKIpd
X-IronPort-AV: E=Sophos;i="4.64,359,1301875200"; 
   d="scan'208";a="284945032"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by sj-iport-4.cisco.com with ESMTP; 12 May 2011 16:26:54 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id p4CGQsDd013311;
	Thu, 12 May 2011 16:26:54 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110419 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7vsjsjdhud.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110512122655727
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173481>


On 05/12/2011 12:06 PM, Junio C Hamano wrote:
> [...]
> Instead of switching to "stable", while still on the development, you
> could do
>
> 	$ git push . HEAD:stable
>
> which would succeed only when you are purely ahead of stable (otherwise it
> will fail as you are not forcing).
>

Wow!  Another gem. I didn't realize you could use 'dot' to refer to the
same repo you're in.

I don't see this feature listed in the git push [REMOTES] section.  Is
it documented somewhere else?

Phil
