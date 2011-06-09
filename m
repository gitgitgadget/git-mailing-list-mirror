From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= 
	<jeremie.nikaes@ensimag.imag.fr>
Subject: Re: [PATCHv3 1/2] Add a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 9 Jun 2011 16:30:45 +0200
Message-ID: <BANLkTinduWxp5QR+Ri3REoqVY3hYPc_-rg@mail.gmail.com>
References: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr> <BANLkTikp6bGwVZqq7XAZ1bKVaMVLJ9XQiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Sylvain_Boulm=E9?= <sylvain.boulme@imag.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 16:31:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUgGO-0003us-UL
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 16:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab1FIObH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 10:31:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38890 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab1FIObG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 10:31:06 -0400
Received: by pzk9 with SMTP id 9so765520pzk.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=17IX48mxcTpAXLqFZXrwnd9OLwmcrmVLL8r1Pmf+cnc=;
        b=iftpa864PE/Gw9Z3finMkg/Uko2tkNLuqowLju/iYx5jlOxvCusOcDLqndjYJMMLlp
         gx6pgDmlyzaEkHEJqWNjlB4Si9S4AqcXow7+oT/eYNHNm7fg2dGuCfQ6rswIPKk5JtT1
         D4rw8ls5DO80hyxud7JZ1p/NgTmw62R3JBc1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=IpXodW60mwQLyXc8GhAB2SZVSvbZ0SO9OsMbAF11wrNpePaqGXlO/CDSmz7q6Hyfig
         XYMHTx9wOCG33X1Uy6ouDHkxuSLQ5IJ9s3mQiBgT4r6VtsaIr656K2If3t06hUg+Lc0l
         AjEKGPlXM+TAC+mUhHl7DfyCAhK9rxmejijr8=
Received: by 10.142.122.34 with SMTP id u34mr73260wfc.414.1307629865218; Thu,
 09 Jun 2011 07:31:05 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Thu, 9 Jun 2011 07:30:45 -0700 (PDT)
In-Reply-To: <BANLkTikp6bGwVZqq7XAZ1bKVaMVLJ9XQiw@mail.gmail.com>
X-Google-Sender-Auth: KW_dVI3b21H2wqPAsAQBAZ0_UZs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175527>

2011/6/9 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> On Thu, Jun 9, 2011 at 15:15, Jeremie Nikaes
> <jeremie.nikaes@ensimag.imag.fr> wrote:
>> +sub mw_capabilities {
>> + =A0 =A0 =A0 print STDOUT "push\n";
>
>> +sub mw_push {
>> + =A0 =A0 =A0 print STDERR "Push not yet implemented\n";
>> +}
>
> If it's not supported then you shouldn't advertise it above. Is there
> any particular reason you implemented it this way? E.g., did you
> encounter a breakage in remote-helpers if push is not implemented?

Well, if you dont give the capability to push, you get the following me=
ssage

error: failed to push some refs to 'mediawiki::http://mediawikiurl'

Which is less explicit than 'Push not yet implemented'.


Regards,
--=20
J=E9r=E9mie Nikaes
