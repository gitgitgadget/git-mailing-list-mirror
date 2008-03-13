From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] git-cvsimport: fix initial checkout
Date: Fri, 14 Mar 2008 01:07:05 +0200
Message-ID: <e29894ca0803131607ld534fa2w318e7313913933ca@mail.gmail.com>
References: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
	 <47D9A836.9010601@catalyst.net.nz>
	 <e29894ca0803131604qa61adfbo22ff75d076feb899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Martin Langhoff" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:11:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZwXB-0008W4-1G
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 00:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657AbYCMXHM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 19:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757593AbYCMXHL
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 19:07:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:63591 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533AbYCMXHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2008 19:07:09 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2968802wra.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 16:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZqUsm6hhvtE6MSyv7RZamDS4raf0A0VBrK5oE/f0ssM=;
        b=HUtIYbq/m+vn1jCNIud/wvssKbVIzlH/g0A6xex3zIxM7/3u3OPx2H64s9wzogCYl1hK4JEuEGbpP1mQTE4602yeQKS1lHZT537Cfh6JHf7jEPFgA2CzXGZm1xOsx9EySybTZodGWDvudVw0ZEBzs2+58rivInV684vpA3lfymU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R/2FtCojIoIFwEp8DjHXDmcplMIyE+WOVOYsMCxg0zy7x/om89Xl6EHU++K+MmrNoRHnqLdgGl65VrwQUed7FrIZ+PTeXiYXATQvbpJp2CS1U81okmwOL6tlxLLPnz+eEtW8KEGdrASAqqmvWG9m75Hgq8+FAr+mZpH4vqUyuik=
Received: by 10.114.77.1 with SMTP id z1mr10538240waa.123.1205449626338;
        Thu, 13 Mar 2008 16:07:06 -0700 (PDT)
Received: by 10.114.60.4 with HTTP; Thu, 13 Mar 2008 16:07:05 -0700 (PDT)
In-Reply-To: <e29894ca0803131604qa61adfbo22ff75d076feb899@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77145>

Hi again,

Btw, the missing checkout file is,

sys / osxvideo / Makefile.am

I have a clue why (strange version number), but no idea how to fix it.
--=20
Marc-Andr=E9 Lureau
