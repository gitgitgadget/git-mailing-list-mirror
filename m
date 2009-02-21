From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 21 Feb 2009 21:18:04 +0100
Message-ID: <op.uppxcehra8ed4e@dellschleppa>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
 <op.uo9hiqqqa8ed4e@dellschleppa>
 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
 <op.upgqjej6a8ed4e@dellschleppa>
 <2c6b72b30902201535q2466b8fbtce746a5263ebf320@mail.gmail.com>
 <op.uppptmu7a8ed4e@dellschleppa>
 <2c6b72b30902210941u2b3e138dh903488e4dc4d7712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 21:23:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LayNC-0005Ut-Ki
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 21:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbZBUUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZBUUSJ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 15:18:09 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:51553 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbZBUUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 15:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1235247484; l=632;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:Content-Transfer-Encoding:References:MIME-Version:
	Content-Type:Cc:From:Subject:To:Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=d0orBiztQGHbhOpqy63hdWKfg96ocqOJ37x2akP+yt0=;
	b=yz4NRs4yWyAzA04LYye6o1MKHcf+PwMPI/Hx9YUbl6YKWmNMirNJEQizgwcIrqiBiC7
	E6H1W1c6NhCZf/fL+4es9/UnBYweu5XbYUIeUst9RKLrpWSdGhwz4Y5weqry8Ckhfybef
	qK4itaz0vRUCNOlmXvKmV6IP+v4/gOJQ0MM=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsVz1chALQ==
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CE93A.dip.t-dialin.net [84.156.233.58])
	by post.strato.de (fruni mo62) (RZmta 18.21)
	with ESMTP id v07172l1LI9qDj ; Sat, 21 Feb 2009 21:18:04 +0100 (MET)
In-Reply-To: <2c6b72b30902210941u2b3e138dh903488e4dc4d7712@mail.gmail.com>
User-Agent: Opera Mail/9.63 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110979>

On Sat, 21 Feb 2009 18:41:51 +0100, Jonas Fonseca  
<jonas.fonseca@gmail.com> wrote:

> On Sat, Feb 21, 2009 at 18:35, Tilo Schwarz <tilo@tilo-schwarz.de> wrote:
>> On Sat, 21 Feb 2009 00:35:59 +0100, Jonas Fonseca  
>> <jonas.fonseca@gmail.com>
>> wrote:
>> Ok, here we go ;-).
>>
>> I can trigger a SIGSEGV in da8b99da8f4dc5512c23154ec6c0aa7d3c313555
>> like this, using the tig repo itself:
>
> Should be fixed already in commit
> 129cf793c915ac00dac86c561c25099cd3cd4be0 (Fix reloading of references
> to not cause access to freed memory).

That was quick! I can't trigger the SIGSEGV anymore.

Regards,

     Tilo
