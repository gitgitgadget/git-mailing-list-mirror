From: Alex Budovski <abudovski@gmail.com>
Subject: Re: [1.8.0] 't/' is standard name for directory with tests
Date: Tue, 1 Feb 2011 11:12:58 +1100
Message-ID: <AANLkTi=uOhgnKxRpA0Vm2uSe+uznPwjRB-=2e81VTf-f@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home> <m3d3ncag7r.fsf_-_@localhost.localdomain>
 <alpine.LFD.2.00.1101311728180.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 01:13:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk3sb-0004RM-Ll
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 01:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab1BAANU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 19:13:20 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40982 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab1BAANU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 19:13:20 -0500
Received: by ewy5 with SMTP id 5so2864455ewy.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 16:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Vo8ncJxebV4I1zOHKhe6slRShk6aVdCOT0P34B1R8R4=;
        b=UUmXdQHXI95HzXnlxZeEFFV0kf6hDDobNNwhd33Z/Lh4tQp17HmivASeRoRkQODKln
         rpmSQT4Ood4sIDXtWmpkarAY5HpG/HYDwLg6oqiBSWPcouVoJhKtGkiiHPMLAg5+AVWK
         bzAUo7OoUL87mqvv/JP5tYxyFJIq91P8EidH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MdsmrtzCnBKdcP1f+ygENY0RGRVMpYF1qLMmtPc1MjKXoAU/bdhM0FwA1/lxejfQyO
         dBUH4Uer3kR7VxIapAYi4/Bq6SPZvNKvX9ssujCt6M3JWvLKXiP2ElBzadBD7Eyx5GCL
         17Kphp7BVKKvGr/xpdHAUUX73/2SW+URcJSCM=
Received: by 10.14.17.225 with SMTP id j73mr7641578eej.26.1296519198597; Mon,
 31 Jan 2011 16:13:18 -0800 (PST)
Received: by 10.14.22.78 with HTTP; Mon, 31 Jan 2011 16:12:58 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101311728180.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165779>

>> Nope. =A0't/' is the standard name for directory with "normal" tests=
, at
>> least in Perl / CPAN land, where TAP comes from ('xt/' is for extra
>> tests)
>
> So what? =A0It is not because Perl has set this horrible precedent th=
at we
> have to perpetuate it. =A0I personally never saw t used as a director=
y
> name for tests before Git, and I'm not that young anymore unfortunate=
ly.

The MySQL project (and its clones) also uses the t/ convention.
