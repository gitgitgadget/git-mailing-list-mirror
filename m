From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: statistics
Date: Fri, 25 Jul 2008 13:55:27 +0200
Message-ID: <4889BF2F.7050309@keyaccess.nl>
References: <4889B66D.4020306@keyaccess.nl> <4889B912.9040006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 13:54:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMLs8-0004SH-G6
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 13:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYGYLxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 07:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbYGYLxH
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 07:53:07 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:38354 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbYGYLxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 07:53:06 -0400
Received: from [213.51.130.190] (port=58412 helo=smtp1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KMLr6-0003zr-WB; Fri, 25 Jul 2008 13:53:04 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:55575 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KMLr6-0000y8-Ox; Fri, 25 Jul 2008 13:53:04 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <4889B912.9040006@viscovery.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90038>

On 25-07-08 13:29, Johannes Sixt wrote:

> Rene Herman schrieb:

>> Is there a (non-depressing) way of getting "which files did not change
>> since <rev>" out of git?
> 
> What is "non-depressing"?
> 
> Try this if you are using bash:
> 
>   comm -13 <(git diff --name-only your-rev-here) <(git ls-files)

That classifies as non-depressing, thank you. --name-only, process 
substitution _and_ comm -13 hadn't featured in my attempts yet.

Rene.
