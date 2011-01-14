From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Fri, 14 Jan 2011 01:38:01 -0500
Message-ID: <4D2FEF49.8070205@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com>	<20101220213654.GA24628@burratino>	<4D112586.2060904@Freescale.com>	<4D119015.6020207@burntmail.com>	<4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Emil Medve <Emilian.Medve@freescale.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Martin Langhoff <martin@laptop.org>
X-From: git-owner@vger.kernel.org Fri Jan 14 07:38:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PddJG-00019f-QO
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 07:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1ANGiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 01:38:50 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:41329 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab1ANGit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 01:38:49 -0500
Received: from [173.79.59.45] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.63)
	(envelope-from <guyr@burntmail.com>)
	id 1PddIW-0001LL-ST; Fri, 14 Jan 2011 00:38:08 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165074>

On 1/10/2011 10:38 AM, Martin Langhoff wrote:
> On Mon, Jan 10, 2011 at 2:33 AM, Guy Rouillier<guyr@burntmail.com>  wrote:
>> Here is my patch for accomplishing the above.  As this is my first time
>> submitting a patch, please let me know the correct procedure if
>> submitting a diff here is not appropriate.  Thanks.
>
> The concept of what the patch is doing is good, but I'd recommend
>
> @cvspasslocations = ($ENV{'HOME'}."/cvspass", $ENV{'HOME'}."/.cvs/cvspass")
>
> foreach $cvspass (@cvspasslocations) {
>     open(...
>
> and forgo the "matching" test.
>

Martin, thanks for the reply.  Have you had a chance to read the entire 
thread?  The matching test was suggested by Emil.

This is my first patch submission.  What is the process for reaching 
consensus?

-- 
Guy Rouillier
