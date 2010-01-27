From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Patchdiff
Date: Tue, 26 Jan 2010 19:09:54 -0600
Message-ID: <20100127010954.GA7628@progeny.tock>
References: <fabb9a1e1001261606i4f706387vaf5647436e454fb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 02:09:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZwPt-0000Pl-5Z
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 02:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab0A0BJx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 20:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754916Ab0A0BJw
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 20:09:52 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:61394 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0A0BJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 20:09:52 -0500
Received: by iwn3 with SMTP id 3so1019855iwn.19
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 17:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vlNbtwDx6WBMlYVTL4dqXo2EUAmty4SNp0KxAP29dXY=;
        b=DZWdcQ0iLpjlzccbNIWR06I0gWNLsUriSWIv7f0skfjIoA0bPr9uRHmwefyyRMmLZj
         hCgipKHJjrg+3fBQtiWT2X/yT8d1ggQtKKmgJly4YVNkVFWPy5ZiomaQu0afReVn3DzO
         km1Hw1nF6TYZNhlEdKQXU1qPU/IBAjCjeR6oI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nzptxFVtclX3+UxiePKOaXWm8FyPQhxgEQI4JUx9+F/Fo5EHidW0cGlnz+RTWa/cnf
         VbndMOiakLuciWCq30Pa2xtoQULsRMtiek4vPfyBcIfWccj7oxvbtaCEcUAP+LoqMIs8
         fET9H40rebyRGTOKhxaDASCrBNBAWS8K9Z6sw=
Received: by 10.231.160.149 with SMTP id n21mr2011661ibx.93.1264554590408;
        Tue, 26 Jan 2010 17:09:50 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm6476299iwn.8.2010.01.26.17.09.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 17:09:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1001261606i4f706387vaf5647436e454fb4@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138095>

Hi,

Sverre Rabbelier wrote:

> Do we have anything that allows me to compare two versions of a patch=
?
> In theory it'd do something like "apply both patches to the their
> merge base, then show the diff between the results".

It=E2=80=99s not git specific, but maybe interdiff [1] could help.

Ciao,
Jonathan

[1] http://cyberelk.net/tim/data/patchutils/stable/
