From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] handle_alias: provide GIT_CWD to !alias
Date: Wed, 27 Apr 2011 14:40:00 +0700
Message-ID: <BANLkTinEiT1_8czdY2DtBnY-5CqN1XAVcw@mail.gmail.com>
References: <4DA59B27.50506@ge.infn.it> <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net>
 <7v1v0od557.fsf@alter.siamese.dyndns.org> <4DB7BBEF.8010409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matej Batic <matej.batic@ge.infn.it>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 09:40:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEzMS-0004QK-TB
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 09:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab1D0Hkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 03:40:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54038 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab1D0Hkb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 03:40:31 -0400
Received: by bwz15 with SMTP id 15so1155019bwz.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=stBJpy2iIhLezQNg3ZAvHOSEPdFCf8rQFZkagdJPmWA=;
        b=KhzzCWba1qjFHudWi4xyilAURl7Sgw9u3CmoFbYMLVkWUsZ0HlF84s9BSIm/+tK36d
         OGczP2VgRCpQVKjSDO2FtqMDReK6e/wwB6ry2tCeNrviNM6uJ8qcS0o6eDO5moJtG8FS
         CbwB+RLvHltuPsO6MrAi57GRqArjwpVP/bqvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Go76KVVTB4/WEZEykIQrp3UMVRJPQ3bLUr0zMJF6n5fIWpIk+dTRbSlj0lDJPTbHpK
         ODYl9OgY8hHvd8Pn+JwlKsbexL0bc2opAr9v6scAX+HhpZAw2SWUSYB9Qr+nX7dd65Wc
         QJeL+FcZ4+5M4WF7GVM8Y3Q6qSC0dblOQWLQo=
Received: by 10.204.20.143 with SMTP id f15mr1604538bkb.173.1303890030169;
 Wed, 27 Apr 2011 00:40:30 -0700 (PDT)
Received: by 10.204.17.14 with HTTP; Wed, 27 Apr 2011 00:40:00 -0700 (PDT)
In-Reply-To: <4DB7BBEF.8010409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172184>

On Wed, Apr 27, 2011 at 1:47 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> A more important point is the prefix-less case (i.e. we are in topdir):
> Should GIT_YOUNAMEIT be empty then? I would say yes (just like
> "rev-parse --show-prefix"), Duy said no. We need a third vote :)

I said no because you named it GIT_CWD. If it's GIT_PREFIX, then empty
prefix is normal, no objections.
-- 
Duy
