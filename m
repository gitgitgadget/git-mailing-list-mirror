From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Useful tracking branches and auto merging
Date: Tue, 5 Oct 2010 20:49:25 +0300
Message-ID: <AANLkTinXJ5E_U=5uP_zvWLQBssQsYC74JyVv1N3-eMXK@mail.gmail.com>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
	<20101004204625.GH6466@burratino>
	<7vk4lw7g2m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 19:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Bdt-0000Wg-6m
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 19:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662Ab0JERt1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 13:49:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33375 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0JERt0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 13:49:26 -0400
Received: by bwz11 with SMTP id 11so4733259bwz.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ck5qWZJ+9MeBEQNNhOgd6BV8LIMHtUko3DNv6AYvwd8=;
        b=M7vId+UHQBmRMXeZPaL+4LhFVvZRZvGKmk9jbqcA9LayYn9Gb3ss91X1XhGeVz5XCR
         4Ch33nrhJ4Oo5n/jfUHozBmMT0KDjRgtNhiMU99GI1DkTPqKnEtN1SPgdgxhafZ7EBkp
         8E+TbKqR6l7G4/h7pK5Zc+F78ZlLUEw3ayLiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CswDLj4jLr2SfZDNmRGaRVWNajUx1gkJ81rmMZDQaxvr790RtzkQWeTN+CQTY6Pxtp
         88BJJlhGHMU1n+PwiM7PmYOnNdFqLoT8vlT7rHdYMhbmr9iPz8F/ZdkxT/udkHp3T4lK
         HsZxblqOIMDGGT6h5MAiqdNmOcjLXE31+u4AQ=
Received: by 10.204.65.145 with SMTP id j17mr8626865bki.209.1286300965351;
 Tue, 05 Oct 2010 10:49:25 -0700 (PDT)
Received: by 10.204.152.142 with HTTP; Tue, 5 Oct 2010 10:49:25 -0700 (PDT)
In-Reply-To: <7vk4lw7g2m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158218>

On Tue, Oct 5, 2010 at 7:35 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Maybe 'git pull --all' could be taught to eventually do this? =C2=A0=
That
>> would be incompatible with its current behavior of fetching everythi=
ng
>> and merging some random branch, but I don't think anyone is relying
>> on that.
>
> I vaguely recall that we had discussions to disable "git pull --all",
> which most likely is a mistake?

I believe this use-case is valid:

 * The user wants *all* his remote tracking branches to point to the
latest branch head in all the repos in the case the can be
fast-forwarded, and in the case they can't, print an error and
continue with the rest.

Right now I would have to do 'git fetch --all' go to every remote
tracking branch, and do 'git merge @{upstream}'.

Do you have a better idea how to achieve that instead of 'git pull --al=
l'?

--=20
=46elipe Contreras
