From: David Kowis <dkowis@shlrm.org>
Subject: Re: Thoughts on adding another hook to git
Date: Mon, 12 Jun 2006 14:22:19 -0500
Message-ID: <448DBEEB.3000308@shlrm.org>
References: <448DB201.5090208@shlrm.org>	 <f36b08ee0606121206k62242354k13671f95da6b1418@mail.gmail.com>	 <448DBC2B.1070807@shlrm.org> <f36b08ee0606121218s6cdcfec2i42482ed5284a45e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 21:22:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fprzd-0000dQ-8Y
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbWFLTWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbWFLTWa
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:22:30 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:43165 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP
	id S1752206AbWFLTW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:22:29 -0400
Received: from pimout5-ext.prodigy.net (pimout5-int.prodigy.net [207.115.4.21])
	by ylpvm01.prodigy.net (8.13.6 out spool5000 dk/8.12.10) with ESMTP id k5CJMHKl006965
	for <git@vger.kernel.org>; Mon, 12 Jun 2006 15:22:21 -0400
X-ORBL: [66.143.247.87]
Received: from mail.shlrm.org (adsl-66-143-247-87.dsl.snantx.swbell.net [66.143.247.87])
	by pimout5-ext.prodigy.net (8.13.6 out.dk/8.13.6) with ESMTP id k5CJMKaZ135756;
	Mon, 12 Jun 2006 15:22:20 -0400
Received: from [192.168.2.111] (rrcs-24-173-63-133.sw.biz.rr.com [24.173.63.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.shlrm.org (Postfix) with ESMTP id 2BD9F28034B3;
	Mon, 12 Jun 2006 14:22:20 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0606121218s6cdcfec2i42482ed5284a45e3@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21733>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Yakov Lerner wrote:
> On 6/12/06, David Kowis <dkowis@shlrm.org> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> Yakov Lerner wrote:
>> > On 6/12/06, David Kowis <dkowis@shlrm.org> wrote:
>> >> I'd like to be able to modify the commit message before it ends up in
>> >> the $EDITOR.
>> >
>> > Can't you define $EDITOR to point to some script
>> > which modifies the file as you wish then calls the
>> > real editor on it ?
>> >
>>
>> I could, but then anything else that uses $EDITOR would also be affected
>> in the same way... Which would produce interesting results.
> 
> git-commit sure creates those temp files with
> specific naming in specific dir. You could check for
> that in EDITOR script. In the script, you could even check
> the name of the parent process.
> 

This is true. However, I'd be running that script every time something
invoked $EDITOR. And some people may not like that solution. I'm
thinking that more than just I will like to use this pre-edit hook.
Especially in the distro I'm helping develop.


- --
David Kowis

ISO Team Lead - www.sourcemage.org
Source Mage GNU/Linux

Progress isn't made by early risers. It's made by lazy men trying to
find easier ways to do something.
  - Robert Heinlein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iQGVAwUBRI2+68nf+vRw63ObAQo6Kwv/bmLf8f54lm7sXekww8olFwT3SkE8orHk
BozzIyW8foz+FLtVbjQQbbGw1RgLrL5zPn+De+BM3LwXabhqnsVca2KpQVMkLaqx
aJwjn2JvL6ujG3ponuCCPTk5VhzU0C/Su15eIMa86O2EFu6Y0HBhw/hOnyEWJiYa
tOxPETizJHD1YbneoTJmu+tQFaKbjAD/3tUMDkQBp9h1QkbZHD5LQUjozepLZplY
PfOvZIP9fT6GDsK5SuweGrYZHjzuV0RlrwN191No3FsJMMX7+PQ85MBvj1p/xJG7
VO+z33+IYPascpm/3NdpjdtKAh72+rfW5OUd8FN1ISwPtY9dJeh5zaaCTB+oEqL4
56pchLL33SFphOO5//YwHcwgX61tPK0stsVpjfdQHEjz8BHNSoBhZw3lw/AvO+63
UhiA3rjiIFrYe9piJHlX+IxoNo5OaLJNO2KjV9k15+0FxSzbKPn3Pt2Ee90ootEn
8NzHFVoyOWnt5mPM+jQr4DsPgrikeUaO
=3hwD
-----END PGP SIGNATURE-----
