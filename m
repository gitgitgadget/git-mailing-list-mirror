From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: GSoC 2016: Microproject
Date: Fri, 19 Feb 2016 14:29:03 +0530
Message-ID: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 09:59:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWgu6-0000go-TE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 09:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427350AbcBSI7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 03:59:06 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36166 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1427342AbcBSI7E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 03:59:04 -0500
Received: by mail-qk0-f171.google.com with SMTP id s68so28326238qkh.3
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 00:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=K1SZfz2SqS/gC/tdwdnJeheAzB6ySetSEToT8XENP7k=;
        b=oDrlCDohH1A+3DeanQcDp1Qkv1/rru46pt5N+SpcvEJ281szSG7/djXzCVAP9b4bQA
         GaFt635cyI4+R/I2oKY7ZGuMGg3wELObobVbI7ASI2d3HjWG6o/QHqhTa9pNOFYOw5eu
         uhyd1EA3Rq2TETBPfsPdzqTQjL+LZ+9Oh/8JNfYEI2XKJJBnKuvRYJHejqQ256WdjpuO
         /STyN08Ru7OUX9ZMD93Smm48Ws8NmSRwu404upehZATR8ZdrsYpvHHhcteZHEjwItwOl
         Qy36ZK4gT3B0dQmhVyFxstTcry1nEdivdEiXP9wKkqokPoxBoltV1ZOkmzbomtL9tLvI
         uaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=K1SZfz2SqS/gC/tdwdnJeheAzB6ySetSEToT8XENP7k=;
        b=DFFU9+0KO+YgbcMfke8MfA+fcZPNHk6Yss2gTkf9HK633LmzzD5qtM8b0vjbzlypqP
         JV/Q39q3tJfuOoTHMR4TAyPuVHDKw58iEuLuyHvPZEvymoh1iy0Z8Rkn5Q/jWV18XHz/
         jzChShEpwMZJ3APmGqsGekDfIW3PFTX1sftpVmwofI/I6Ov2+4c6Ya9XsM9gvKcDgpjB
         TB3m8UbZN7F4WTrRXGWG2AswOyPWqjf7uxF5qWpvA3/YzC+LwS6uYj8fmwleFikvdnBy
         MH8S//k5+4sNX1JJB3d++JZzhcOgVksglxMRp/2toKbMAQXayDkcUzZ5ij80qjGUkQ5/
         iXLw==
X-Gm-Message-State: AG10YOTN00q/vV/jzJlHrCXmH7wQXnAB23qU5mS/zMgmSBA92tOuutwy4b0uCbNkgyk14GuWbraZNSuVz2YeQA==
X-Received: by 10.55.217.68 with SMTP id u65mr14438034qki.5.1455872343164;
 Fri, 19 Feb 2016 00:59:03 -0800 (PST)
Received: by 10.55.166.10 with HTTP; Fri, 19 Feb 2016 00:59:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286670>

Hello everyone,

I'm Mehul Jain. I'm looking for participating in GSoC 2016.

I've started work on a Microproject" Teach git pull --rebase the
--no-autostash" option. While looking at Git's source code I have made
following observation: In the pull.c file
1.  git_config_get_bool( , ) search in the configuration key for the
value of rebase.autostash, if found true then modify autostash's value
to a non-zero number and thus making a stash to encounter the problem
of dirty tree.
2. Here if in command line a flag "--no-autostash" is given then we
can easily set the value of autostash = 0 and thus killing the process
by die_on_unclean_work_tree(prefix).
Is my observation is right?

I'm new to open source projects and not much experienced at it. So
please correct/comment on any mistake that I made while trying to put
my point. I will also appreciate any comment/suggestion/criticism on
my observation.

Thanks
