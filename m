From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Can Gitweb show a git-shortog(1) between two revisions?
Date: Fri, 18 Feb 2011 15:06:13 +0100
Message-ID: <AANLkTinO4fq02OJ2-EDVvG8fTGQp2B0X=bvu-fvjS0Tt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 18 15:06:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqQyf-00016H-19
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 15:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab1BROG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 09:06:28 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35523 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1BROG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 09:06:27 -0500
Received: by fxm20 with SMTP id 20so3811700fxm.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 06:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=atnPTSi9C91QUiSdkKrBji64P9TFAFwRUn28djJfkQE=;
        b=ubslEmy0uTvs6cwgPimKR2/l6p8GzzvPCcwDQUFujpp9aPdho3NDmnI9WxW3+0GaUd
         GcZ9ejYHOcx9nBAU7tj34LvXQ2rf/oKJxDyTwyM4weqISD7uwdwm70Uv48IWXHLKjftF
         F504U6Wm62j07bJAuUesOxaP9MVLpDqxlRFOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=sfw9M7CMZwmQiHTWpCcXVm2Zyem3d4guJg7i2mFW9kNU06vW23Japjs6I2I91bize4
         zZTg0NdPeEeAvpXO6Ojg/PdK66yOPhAIVoamXtsZh8LIN6Kq6uugqCE4aQuf921zpv/9
         DtOE1Ju/v+LMBMOnOMqg0VBASB6xOJZsAI1aw=
Received: by 10.223.96.12 with SMTP id f12mr1030536fan.79.1298037973906; Fri,
 18 Feb 2011 06:06:13 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 18 Feb 2011 06:06:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167210>

I want to show a git-shortlog(1) in Gitweb (to link to it externally).
Can Gitweb do this? I haven't found out how, if so.

I.e. just:

    git shortlog x..y
