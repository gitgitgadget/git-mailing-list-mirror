From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] builtin/clean.c: Use STRING_LIST_INIT_NODUP.
Date: Mon, 6 Sep 2010 21:03:19 -0300
Message-ID: <AANLkTinGdaAgnYBGB2Y9O6=JrnjqAqRkcNewoT1=jwXL@mail.gmail.com>
References: <1283815975-11107-1-git-send-email-tfransosi@gmail.com>
	<7vpqwqs9xu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 02:03:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oslew-0000Lc-9W
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 02:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab0IGADW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 20:03:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59142 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab0IGADU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 20:03:20 -0400
Received: by qwh6 with SMTP id 6so4208419qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W3Rs8NAUdvhVy3KvdvdkI3pCQMDa7kgpQOv+riuXjb0=;
        b=EqpA0dkp9a8r6ykC9npivUsZtxROtLa5THdCjSFdwxlVkvle592yHIhcqXt+V0eaB4
         VjMuY/1NDn7uRoNNd47ZnphhckIwaFWApd7N1uHV4m3bKA+VwHJFED9tKxso76+XTdY5
         uh+iD0L+XUWbUt4jmH4m97ANirZuXXqy71hdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vu+AIxoP21EAjE/Eb4YuR1IqaFvNzkJtLYcNdX1FGalB7HJe1ABEbXjUT4YUcmzClx
         YnuscKA1INXGx5PxMRY+u5kmm/7wi8IgKw7PlyfM2whthz/dsxAxVs1uSqqt7XBV0gbo
         7mqCbmu8rVWE3OpojzeFwVQEQmje+D7TDqWiQ=
Received: by 10.229.52.32 with SMTP id f32mr3023696qcg.265.1283817799322; Mon,
 06 Sep 2010 17:03:19 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Mon, 6 Sep 2010 17:03:19 -0700 (PDT)
In-Reply-To: <7vpqwqs9xu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155648>

On Mon, Sep 6, 2010 at 8:56 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Good eyes. =C2=A0Is this the last spelled-out initialization (I didn'=
t check
> deeper than running a quick grep for "struct string_list .*=3D *{")?
>
Yup! This is the last. :)

I checked firstly with:
$ git grep -e 'struct string_list [^ ]* =3D {.*'

And then with yours:
$ git grep -e "struct string_list .*=3D *{"
