From: kp <kernelphr34k@gmail.com>
Subject: Git bin permissions
Date: Mon, 11 Jan 2010 10:54:54 -0800
Message-ID: <1b727e9e1001111054h42ed88dco2fd18e0e322ee4b3@mail.gmail.com>
References: <1b727e9e1001111052t5cb6f604tb7936bd627c5f9f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 19:55:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUPPs-0007F7-8z
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 19:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0AKSy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 13:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186Ab0AKSy6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 13:54:58 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:37321 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab0AKSy5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 13:54:57 -0500
Received: by ewy1 with SMTP id 1so3543513ewy.28
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=9UVUE3mzEn5WacGw/IPhyEgoanPrDJ0b+XgItBqeSvk=;
        b=B7CWKDddw8fwTgAsQr/mlpKy18gUYtTOrhe5hllCp/JLvq3yTjddE2OENnM2rrfbny
         hzCDOU07T4K1Nj6gk3U0f4YLuL30FtwxLZuc7o2fPPM1hT6r+GMj1CQTXQovPMekq+9g
         jDd/GO3xBlLDUoJ/n3qndT6PROIunpixoadyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=trFNS90Mii/3Mb2mgqoE1R2habOt8OZqsklD9PNja8KuyaVHPAm/UAug+y8IhjncRU
         KP+fsEnh/Kzzs/eHnkihnwEPikATNAp/9X53ETHhEKeTf/eho+z2zV7hrJFuS5SPOyI8
         0Z+ngT3NO7mc4x5uvsIB4wZRtw7wPyJ2ztPMo=
Received: by 10.216.90.198 with SMTP id e48mr5432921wef.188.1263236094994; 
	Mon, 11 Jan 2010 10:54:54 -0800 (PST)
In-Reply-To: <1b727e9e1001111052t5cb6f604tb7936bd627c5f9f7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136653>

Hello All,

It looks like my IT came in and destroyed permissions on my
git/gitosis install. Now I'm getting permission denied error while
trying to run a git push.
git/bin/gitosis-run-hook: Permission denied

I need to know the correct permissions for=A0gitosis-init,
gitosis-run-hook, gitosis-serve. Can someone please give me an ls -la
output?

Thanks,
Alex
