From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 02/11] Fix declare variable at mid of function
Date: Mon, 17 Aug 2009 17:34:45 +0100
Message-ID: <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
	 <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5Ac-0004tq-LV
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbZHQQep convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 12:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756627AbZHQQep
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:34:45 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:37439 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566AbZHQQep convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 12:34:45 -0400
Received: by vws2 with SMTP id 2so2554028vws.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9zM6KfhYXuRvzF1cPUkjWL+YI80CIvcXszIJqQDLYsI=;
        b=hsSgkq+oeBZPTq+P2hxrC6Rk+GsX/OlZtmfxqMvZoVgPA1Vg+Ry6DXxBqYeNwVbhou
         1+ifYXB8bOey9HsENqy4w12Q18I3ZLsO7+bDQp8G1bmzeeH6mUsqDJqiqwq6/5rVQ7SR
         oQMLIB4yRF5SIPqQT3oLNaubnZBz/3icmG1Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nHZth4kPC7ndxBSjPTTaZiLYkqgsxJ7zmdIbdpBIBBhyNi8QWe4Q2ppJzAUf/52srE
         RjlAv6qsQi6krVqmd1O3cytxzSVpkx9WJmXWGWy7mm2xGosFA8AFaUKGyPe4t2Vfc087
         VGxAXxtWpdlvi01sSnMe1mSrBRyIQH+6Xq/Bg=
Received: by 10.220.127.196 with SMTP id h4mr4994991vcs.32.1250526885831; Mon, 
	17 Aug 2009 09:34:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126223>

2009/8/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Tue, 18 Aug 2009, Frank Li wrote:
>
>> Some compiler such as MSVC can't support declear variable at mid of =
funtion at c file.
>
> Please wrap your commit messages after 76 characters.
>
>>
>> Signed-off-by: Frank Li <lznuaa@gmail.com>
>> ---
>
> How about this instead?
>
> =A0 =A0 =A0 =A0Avoid declaration after instruction
>
> =A0 =A0 =A0 =A0Microsoft Visual C++ does not understand this C99 styl=
e.
>
> ?
>
> The patch itself is good.

Shouldn't GCC be changed to use -std=3Dc89 as well to pick up errors fo=
r
compilers that don't support c99 (like the Microsoft Visual C++ C
compiler)?

- Reece
