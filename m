From: Ben Boeckel <mathstuf@gmail.com>
Subject: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Mon, 26 Sep 2011 14:47:39 -0400
Message-ID: <20110926184739.GA11745@erythro.kitwarein.com>
Reply-To: mathstuf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 20:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8GDr-0007rm-Ha
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 20:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab1IZSsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 14:48:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40140 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab1IZSsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 14:48:04 -0400
Received: by iaqq3 with SMTP id q3so4794865iaq.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:reply-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=VxjjmxKRhvVeydHeBBQrMXWgcscl1QkwYXPuqtjL61Y=;
        b=WlMUrwtpx+qg7ksbM+l+55LUsEBKIxEidM1XdNkBAei4STsRalJ+G+CdWB1Ec26tOJ
         J8zuBNSpyTc5xa2AjEQRlTPqasbJHt5TQsM39FZmJz0zEeJLkXvAVV3GQaWsTbvf/Uhn
         Byy0gdQPPVQrSm1lA1NrGKqU1u365P0+9m8JM=
Received: by 10.231.21.26 with SMTP id h26mr8853956ibb.40.1317062883763;
        Mon, 26 Sep 2011 11:48:03 -0700 (PDT)
Received: from erythro (66-194-253-20.static.twtelecom.net. [66.194.253.20])
        by mx.google.com with ESMTPS id dv19sm27256564ibb.3.2011.09.26.11.48.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 11:48:02 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182148>

Hi,

When the --prune and --tags options are given to git fetch together, all
non-tag refs are pruned because only tags are looked at and when pruning
it appears as if the branches have disappeared and are therefore deleted
locally. Maybe this is an unintentional wanted behavior, but it should
at least be documented that the combination causes this to happen.

    git-1.7.6.2-1.fc15.x86_64

Appears to still be there in master (85e9c7e) from looking at the logs.

--Ben
