From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-gui disagrees with git status
Date: Tue, 11 May 2010 01:27:28 -0500
Message-ID: <20100511062728.GA29654@progeny.tock>
References: <y2m3b1db1e51005101432je9e75a53vbb3781fa33aa83e7@mail.gmail.com>
 <20100510213926.GA7156@spearce.org>
 <buo632vj8px.fsf@dhlpc061.dev.necel.com>
 <4BE8F1DB.2060205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Bill Winspur <bwinspur@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 11 08:27:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBiwD-0004UE-Jh
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 08:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab0EKG1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 02:27:24 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:41483 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555Ab0EKG1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 02:27:22 -0400
Received: by gxk27 with SMTP id 27so4308172gxk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 23:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oE792/bGHIrCUTpn0W/gFrsT7m3MFsAIzy1HqRgXcrU=;
        b=mJF26bSN1KmmNmNdQtIulmac1eUBzhRdnL7vCcCaDZmX+znGFHMVJHvTVQPUOIEiC5
         qN8x3iAmmJI82T89UQ1Bt70FMxN2dmSmUswsQrzOuZxJZJ3eInxKrUc+LPMbfh7x7Pdo
         0bX2o7fmgB0TrPPqt0moplxO+L1Rnwnh7X+Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jZeLo5Jft1GXdIQTN/2xxJ9Rh2U9r7Ou+eL/34HRvkMFaKkkpP0mdFhZlH1+MGlk5D
         2kNNNPiut2twH98GGHyfrv64MOSChbH5XGjxYt4TO67sfFU6a/eCaCFljzX1/YTREUOe
         C4/rYJZM6gx0WPNWToMgEGwbq/BuVvBcPdjbQ=
Received: by 10.100.246.23 with SMTP id t23mr1394654anh.167.1273559241643;
        Mon, 10 May 2010 23:27:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id m39sm7097068ann.11.2010.05.10.23.27.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 23:27:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE8F1DB.2060205@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146872>

Johannes Sixt wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:

>>> Its more a feature.
>>>
>>> git-gui shows all untracked files, recursively expanding any
>>> directories which contain untracked files.  git status collapses
>>> them up.
[...]
> Oh, it *is* good behavior. Otherwise, it would not be possible to sta=
ge a
> file that resides in a currently untracked directory; you would have =
to
> fall back to 'git add' on the command line.

I would say rather it is the best we have.  Much better would be to
display untracked directories using a tree view (like gitk=E2=80=99s
treeview), starting out collapsed[1].

Jonathan

[1] http://bugs.debian.org/572805
