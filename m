From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Tue, 8 Jan 2013 18:05:18 +0000
Message-ID: <20130108180518.GO6440@serenity.lan>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com>
 <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se>
 <7vobh4sffw.fsf@alter.siamese.dyndns.org>
 <7vehi0qh4x.fsf@alter.siamese.dyndns.org>
 <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
 <50EC5D41.6030209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Khouzam <marc.khouzam@ericsson.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:11:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsdeX-0000Xa-5D
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab3AHSLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:11:37 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:59382 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756712Ab3AHSLg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:11:36 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2013 13:11:36 EST
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 39DF460658E;
	Tue,  8 Jan 2013 18:05:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aluminati.net; h=
	user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date:received:received:received:received
	:received; s=postfix; t=1357668331; bh=YdlgG07i6oMgNQbn20sgJOrrr
	xuO+5G/1iXB+2vo3pw=; b=kXVffpQrGz3rzbvpwvq8VFkuKDduIm3Zhj6U5Vih0
	df/birJAEHipVMA77v+HkSkzkpxsvq1ygforiJUjl5ml8rayKaOrtNZ1fKlqvCV1
	65Wy0oicRsqllipLL5TDhNHccB6mtssxwCgsOk1jsaEF2wD+Zaq2ouH/MFG7YzLh
	Go=
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w6uITL9QFfaO; Tue,  8 Jan 2013 18:05:31 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 8E676606586;
	Tue,  8 Jan 2013 18:05:30 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 5646B276E55;
	Tue,  8 Jan 2013 18:05:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GYl+vzumgoKX; Tue,  8 Jan 2013 18:05:30 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 33AA9276E52;
	Tue,  8 Jan 2013 18:05:20 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <50EC5D41.6030209@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212988>

On Tue, Jan 08, 2013 at 06:54:09PM +0100, Manlio Perillo wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Il 05/01/2013 21:23, Marc Khouzam ha scritto:
>> [...]
>> 4- Completion choices include their entire path, which is not what bash does by default.  For example:
>>> cd git/contrib
>>> ls completion/git-<tab>
>> git-completion.bash  git-completion.tcsh  git-completion.zsh   git-prompt.sh
>> but
>>> git rm completion/git-<tab>
>> completion/git-completion.bash  completion/git-completion.tcsh  completion/git-completion.zsh   completion/git-prompt.sh
>> notice the extra 'completion/' before each completion.  This can get pretty large when completing with 
>> many directory prefixes.  The current tcsh completion has the same problem which I couldn't fix.  However, I am 
>> not sure if it can be fixed for bash.
>> 
>> I personally don't think this is regression, just an slight annoyance.
>> 
> 
> After some searching, I found how this is supposed to be done.
> It is possible to use the -o filenames option to tell Bash completion
> that "the compspec generates filenames, so it can perform any
> filename-specific processing".
> 
> Unfortunately this option must be passed to the complete builtin
> command, and we can not do this, since the comspec not always contains
> filenames.

You should also be able to pass it to 'compopt' during completion in
order to change the behaviour for only the current completion.


John
