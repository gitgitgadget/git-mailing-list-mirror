From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] submodule: implement `module_name` as a builtin helper
Date: Tue, 4 Aug 2015 17:05:37 -0700
Message-ID: <CAGZ79kZzqT7pJg_hr0z6nipTQYSNeCZf9sRZjO5pyH1JWe2LZw@mail.gmail.com>
References: <1438733070-15805-1-git-send-email-sbeller@google.com>
	<1438733070-15805-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 02:05:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMmDG-0008U3-I7
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 02:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbbHEAFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 20:05:38 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35263 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbHEAFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 20:05:37 -0400
Received: by ykcq64 with SMTP id q64so17472927ykc.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 17:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Rzz0RU5Lp+kqGf7B3v+y56be97pcURGmc6sXqKmHqyE=;
        b=MiW+c17Bu0ELiL6DGNtQsnzMcrQPPzxG5wHY4d+0+OScbj3/+DQRkoAIr3KchhR5J0
         PXRqbSiEUjnIS6lySIXUdlAlz8UXuvZTGX0XTiRw2pD+l5pu2MVylEhEAPLwi1J+/xIQ
         npxXY6MavGwauGBGAC3mjBnEEaZaI6/hvAumLCrdUob8dY0s47U4ipZiV69Les6nU1Ed
         L0xfDLtgKD5HGDUqdop2Skh0Mm2Lj9dy6JUgDR3zagL//oR/pGlXfDkig7NxPW/g3aB9
         E1l0zbGATMXgCZbL/lOYdqETcQdHNilup2WuVrkrZze4pJRcbtO0DDxGcdsmgxRBcuRA
         VyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Rzz0RU5Lp+kqGf7B3v+y56be97pcURGmc6sXqKmHqyE=;
        b=lvU9SHPAaKHqvDhtkNOz5tpImvODpZJm5KlyBqqjtYS/2nvoyYCSA5rYt7/4XQot9c
         xvFRNvr/JOGsF9gqH7Zbe+dB5Oq9h6fCnhh2Z9bEYoU0HU6Mit/bXJCA977hxLF/fIg4
         Ny5P5K8dEXa2vHxtB0q7PuNtpfAeCOVxipXkoGBpWNB7oiIZYK/KdpAmiQVghZG23bHG
         Ip07m9Eum3qicuApZSrdX+eSmh2VJ/Szzv2A2dYAbYJTmX3Ct1YtOGNS6+19rkq/5MrA
         VypAueAADTZQsZZzVthuTsbeyOt8RBqJhkF16kiszo318ajPVzsEG7SKlI+yrCHK39pm
         48OQ==
X-Gm-Message-State: ALoCoQmDMXZAt+fuN4+qKbu9/m3d5d9ltMd9+v4VreKP0S2tF2TqKeOxVISrtIVYGLjI/P7ZCk/z
X-Received: by 10.13.254.70 with SMTP id o67mr6948818ywf.88.1438733137133;
 Tue, 04 Aug 2015 17:05:37 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Tue, 4 Aug 2015 17:05:37 -0700 (PDT)
In-Reply-To: <1438733070-15805-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275348>

The series consists of 2 patches only actually. The next patches have
not been sent as they are heavy WIP.
