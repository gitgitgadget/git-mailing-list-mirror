From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH I18N filenames v2 2/3] Use I18N-wrappers everywhere in Git
Date: Thu, 29 Oct 2009 10:30:58 +0100
Message-ID: <81b0412b0910290230x9092c88n414ad0e03fc7f8db@mail.gmail.com>
References: <1256752900-2615-1-git-send-email-timur@iris-comp.ru>
	 <1256752900-2615-2-git-send-email-timur@iris-comp.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Timur Sufiev <timur@iris-comp.ru>
X-From: git-owner@vger.kernel.org Thu Oct 29 10:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3RLV-0007zh-PI
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 10:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbZJ2Ja4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 05:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbZJ2Ja4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 05:30:56 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57728 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbZJ2Jaz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 05:30:55 -0400
Received: by bwz27 with SMTP id 27so2040646bwz.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=okcSGLxVbeI2iQlzhIgm9IPoTCkDQv/YFl1ZY9GOsjE=;
        b=nyMOCZ1f8I1V5MGdpFz1SFxcXRXd812gC+oC8dGMCDJI3KfJbqzWFNjS0lGaldwK9g
         rUju+RMvKp/FclzesXf51EoxL5wuGmQOxrrRcllDpAcz/cV7vhvYTX+bgh8R19/WJuyG
         2S26kkKn1JGc6qExylHG+5Q4JIp4ko0+bdsdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HfexpY+f0C7mU2u6g71YDgBZeKW0v8E540xqysBeRYKxigoWH4fAweQ4GqjjZDP0xN
         USSDOr/fwFvJUS+R4wvOw+eSRBQRS9wYmJvpjHqSFi6vA0+GqRKrEW+G+cNaatT7W1YH
         k6Ypr9FUADWAgupGOEaosPs4bD+c3e0TFmI3g=
Received: by 10.204.32.209 with SMTP id e17mr8073bkd.84.1256808659312; Thu, 29 
	Oct 2009 02:30:59 -0700 (PDT)
In-Reply-To: <1256752900-2615-2-git-send-email-timur@iris-comp.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131577>

On Wed, Oct 28, 2009 at 19:01, Timur Sufiev <timur@iris-comp.ru> wrote:
> Signed-off-by: Timur Sufiev <timur@iris-comp.ru>
> ---
> =C2=A0abspath.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A01 +
> =C2=A0attr.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 =C2=A01 +
> =C2=A0bisect.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A01 +

Instead of modifying all these files you could just have put that
darn header in compat/mingw.h
