From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] Do not decode url protocol.
Date: Tue, 22 Jun 2010 18:08:52 +0200
Message-ID: <vpq39wf82y3.fsf@bauges.imag.fr>
References: <AANLkTik2M4Wxa-C6iRf7ShlcrwXu1ALNXtKwbA-mO5ge@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Jun 22 18:12:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR65W-00074X-JF
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 18:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab0FVQMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 12:12:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:50806 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab0FVQMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 12:12:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o5MG8qxP014877
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Jun 2010 18:08:52 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OR61s-0001Uk-R2; Tue, 22 Jun 2010 18:08:52 +0200
In-Reply-To: <AANLkTik2M4Wxa-C6iRf7ShlcrwXu1ALNXtKwbA-mO5ge@mail.gmail.com> (Pascal Obry's message of "Tue\, 22 Jun 2010 13\:58\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 22 Jun 2010 18:08:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149483>

Pascal Obry <pascal@obry.net> writes:

> -- 
> 1.7.1.524.g6df2f
>
> Ok, given Matthieu comments here is another version of the patch which
> should apply cleanly
> and won't clobber log message with my comments!

Thanks for making the life of our maintainer easier :-).

Unfortunately, it's still not the right place for comments ;-). That's
OK with Git AFAICT, but readers expect them between the --- (tripple)
and the diffstat.

Unless I missed something, this version doesn't address my earlier
comment:

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Pascal Obry <pascal@obry.net> writes:
>
>> @@ -70,9 +70,18 @@ static int url_decode_char(const char *q)
>>  static char *url_decode_internal(const char **query, const char *stop_at)
>>  {
>
> This function is called from multiple places :

[...]

> I don't think you want to avoid escaping until the first slash in
> url_decode_parameter_name and url_decode_parameter_value. I think you
> want to patch url_decode, not url_decode_internal.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
