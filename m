From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: cvs update vs. git pull
Date: Fri, 28 May 2010 13:07:00 +0000
Message-ID: <AANLkTikPWfNhL1HxYQdtdPeJpHxrm5qDkkwbXFM6MAV2@mail.gmail.com>
References: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
	<vpqhblss65x.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Moser?= <mail@renemoser.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 28 15:07:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHzHK-0007JS-ED
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 15:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab0E1NHE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 09:07:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56633 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab0E1NHC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 09:07:02 -0400
Received: by gwaa12 with SMTP id a12so881930gwa.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r4kHdVt3JUTBmr5BXbW3X+d0J9xeMIEAtiaQjVpx7DA=;
        b=cqxtsu9Nph2drBbnZBTUmgVH0GkRLBdNwhSxhA/z8oWPm7ZRqAmYVa8WxwqCjCeZC8
         EBdnRPOrZgGcXUqjb9oUWtZ14ctjz+S4cNI8bOnYxVrXIMN0RPmN8XgOMXAN7F7saDGw
         bvpJKc56ei7iCJ611NVQ+ENGEAm+SvhyNGRUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t2+j0v52qcMzCG/210Nv9rhSd3tEtorTzWxEo8HoqAs7pVnhLOngItPmWOp8YJoo5+
         ajZyjQ6oRb2+Ki1owRpecPkbYBLMC3IC3RvvWSru7x6VjqIV6y1sSCOY2BLgMC1/mJXd
         Tc8o9HwVsFeUtsPYk6bisGNSJqPbvpSUuUTWI=
Received: by 10.42.5.206 with SMTP id 14mr257782icx.17.1275052020932; Fri, 28 
	May 2010 06:07:00 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 28 May 2010 06:07:00 -0700 (PDT)
In-Reply-To: <vpqhblss65x.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147928>

On Fri, May 28, 2010 at 09:54, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ren=C3=A9 Moser <mail@renemoser.net> writes:
>
>> One problem we have is, that if there is a commit to cvs while the c=
vs
>> update of the build job is running (and this takes 20 minutes), then=
 we
>> get some inconsistence, the build will fail.
>
> Git will also bring a big performance improvement here. The duration
> of the "git pull" will be mostly O(number of modifications since last
> pull), not O(total number of files).

A while back I tried converting a huge (~40k directories) CVS
repository to SVN and Git. Both CVS and SVN took around 10 minutes to
cvs/svn up. git clone took around 8 minutes but each pull was around
5-15 seconds (I/O and network bound).

They eventually picked Bazaar for non-technical reasons. But yeah,
Git's much faster to upgrade than CVS/SVN.
