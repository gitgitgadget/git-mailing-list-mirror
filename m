From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: Ensimag students working on textconv for blame
Date: Fri, 28 May 2010 12:27:10 +0200
Message-ID: <AANLkTinHLoYMgBawxmXpH5XSyJDb_743HEpfCmfqoRHu@mail.gmail.com>
References: <AANLkTimmR6yLLmCy_QvonjjgAp9F012DQb9TYCMiQ0yp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 12:27:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHwmq-0007cu-Kw
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 12:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab0E1K11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 06:27:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38273 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947Ab0E1K10 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 06:27:26 -0400
Received: by fxm10 with SMTP id 10so593350fxm.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=fpT06tYgizRXsb+bpDGH0UKErRURsYhTorFtmPNk9oU=;
        b=PFxBMNto+LWF5i51x9OJvK8PDIEYQLGfvS0KVCMCKgVke6fI3Kr3x2dU1j0UWfIWAk
         T4rpDBYLgdvrPZIzptD9CqWMQitkwgOuTWeYGWFFZswFE8z2cYRnkEOq55UC9fcyjOs/
         0aQs0I34C/BFgplgT+egGwcEjC9HpDYSAjwxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=lNgOQ3vcFI9+FVNp580tutouHXm0YQ25qDS+3kaK/Ds7Wf1HKhK8VncuxceJT5EtgV
         ICu+lxRg47cx0Ay6thpiDFRjJC0Pvv5ZCapuSz4DMp66vnABatwnXDtQjrHxrRDC7iDF
         jFA+ws65nEbj3eh37Q24pwVRjQWiGKnyijjlc=
Received: by 10.239.192.74 with SMTP id d10mr6739hbi.74.1275042445135; Fri, 28 
	May 2010 03:27:25 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Fri, 28 May 2010 03:27:10 -0700 (PDT)
In-Reply-To: <AANLkTimmR6yLLmCy_QvonjjgAp9F012DQb9TYCMiQ0yp@mail.gmail.com>
X-Google-Sender-Auth: HAJeGO5BPnqdhdAyAK0BegYXcoM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147925>

Hi,

Axel, Cl=E9ment and I are french Ensimag students
( http://ensimag.grenoble-inp.fr/ ) working for the community on the
occasion of an end-of-year project (in equivalent of master 1).
So it is kind of a mini-google summer of code for us.

We are mentored by Matthieu Moy who introduced us in the thread:
http://article.gmane.org/gmane.comp.version-control.git/147487/

We are currently working on a textconv support for git-blame.
We are getting to a first version that we will soon communicate.

Afterwards, we thought about working on git-merge.
Actually, when having some local changes in some files
that would be overwritten by merge, git-merge aborts giving the
first file for which there is a problem. If we commit or stash the
changes on this file and try again to merge, the second file for
which there are some local changes will appear.
What will we try to do is to provide to the user a list of all the file=
s
for which there is a problem before aborting.
Do you think it is a good idea?

Thank you all for your time.

Cheers,
Axel, Cl=E9ment and Diane
