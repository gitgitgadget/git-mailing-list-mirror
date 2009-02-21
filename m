From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 21 Feb 2009 18:41:51 +0100
Message-ID: <2c6b72b30902210941u2b3e138dh903488e4dc4d7712@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
	 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
	 <op.uo9hiqqqa8ed4e@dellschleppa>
	 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
	 <op.upgqjej6a8ed4e@dellschleppa>
	 <2c6b72b30902201535q2466b8fbtce746a5263ebf320@mail.gmail.com>
	 <op.uppptmu7a8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tilo Schwarz <tilo@tilo-schwarz.de>
X-From: git-owner@vger.kernel.org Sat Feb 21 18:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lavsp-0006Oc-47
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 18:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbZBURlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 12:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbZBURly
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 12:41:54 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:52617 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbZBURlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 12:41:53 -0500
Received: by fxm11 with SMTP id 11so695746fxm.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 09:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Tvbc9omlQ3TLJwd+VCtJNQSHAn9d4nLvpAuoTkNthSA=;
        b=lYmqM8hpQx7ejkB6WbU0SQn4bODgShInyTTINGEDbkCs91AfRkzRd/f7i86HOUG+fm
         XE/7XuuPJ38zlAtEBYKYbZMAN99Y1eIt+ub5CWc727+KMp1J2BHm3LGn1d1EoVuPBF4u
         48AewD6kP3hU25m2olzuA6IMSlpnGL+8xpekg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NzkmJnOnfeAMv95C9YY6xcR+Rw3KHrvpaKblmQPJhqnuyYvRSUcLHm1UWlSkpTdnhu
         uG735W8fx5TjCePXPL++9U6HFrc3FJeg/WL9ja3Q0bt+089paWbeIrkGltUdehEXMYmc
         XjAnLuKUrHvc44u5opeUxzzqQXVGO/UBgvj44=
Received: by 10.181.193.15 with SMTP id v15mr763038bkp.168.1235238111872; Sat, 
	21 Feb 2009 09:41:51 -0800 (PST)
In-Reply-To: <op.uppptmu7a8ed4e@dellschleppa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110970>

On Sat, Feb 21, 2009 at 18:35, Tilo Schwarz <tilo@tilo-schwarz.de> wrote:
> On Sat, 21 Feb 2009 00:35:59 +0100, Jonas Fonseca <jonas.fonseca@gmail.com>
> wrote:
> Ok, here we go ;-).
>
> I can trigger a SIGSEGV in da8b99da8f4dc5512c23154ec6c0aa7d3c313555
> like this, using the tig repo itself:

Should be fixed already in commit
129cf793c915ac00dac86c561c25099cd3cd4be0 (Fix reloading of references
to not cause access to freed memory).

-- 
Jonas Fonseca
