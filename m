From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v4 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Wed, 9 Mar 2016 02:13:33 +0100
Message-ID: <56DF78BD.2030506@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de> <56D401C2.8020100@moritzneeb.de>
 <56DF6D67.9040103@moritzneeb.de>
 <xmqq37s0jxgg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 02:13:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adSh9-0003zN-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 02:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbcCIBNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 20:13:38 -0500
Received: from moritzneeb.de ([78.47.1.106]:57632 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbcCIBNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 20:13:35 -0500
Received: from [141.23.78.21] (wlan-141-23-78-21.tubit.tu-berlin.de [141.23.78.21])
	by moritzneeb.de (Postfix) with ESMTPSA id BED761C04F;
	Wed,  9 Mar 2016 02:13:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1457486013;
	bh=HNIKweqEGFDSExjWO/PZQtqWkGW7eeqTpbAz7eZvOao=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=Yyha8EIb+a1hzHUqzsDudx6x1Mig//ygUBJ63i4q22d3wES4FNEbHnFa+krmeO+Vb
	 WDQuhLCmAtfVRND5fDqhTaEeSlyKTY4u+lGbxtn0XbQlKsdmWKlD2U0hroLhbFI3M2
	 Vx2GjKkKT3IrpcP26we7qLzNq9ENwc/JCeCcHR9A=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqq37s0jxgg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288468>



On 03/09/2016 01:39 AM, Junio C Hamano wrote:
> Moritz Neeb <lists@moritzneeb.de> writes:
> 
>> how to deal with patches during the v2.8.0 rc freeze? Will they wait on
>> the mailing list until the feature release cycle is finished?
> 
> Because people are expected to stop getting distracted by new
> features and no-op clean-up changes and instead to focus on helping
> find and fix regressions that have been introduced since v2.7.x
> series during the pre-release period, you may not get review
> comments unless your patches are really important.
> 

Ok, I was not sure, sorry for the noise generated. Will resend post-release.

> To participate in regression hunting or not is your choice.

Say, I would like to participate. This might be a very naive question,
but: What is the "workflow" in regression hunting?

There is this known "git status"-regression, where you seem to be at
least close to a decision:

	http://thread.gmane.org/gmane.comp.version-control.git/288228/focus=288444

What I can imagine could lead towards finding regessions, though maybe a
bit aimless: Go through the list of changes/patches that are supposed to
be included in v2.8.0 and confirm they are working as expected. This
would be like a post-review.
