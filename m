From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 1/3] bisect: relax requirement for a working tree.
Date: Mon, 8 Aug 2011 00:40:58 +1000
Message-ID: <CAH3AnrowF7z9wdKqQthxkcAPQCCJkgJSkHDAr6CCjo_aoWzfqA@mail.gmail.com>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
	<1312714240-23647-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 16:41:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq4XH-0006sV-RC
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 16:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab1HGOk7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 10:40:59 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57826 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab1HGOk6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2011 10:40:58 -0400
Received: by vxi9 with SMTP id 9so1939568vxi.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=ZMrp/RNHXb996HFswszdmTUN5RWpB/YoMLTJ/fGYAWA=;
        b=ZtXCkEpaa8TP+kzSZXN/9AhVAhB0RjfmUbDR+mlUV6lF37lIE/ALcn9oiN+h7sxR1z
         9oJ1gScNoC3XPd2R6drW+eNvlOxE56M8VL/ZprdPCPr6TAPCMjvXdL/4IryWxuayTi6t
         btafg6nokietIOIp16iF9O71svc0Oqh2P6zas=
Received: by 10.52.27.37 with SMTP id q5mr4708492vdg.64.1312728058268; Sun, 07
 Aug 2011 07:40:58 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Sun, 7 Aug 2011 07:40:58 -0700 (PDT)
In-Reply-To: <1312714240-23647-2-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178921>

On Sun, Aug 7, 2011 at 8:50 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> + =C2=A0 =C2=A0 =C2=A0 if test "z$(git rev-parse --is-bare-repository=
)" !=3D "zfalse"

Next iteration will remove double quotes from around zfalse.

jon.
