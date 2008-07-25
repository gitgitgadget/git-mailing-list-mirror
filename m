From: Kevin Ballard <kevin@sb.org>
Subject: Re: statistics
Date: Fri, 25 Jul 2008 15:57:47 -0700
Message-ID: <65DE6D62-2507-4C49-94A7-B5DBD7FCC8DC@sb.org>
References: <4889B66D.4020306@keyaccess.nl> <4889B912.9040006@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@keyaccess.nl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMWFt-0004RQ-8q
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 00:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503AbYGYW6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 18:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756560AbYGYW6U
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 18:58:20 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:39161 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755577AbYGYW6T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 18:58:19 -0400
Received: from [192.168.1.80] (adsl-76-199-69-6.dsl.pltn13.sbcglobal.net [76.199.69.6])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id 7E39E185DB9;
	Fri, 25 Jul 2008 15:58:18 -0700 (PDT)
In-Reply-To: <4889B912.9040006@viscovery.net>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90134>

On Jul 25, 2008, at 4:29 AM, Johannes Sixt wrote:

> Rene Herman schrieb:
>> Hi.
>>
>> Is there a (non-depressing) way of getting "which files did not  
>> change
>> since <rev>" out of git?
>
> What is "non-depressing"?
>
> Try this if you are using bash:
>
>  comm -13 <(git diff --name-only your-rev-here) <(git ls-files)

Neat, I never knew about comm before. I probably would have come up  
with something like

   cat <(git ls-tree -r $REV) <(git ls-tree -r HEAD) | sort | uniq -d  
| cut -f 2 | sort

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
