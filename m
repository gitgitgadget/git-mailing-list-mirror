From: Ben Collins <ben.collins@canonical.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 09:22:35 -0400
Organization: Canonical, Ltd.
Message-ID: <48B2B21B.1080203@canonical.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	users@kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXc2r-0001Jd-0w
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 15:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbYHYNWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 09:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbYHYNWl
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 09:22:41 -0400
Received: from adelie.canonical.com ([91.189.90.139]:51631 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbYHYNWk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 09:22:40 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.60 #1 (Debian))
	id 1KXc1j-00087e-5w; Mon, 25 Aug 2008 14:22:35 +0100
Received: from collinsap1.phunnypharm.org ([67.97.251.10] helo=[192.168.1.187])
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ben.collins@canonical.com>)
	id 1KXc1i-0001IR-W5; Mon, 25 Aug 2008 14:22:35 +0100
User-Agent: Thunderbird 2.0.0.16 (X11/20080725)
In-Reply-To: <1219664940.9583.42.camel@pmac.infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93621>

David Woodhouse wrote:
> On Sat, 2008-08-23 at 20:33 -0700, Junio C Hamano wrote:
>> There is one alternative, and one augmentation:
>>
>>  (A) We do not do anything.
>>
>>  (B) In addition to the main transition plan, outside git, prepare an
>>      optional "git-old-style" package that installs many "git-foo"
>>      wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo".
>>      People who like the dashed form can keep typing "git-foo", even
>>      though that will cost them two exec()s.
> 
>   (C) Just don't do it. Leave the git-foo commands as they were. They
>       weren't actually hurting anyone, and you don't actually _gain_
>       anything by removing them. For those occasional nutters who
>       _really_ care about the size of /usr/bin, give them the _option_
>       of a 'make install' without installing the aliases.
> 
> (Oh look, my /usr/bin has 3806 files in it. And except when I
> accidentally point the $%#@&! GNOME file dialog box at it, I don't
> _care_.)
> 

I'll second that. I've not heard a good argument against the git-foo 
commands. If they were going to be deprecated, it should have actually 
happened a long time ago.

-- BenC, late to the discussion as usual
