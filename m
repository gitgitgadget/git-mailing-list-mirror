From: Mark Challoner <mark.a.r.challoner@gmail.com>
Subject: Git Plugin: Semantic Versioning
Date: Fri, 24 Jul 2015 15:44:45 +0100
Message-ID: <55B24F5D.4090309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 16:44:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIeDV-0007GW-AV
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 16:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbbGXOot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 10:44:49 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34616 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbbGXOos (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 10:44:48 -0400
Received: by wibud3 with SMTP id ud3so68318317wib.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 07:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=eO5j/4dgKWX9RSltnqATLucz6ot8JhQ655va7L6Bnlg=;
        b=b7EvtixW1HNBNKWlPC5W8Ep3M/vry2GPTmFBzbJtW+LcL3ofcJEzrOanO7EuBXAMot
         tsSmKOgASPIgKOj+WviBO1esJD6gAJIGQv3vNo3r39BkUqZs44F6GPH12R+Kl3IiS9/r
         EDgQe6YUlUw+55L/Zb+T+uZAL0Z7JkUN6ry6rqdkxIIZN9ICbcWVcf/TxdQZrw18goqQ
         +7OiDlYleh4LBRljinEA8/nEa68p6PUsAfX6/lzmxOmuByoOH+3SierI9OwqQinE1Etx
         sn+QG1nyzPUPh7zJV+XbQ9mOhTPPzO9L2PeH5JiwKk2EzIDiSmuLTIA3SV18MIY/S4QS
         jMMw==
X-Gm-Message-State: ALoCoQkv08n5uc6S4ZE07HFpm4noWldfz0xjwm5uhJzgaRUh0WpvU4N01itw9TfpSeUnKfwVGcWA
X-Received: by 10.194.121.34 with SMTP id lh2mr27674924wjb.101.1437749086526;
        Fri, 24 Jul 2015 07:44:46 -0700 (PDT)
Received: from [10.1.1.99] ([217.205.148.98])
        by smtp.googlemail.com with ESMTPSA id fb3sm3848330wib.21.2015.07.24.07.44.45
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2015 07:44:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274570>

Hi all,

First off apologies for the spam, but I thought it may be useful for a 
few git users out there.

I have put together a git plugin for easy Semantic Versioning 
(http://semver.org). It comes with its own plugin architecture to allow 
you to check project files have been updated with correct version number 
before applying a version tag (e.g. Android manifest, Apps Engine 
app.yaml etc.)

The project, install instructions etc. can be found here:

https://github.com/markchalloner/git-semver#readme

I have tested on Windows (MinGW) and Linux (Ubuntu 12.04) and in theory 
should work on OSX (maybe some kind user could test for me?)

I hope its of some use.

Regards
Mark
