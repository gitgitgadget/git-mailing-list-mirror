From: Leonid Podolny <leonidp.lists@gmail.com>
Subject: last commit in a directory
Date: Tue, 25 Jan 2011 10:29:46 +0200
Message-ID: <4D3E89FA.4080901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 25 09:29:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PheHk-0007xK-9t
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 09:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab1AYI3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 03:29:51 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48255 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1AYI3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 03:29:50 -0500
Received: by ewy5 with SMTP id 5so2402846ewy.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 00:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=5k28v3DZDjctbQtvNDFw7LgP3ARMYNOX8bCdcRwKnq8=;
        b=GNrcLm24uQEyUZz7Uey6TqVYyIKfyoWoCLL4iME3FXtipdeLW3qJ+NXVPqw/twNFt6
         ++vfNqaZKLQM6ob8GbPgQ+bgo3hfLecCyvHgRcdzbH94NnlJGU2h1U0e3fuTT3aPoAST
         pHsRACTVBp97TYt5vwICrwJRihwvUMvaiGN0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=RZ8cmYddJLrACY/cok/5NM9wu8sDcC5xgrQCIWgAY1DyAiTQP0XEBg9GPF0zBz0fQ4
         R7chdvrdgXMmMlEKNn9veAs3ESsJbmVmpmg/t0bhPiC1v1jL8dA1PzeKthesb8A1b0uD
         Z1fFdk+g3xqTL0ynMDO4y+08AExQr+A/pZc1I=
Received: by 10.213.31.209 with SMTP id z17mr6432251ebc.12.1295944189530;
        Tue, 25 Jan 2011 00:29:49 -0800 (PST)
Received: from [10.20.20.19] (80.179.223.9.cable.012.net.il [80.179.223.9])
        by mx.google.com with ESMTPS id t12sm4554789eeh.9.2011.01.25.00.29.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 00:29:48 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165473>

Hi,
I have a really simple question: how do I find a last commit for the given directory inside the repository? I want to avoid rebuilding the specific part of the project if there were no changes in it since the last build, so I need to find the sha of the last time the directory was changed.
  Thanks, L.
