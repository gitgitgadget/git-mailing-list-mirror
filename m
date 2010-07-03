From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/4] git-cvsserver: simplify control flow in pserver 
	authentication
Date: Sat, 3 Jul 2010 22:16:27 +0000
Message-ID: <AANLkTin69L7BoexBFdTL7L5SB-n1QHe9CJD0KPk3aW7N@mail.gmail.com>
References: <1707116361121042582@unknownmsgid>
	<AANLkTiktRjlLWrvLG4Jkd_Yu7FLAgJ6_mhYITy3bI3Cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 00:17:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVB1C-0001P4-8e
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 00:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab0GCWQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 18:16:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59038 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369Ab0GCWQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 18:16:28 -0400
Received: by fxm14 with SMTP id 14so3006577fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=EGjvJedVMtA2P6++a+0KbhJ8lS6B4plSbUS8bSA9n0s=;
        b=Ni38zpX4S9A0Dst2M+4WB4BWt9v1aCV1lpnaZtFigPjZTNtTEb6vkgU9BLnEIsgKv2
         rHUFLcwvp+SM1eM9w9N7v6a/XEtPLwNgvgDDvITlNZ80ccsW3+ihaCixS1cWvlThuTBT
         CUCmvUrWbeHQ2hDt1jdPro0uuatWO0JDI3Ix4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rjxKJ7LsdxAnmcro/GNSA77PxQrrXBHvgC6s1ljgOpyoY3sSLhZsAkJRM3bMcQGO97
         GbrOOQn4lT8hSHEEnaY99He2O6Wr3lPoAqrzMka589SZ3vYWCwdPfVVMhfzlg/Aone24
         KmhzQ7MqIi+XH1QfOgKkrsbhg/Nx8M87HaHGQ=
Received: by 10.223.103.138 with SMTP id k10mr615759fao.98.1278195387566; Sat, 
	03 Jul 2010 15:16:27 -0700 (PDT)
Received: by 10.223.103.84 with HTTP; Sat, 3 Jul 2010 15:16:27 -0700 (PDT)
In-Reply-To: <AANLkTiktRjlLWrvLG4Jkd_Yu7FLAgJ6_mhYITy3bI3Cb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150209>

Looks good. That code is somewhat contrived as-is.
