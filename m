From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 14:06:41 +0200
Message-ID: <94a0d4530902140406l5ccd79b6x964ad53b83079799@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <m3skmhteuk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 13:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYJJq-0008Iv-SM
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 13:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbZBNMGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 07:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbZBNMGo
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 07:06:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:12568 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbZBNMGn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Feb 2009 07:06:43 -0500
Received: by fg-out-1718.google.com with SMTP id 16so43232fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 04:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2HuJwOToybwemrCruq3CWQtvEm7zfYjsTLnrhlyYvKo=;
        b=tF4P96e3Z38R/kRlRJ5gBBkLa475FY1uln/DyDtMK3pbx3eDCN/oh1CzpFJkQPVbzo
         6JQvov2CdZ3sAD65Q1hTsn457VIeH2QlsGNlBDCO/YqRTqVKn0fU8zo+Wwcp1NqN/ocH
         9SVcnWkdjgnAdRK19YYT6ALA54L68BQYqba50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=osIvEPziPGmqb80zFxaBnMlhgqnF7UGWzFgYbwOEo0J5mVR6oXH3ZifOPMW2b09fli
         HLrccIAF6NdxVOpEikksj79x4zKkKzLctMnfQcCl0rII4N27iY4m5BhX3rxncdKVfi23
         7yu1yKkwlumB8z0exbJvII5wNFh4Wp2t9EXKA=
Received: by 10.86.51.2 with SMTP id y2mr302347fgy.2.1234613201678; Sat, 14 
	Feb 2009 04:06:41 -0800 (PST)
In-Reply-To: <m3skmhteuk.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109866>

On Sat, Feb 14, 2009 at 1:52 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Reorganizing the code to use parseopt as suggested by Johannes
>> Schindelin.
>
> [...]
>> -static const char git_config_set_usage[] =
>> -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
>> +static const char *const builtin_config_usage[] = {
>> +     "git config [options]",
>> +     NULL
>> +};
>
> Just asking: why this change?

So it's easier to understand and maintain?

>> +     OPT_BOOLEAN('z', "null", &end_null, "end values with null character"),
>
> Terminate and NUL.

Ok. Junio already suggested that.

-- 
Felipe Contreras
