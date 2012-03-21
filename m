From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Wed, 21 Mar 2012 10:45:37 -0000
Organization: OPDS
Message-ID: <4ED2974882CF442CB1A79A12057F94EE@PhilipOakley>
References: <4F63205A.6000202@seap.minhap.es> <vpqlin0n8w5.fsf@bauges.imag.fr><7vty1oivub.fsf@alter.siamese.dyndns.org><4F63571D.4070405@seap.minhap.es> <vpqaa3geiso.fsf@bauges.imag.fr><7vpqccipuv.fsf@alter.siamese.dyndns.org><7vlin0ip9l.fsf@alter.siamese.dyndns.org><7vobrq50su.fsf@alter.siamese.dyndns.org> <vpq7gyee4x7.fsf@bauges.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	"Nelson Benitez Leon" <nelsonjesus.benitez@seap.minhap.es>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 11:45:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAJ2j-00005e-JX
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 11:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280Ab2CUKpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 06:45:20 -0400
Received: from smtp2go.com ([207.58.142.213]:39238 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758237Ab2CUKpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 06:45:19 -0400
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193565>

From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr> Sent: Wednesday, March 
21, 2012 8:25 AM
> Junio C Hamano <gitster@pobox.com> writes:
>
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -846,6 +846,8 @@ cat >> "$todo" << EOF
>>  #  f, fixup = like "squash", but discard this commit's log message
>>  #  x, exec = run command (the rest of the line) using shell
>>  #
>> +# These lines can be re-ordered; they are executed from top to bottom.
>> +#
>
> Great, it says everything that needs to be said, in just a line!
>
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --

I agree. It says all that needs to be made clear.
Philip Oakley 
