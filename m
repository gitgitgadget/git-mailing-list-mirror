From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #03; Wed, 10)
Date: Fri, 12 Mar 2010 11:41:04 +0700
Message-ID: <fcaeb9bf1003112041m7c8b4012j187d9a0c2537acbb@mail.gmail.com>
References: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 05:41:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npwgk-0006bU-Tf
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 05:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab0CLEl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 23:41:26 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40039 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab0CLElZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Mar 2010 23:41:25 -0500
Received: by pzk32 with SMTP id 32so468114pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 20:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NAt0wYvio1tFwnebCeowc3FzjnqolewwIHFKVKT4RrQ=;
        b=a5N8aLERTApw+poEokU13oqUaHGVHV7GV4yfCuqLkY/M5H2fW6Lul1IQw5Q3CGAhTz
         S5L9C0Cub/FeJDrv+rvUh/1pIg5cy8eiuHEi5t4ybZ7WsXCc3oiHksDJRyOz0obnNVGT
         u5b5oRRJAD+O6bl/P8L9CmAlme0HkZOdbeTI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Bq7o6w/FQBAJQKeGRZNJ6AlJUEhbzzm4N2PlAZtRZfsqOcNCwaJDQ+dYVkk/Ai7+9g
         3lXUu/MJDV9IB+zmK4FbtXUunQ6842z9bEf2tbW0UWUWM4D4sz3lU++nz+IcrUNq5i2R
         EbKu9oxfP6I0ZAVC6X+7VUNH6bGnxTqvjDwjQ=
Received: by 10.141.88.3 with SMTP id q3mr175025rvl.218.1268368884553; Thu, 11 
	Mar 2010 20:41:24 -0800 (PST)
In-Reply-To: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142014>

On Thu, Mar 11, 2010 at 10:21 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> * ld/push-porcelain (2010-02-26) 4 commits
> =C2=A0(merged to 'next' on 2010-03-02 at d15bb1e)
> =C2=A0+ git-push: add tests for git push --porcelain
> =C2=A0+ git-push: make git push --porcelain print "Done"
> =C2=A0+ git-push: send "To <remoteurl>" messages to the standard outp=
ut in --porcelain mode
> =C2=A0+ git-push: fix an advice message so it goes to stderr

"diff -q" in t5516, "add tests for git push --porcelain" is not
suported on Solaris. test_cmp should be used instead.
--=20
Duy
