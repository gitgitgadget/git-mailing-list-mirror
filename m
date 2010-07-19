From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [http] Git error messages reveal password encoded in the URL
Date: Mon, 19 Jul 2010 14:05:27 -0700
Message-ID: <AANLkTikP3eNVs34ZcB9gHqV60-aqexfCPgcyBWSGn_Y7@mail.gmail.com>
References: <4C4484A4.5010009@gmail.com> <m3aapnmbid.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ketan Padegaonkar <ketanpadegaonkar@gmail.com>,
	git-dev <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 23:06:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaxX8-0004HI-RP
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 23:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966782Ab0GSVFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 17:05:50 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47664 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966407Ab0GSVFt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 17:05:49 -0400
Received: by qyk35 with SMTP id 35so1903176qyk.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=J0TT6R0om4+SqmHd6UtPwEjaI6S9aQ3fQ57RDmLAPMo=;
        b=vdJmyp3FjGj+Iu4mv/JTkMLFdQsbZtZyI0Yv+X0LE/YwE5OzFRo+bqV8xKoG0MNLoe
         1nXEeGqfGD9LTFIQCwRxMDh78GnIcaNvTpeY1ATFefZtKDvoe0iBGmx2Oo0hj10KGdBs
         OWsaRpbIs/cSDM0XaMJk8hgUx+V5TF2Scmgl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BpYeQdqf+io3CHOqNJnN1mS83y+PL6F2vEicqDoHs3OqHcY0vqYMPzM77jVBHnrHcd
         XdwckZPb4p9SP5qZxcAkTBb86RAhkenPNAEc/8smhGwrVdYSR/ueb6YxyZxbswAEQA3C
         jEDebmf6rKmAcmGvrd16735SvIOXNYycTb604=
Received: by 10.224.28.211 with SMTP id n19mr5165103qac.258.1279573548219; 
	Mon, 19 Jul 2010 14:05:48 -0700 (PDT)
Received: by 10.229.236.210 with HTTP; Mon, 19 Jul 2010 14:05:27 -0700 (PDT)
In-Reply-To: <m3aapnmbid.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151281>

On Mon, Jul 19, 2010 at 14:02, Jakub Narebski <jnareb@gmail.com> wrote:
> Ketan Padegaonkar <ketanpadegaonkar@gmail.com> writes:
>
>> We use http to serve our git repos, in order for git to not ask me a
>> username/password everytime,
>
> Errr... WTF? =C2=A0Can't you configure SSH (use ssh-add, perhaps toge=
ther with
> tool such as keychain) to use public key based authentication?
>

I don't think SSH/ssh-agent/pubkey would actually help, given that
it's a https URL.  Unless I'm missing something here?

>> I've put the following in my .git/config:
>>
>> [remote "origin"]
>> =C2=A0 =C2=A0url =3D https://user:pass@host/repo.git
>>
