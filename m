From: Carlo Trimarchi <mr.spoon21@gmail.com>
Subject: Re: pushing a branch without merging
Date: Mon, 20 Jun 2011 16:56:12 +0200
Message-ID: <BANLkTikWDzZD8b-aUMXJwByeN3tBsYipgQ@mail.gmail.com>
References: <BANLkTin4fpwX9NgnP0U1+z9tRA=akR6MDg@mail.gmail.com> <4DFF5B41.1000108@micronengineering.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Massimo Manca <massimo.manca@micronengineering.it>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 16:56:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYfu9-0004J5-HR
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 16:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab1FTO4e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 10:56:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34602 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab1FTO4d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 10:56:33 -0400
Received: by yxi11 with SMTP id 11so2107949yxi.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=nXe/zTjlSyykfgMEjGPrnT+cIUKdXfwUkCl2IIPMMq8=;
        b=VsMu9QTJgB98Zpb/1TVnP0PiqlNMAkGi+8HwS6bEf5nF5qC/XOq71Mp4jLgLz0GlzZ
         nt+rqdKCPu6ciCmKX9yur8KmXeXFDMhAeXSLDU9uU30q3d6IBIKqKlgfizO92SVzywDG
         wlZ1l+lcMcR7ijJXsQalQ8VN5hSKeMmzridzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=axOXHJb+qt3XUWLEBjviVH6M3gv9zxQ7LUo6+SU3Obzr+Ab/YsS76KR2cF7jyjCkGy
         znEj96KdkeVGe6xmIiA+afEZMQMjVhK8rWbW5xlOd9cmQzuygcAnDQ73q0lXk5pbv2D/
         Y1vHVHaaWPpHDAGt1mERlahAfdFycDo/sqld8=
Received: by 10.236.161.170 with SMTP id w30mr5260767yhk.168.1308581792137;
 Mon, 20 Jun 2011 07:56:32 -0700 (PDT)
Received: by 10.236.108.143 with HTTP; Mon, 20 Jun 2011 07:56:12 -0700 (PDT)
In-Reply-To: <4DFF5B41.1000108@micronengineering.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176070>

2011/6/20 Massimo Manca <massimo.manca@micronengineering.it>:

> then you edit and add files on the newly branch, so as usually you ha=
ve
> to use:
> =C2=A0 =C2=A0git add .
> =C2=A0 =C2=A0git commit -m "what I change on this branch" -a
>
> When you have to update the remote then staying on experimental branc=
h
> you can:
> =C2=A0 =C2=A0git push

This is exactly what I did, but on the server it showed the old version=
=2E
This is what appears when commiting:

=E2=9E=9C  website git:(experimental) =E2=9C=97 git commit -a -m "commi=
t message"
[mario_style 7764c96] commit message
 2 files changed, 315 insertions(+), 204 deletions(-)
 rewrite index.html (88%)
=E2=9E=9C  website git:(experimental) =E2=9C=97 git push website
Counting objects: 7, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 451 bytes, done.
Total 4 (delta 2), reused 0 (delta 0)
To ssh://myserver.bla.com/home/user/website.git
   f93d62f..eb8e369  master -> master

I'm in the experimental branch, but in the end it shows master ->
master. Maybe that is what it is supposed to show, not sure.
