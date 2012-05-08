From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 08 May 2012 13:34:27 +0200
Message-ID: <4FA904C3.7070208@viscovery.net>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 13:34:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRigh-00016K-N4
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 13:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab2EHLee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 07:34:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:11602 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754436Ab2EHLed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 07:34:33 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SRigW-0000ra-6X; Tue, 08 May 2012 13:34:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EA9A11660F;
	Tue,  8 May 2012 13:34:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197353>

Am 5/8/2012 13:24, schrieb Erik Faye-Lund:
> +		git show-ref | !grep "(null)"
...
> Now, doing this doesn't make my test above pass,

It is unlikely to pass if you used this test script literally, because

   $ !grep
   !grep: command not found

"!" is not an operator in a shell script. Insert a space.
