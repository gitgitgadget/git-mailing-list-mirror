From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH] shell-prompt: clean up nested if-then
Date: Tue, 19 Feb 2013 09:17:17 +0100
Message-ID: <5123350D.4010802@xs4all.nl>
References: <1361204512.4758.10.camel@mas> <1361204601-4573-1-git-send-email-martinerikwerner@gmail.com> <20130218191040.GB3234@elie.Belkin> <0c94f24b-f7ee-4699-87a7-6861b927cea4@email.android.com> <1361228206.17734.4.camel@mas> <7vtxp98bmx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Erik Werner <martinerikwerner@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	trsten@science-computing.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 09:25:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7iW2-0002qE-Cg
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 09:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371Ab3BSIZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 03:25:03 -0500
Received: from smtp-vbr19.xs4all.nl ([194.109.24.39]:1308 "EHLO
	smtp-vbr19.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab3BSIZC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 03:25:02 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2013 03:25:02 EST
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr19.xs4all.nl (8.13.8/8.13.8) with ESMTP id r1J8HHgv048863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Feb 2013 09:17:18 +0100 (CET)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vtxp98bmx.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216576>

On 19/02/13 00:07, Junio C Hamano wrote:
> 
> I think you are misreading a suggestion that is somewhat misguided
> (yes "[ <condition> && <another> ]" does not make sense, but that is
> not applicable to "test <conditon> && test <another>"); ignore it.
> 
> It is fine to write "test <condition> && test <another>" and that
> works portably to even pre-posix systems.

(that's like doing "ls file && rm file" )

> 
> But the existing code the patch touches favors [] over test
> consistently; that alone is a good reason to stick with [] in _this_
> script, even though it is against Git's overall shell script style.
> 

I suppose it would be fine if a patch was sent to update the entire
git-prompt.sh code to be more in line with the Git shell script style...

My original gripe was just with doing it in one place while leaving all
the others unchanged. It makes for messy reading and leads to confusion.

Cheers

Simon
