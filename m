From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: 1.7.2 cycle will open soon
Date: Thu, 06 May 2010 08:57:19 +0200
Message-ID: <4BE2684F.1080004@viscovery.net>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org> <20100506055236.GA16151@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 06 08:57:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9v1S-0000T1-Uh
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab0EFG5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:57:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17413 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0EFG5V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:57:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O9v1M-0006Tw-EY; Thu, 06 May 2010 08:57:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2BBBD1660F;
	Thu,  6 May 2010 08:57:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100506055236.GA16151@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146449>

Am 5/6/2010 7:52, schrieb Jeff King:
> Why not just:
> 
>   test_run_ () {
>     test_cleanup=
>     eval >&3 2>&4 "$1"
>     eval_ret=$?
>     eval >&3 2>&4 "$test_cleanup"
>     return 0
>   }
> 
>   test_when_finished () {
>     test_cleanup="$*; $test_cleanup"
>   }
> 
> Am I missing something?

I ask myself the same question.

For my taste, this change went production far too fast. Did I miss any
discussion on it? (I didn't speak up when it passed by on the ML because I
was on a short trip at that time.)

-- Hannes
