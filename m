From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Error on push (unable to create temporary sha1 filename)
Date: Wed, 24 Feb 2010 08:54:56 +0800
Message-ID: <be6fef0d1002231654r4fe08149qa937bbd9cc83d6a2@mail.gmail.com>
References: <8dacd7b31002231311q46c1c3b9o63c57fabe696f2ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Niklas Hasse <jhasse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:55:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk5Wx-0001cU-NM
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 01:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab0BXAzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 19:55:00 -0500
Received: from mail-iw0-f177.google.com ([209.85.223.177]:43318 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab0BXAy7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 19:54:59 -0500
Received: by iwn7 with SMTP id 7so3689693iwn.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 16:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2JGakwjskMNQbYRHBFQc2nA3bArxAW7zicmqiDYGClw=;
        b=oibitxs4rROI/etz433TaZn1++gjiTMTehUOqAqfEZFm8EsxPKQ+yNk4AyQ5FS+EmG
         Q+NRRVL9rqupaRyRYscUJ76hyHuKTzu688EHTM+tbrqF/4gXjL9XOV0L9n1JMbCeUSj6
         q1YRxeFUq7Lo1UjQzLNUXhg0rtiIn0pLSHdHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vOsDGqFLp3mqFh5LKl3+JcIjjJNAOjNyPazrDnRUWwKUp/rjiSapyQqRRkoGU1vPga
         lJA6kx8FPYDKzqN0r/2ehFhYprUvM7JuB2HLTl6MC83FlyOZDS6Odhtkg3NLKpnheiBS
         819sih3jBTKY7gnuo+rea+m9xRsQ2Wham+E04=
Received: by 10.231.169.145 with SMTP id z17mr1434294iby.83.1266972896862; 
	Tue, 23 Feb 2010 16:54:56 -0800 (PST)
In-Reply-To: <8dacd7b31002231311q46c1c3b9o63c57fabe696f2ea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140884>

Hi,

On Wed, Feb 24, 2010 at 5:11 AM, Jan Niklas Hasse <jhasse@gmail.com> wr=
ote:
> git push origin master
>
> Counting objects: 37, done.
> Compressing objects: 100% (27/27)
> Writing objects: 100% (31/31)
> Writing objects: 100% (31/31), 5.59 KiB, done.
> Total 31 (delta 11), reused 10 (delta 1)
> error: unable to create temporary sha1 filename ./objects/0e: File ex=
ists
>
> fatal: failed to write object
> error: unpack failed: unpacker exited with error code
> To git@myserver.de:django.git
> =A0! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to 'git@myserver.de:django.git'

could you try running "git gc"? Perhaps you have temp files from
previously aborted/failed pushes lying around.

--=20
Cheers,
Ray Chuan
