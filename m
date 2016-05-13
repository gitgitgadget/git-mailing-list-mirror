From: Chris B <chris.blaszczynski@gmail.com>
Subject: git push --quiet option does not seem to work
Date: Fri, 13 May 2016 17:21:30 -0400
Message-ID: <CADKp0pwHKvfSDG_-4p5tUn0_QiUGKzmRj5RwphfA8sZ_7CVHqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 23:22:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1KXK-0003rb-0B
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 23:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbcEMVWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 17:22:12 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35789 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347AbcEMVWL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 17:22:11 -0400
Received: by mail-ig0-f172.google.com with SMTP id bi2so20134310igb.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=4cQ6WlvImoub6oce+w4MSxP8dacJiR29dn7y7n2yLq0=;
        b=0GHy3GFDtAQBOhIGvFIfaMsxv00DP0dnuETVWFo3RajU9h+zfLDnJSmXC2Pn2IG9M7
         DlXqQHxzcFgVeobvqO1zczCwHCCbHBk3A7atKBrljFbicqdtNdcU3fO/IDI7EofQMe9D
         phi7v8yDtgFyuOT0FFXiYUd0HNM06eZdo5JoC6weDT9161abC1Stcgp9DcpEjUAdySb6
         qMP+oO8kqYN857aPem86Vy0Zsj4WoppCHDtYut0RV3hCid2UHBsm74rFKXl4APJoO+IA
         lC+VnfwjeD5Q4h6aN8o/96keofZZvxVRIuxlo16tGGXFFgbNfOQpSVqis/AaLpbdB9bn
         VdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4cQ6WlvImoub6oce+w4MSxP8dacJiR29dn7y7n2yLq0=;
        b=ZcMXtUMT9a74V0eLwrHKV+ljDQVhSUfnKaBKIyDoxNfIzsdBe7Aa5FC+H5Sz3Q5ojT
         B7pgT53AYey3wNPy1R0/luD/4qA0jq7Mf5RGQFI3C8XcYaYEpScJT+V3IVgUSR2K6eDN
         6vnGNgEvxwyE7JwWBh96vj5Y9cNm18hTiss6Cm4M0bNzVax4bCRlyG2K40qyvzilmZNK
         +JXIyrIp92Z6jq5tYiCbEX6y0c3rgJnDeBuGqcae87jZIWq0LVxb+gfbCtfGvnimrbKk
         oZ0R5oidskgkqbkeYOrszhdcXGB1UQ4WO7gJaZIgsRLMTY11avjylM6DcuLIzI+oymgz
         EpZQ==
X-Gm-Message-State: AOPr4FUjBRFEIpsKGU0eJLVFmH53VCpW/F07S/Ib2y5yg/nHn0w3iky2YjpnQUDbPFYDQyANBz8fr8g6zwTy+g==
X-Received: by 10.50.58.166 with SMTP id s6mr3713455igq.13.1463174530201; Fri,
 13 May 2016 14:22:10 -0700 (PDT)
Received: by 10.107.20.88 with HTTP; Fri, 13 May 2016 14:21:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294586>

Hi I am using 2.8.2.windows.1 and writing Powershell scripts doing
some Git stuff.

I have to use the --quiet option for git because it constantly outputs
progress to stderr.

However, it seems that --quiet does not actually work in git push. The
output still goes to stderr.
When there are changes committed to push it always outputs something
to stderr. If there is nothing to push, then it actually is silent.
