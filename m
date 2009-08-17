From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 19:19:27 +0700
Message-ID: <fcaeb9bf0908170519g71741643i8029845440bba654@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com> 
	<fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com> 
	<2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com> 
	<fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com> 
	<4A8932BB.7030002@viscovery.net> <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com> 
	<4A894676.1090803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:19:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1Br-00057m-FZ
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbZHQMTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757930AbZHQMTq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:19:46 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:28575 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724AbZHQMTq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:19:46 -0400
Received: by an-out-0708.google.com with SMTP id d40so2803484and.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/L84S/nT9b45EbBOEOgsSzeZ09glV8IyYiJh6yuLGcw=;
        b=c2P9IX5jEEuCwPyqM+uTnmb+UkG7cHkSx4iVxWFyHw9UhyTxofleaJJEeiw5ybX1JU
         mBBZbkE/aeyNMhoFyLGxyyii/CWP3UHLsrAG3sLMKMvA1+2TzOunmNx9FdFHfXFj2WJ3
         6pwBmOu872587f421myj3EzVNBSOEllej4Xkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CGdKEETHXFM6VpXrOqiYLRd2xwTNpiHb3vRr6OxRbkbIbVKPY8euWekObaen59CMIM
         ojtx/gaXgRa0jQdJTGFoX39wrKB+ulcq0dV1RuB+xXe8jo0a8H4jEMJvzNH0pAUQm75C
         +ts8R7MRXhkj4ec3xyRLgNnNOmQB2z8wkY1gI=
Received: by 10.101.102.16 with SMTP id e16mr3257945anm.84.1250511587134; Mon, 
	17 Aug 2009 05:19:47 -0700 (PDT)
In-Reply-To: <4A894676.1090803@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126162>

On Mon, Aug 17, 2009 at 7:00 PM, Johannes Sixt<j.sixt@viscovery.net> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>> On Mon, Aug 17, 2009 at 5:36 PM, Johannes Sixt<j.sixt@viscovery.net> wrote:
>>> In order to advocate my earlier proposal: Name the file
>>> .git/info/phantoms, then it's clear: "The files mentioned here are
>>> phantoms" - they exist in the index, but not in the worktree; no phantoms
>>> means that everything is checked out.
>>
>> OK. Phantom checkout, must be unique in VCS world ;-) If no one
>> objects my next series will use this name as it's better than "sparse"
>> and "assume-unchanged" is just too vague. Would option names to
>> enable/disable this be --with[out]-phantoms?
>
> --phantoms vs. --no-phantoms?

Yeah good too. I have probably dealed with autotools too much lately.
-- 
Duy
