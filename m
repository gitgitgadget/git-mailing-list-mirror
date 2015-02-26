From: Mason <slash.tmp@free.fr>
Subject: Re: Salvaging borked project history
Date: Fri, 27 Feb 2015 00:47:58 +0100
Message-ID: <54EFB0AE.6000600@free.fr>
References: <54EB5DD7.7050202@free.fr>	<xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>	<54EF098B.4080803@free.fr>	<xmqqh9u8mrha.fsf@gitster.dls.corp.google.com>	<54EF814D.1020105@free.fr> <xmqqioeol5v4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:48:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR8AG-0000l5-F5
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 00:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbbBZXsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 18:48:15 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:5844 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbbBZXsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 18:48:15 -0500
X-Greylist: delayed 12131 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Feb 2015 18:48:14 EST
Received: from [192.168.1.37] (unknown [77.207.132.113])
	(Authenticated sender: shill)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id DE0624C802F;
	Fri, 27 Feb 2015 00:47:52 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0 SeaMonkey/2.32.1
In-Reply-To: <xmqqioeol5v4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264481>

Junio C Hamano wrote:

> Mason wrote:
> 
>> I was planning to write 'git diff -q commit^ commit'
>> to test for empty commits.
> 
> s/-q/--quiet/ and all is well, no?

Doh! I've no idea how I missed these...

--exit-code
  Make the program exit with codes similar to diff(1). That is, it
  exits with 1 if there were differences and 0 means no differences.

--quiet
  Disable all output of the program. Implies --exit-code.

Thanks for walking me through it.

Regards.
