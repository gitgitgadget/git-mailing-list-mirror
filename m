From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 2/7 (v5)] basic api and porcelain
Date: Tue, 6 Apr 2010 23:40:35 +0200
Message-ID: <g2jc77435a81004061440l47f98094v99930eeb4ae6088@mail.gmail.com>
References: <4BBA40CD.5040301@gmail.com>
	 <dbe35e7547614331d19b811c180731aa@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 06 23:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzGVo-0000Nm-5y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 23:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab0DFVkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 17:40:39 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:50109 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab0DFVkh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 17:40:37 -0400
Received: by bwz1 with SMTP id 1so320170bwz.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fJCgXPYeOXzF/Zcve8hUhCnJHBB1bgn9WnhlmEWLDsw=;
        b=YxIvjqCRBGDPjkssD5GAwQrU9XyHrrKWTks0k3D4Jn2OtVRzw7t6YxjBGMzDgycUGp
         kWLopAeVIOK61kY3jPZXWuE6k66jNMPpU0hFMtOoGSfltnpj2hCA6rgRNj6HdiPzBdUX
         nw+3dxY5FN2evHQ0USB/cENl2SEHBPRWVIWaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JOrnDvhnKr4pKtO/1zZ2jachbej9X42Tqa2ouYYKMvOaM/yPYbdjcC8QPi5CTjX+SF
         x23jjvvRgu3cm78aIu0ID00lQ8PSXRhfjP9c9R2ike99Ql/J2pLSOF+GtoZCuBhuAOv1
         4hKuyQRl44eHMl9AIZH3jDqGslOUIHnQzUgRs=
Received: by 10.204.120.70 with HTTP; Tue, 6 Apr 2010 14:40:35 -0700 (PDT)
In-Reply-To: <dbe35e7547614331d19b811c180731aa@212.159.54.234>
Received: by 10.204.39.206 with SMTP id h14mr8823149bke.50.1270590035510; Tue, 
	06 Apr 2010 14:40:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144174>

> head.signature is 8 characters (see below), and so is "REVCACHE". =A0=
Surely
> either
> head.signature needs to be 9 characters, or you shouldn't use strcpy.
> Indeed, mostly you do seem to be using memcpy ...

aw shit, don't know how those slipped in there...  managed to do that
with slice pointer initialization too.  looks like I might have to do
another submission later.
