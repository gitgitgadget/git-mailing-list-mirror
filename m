From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: git-cherry-pick and author field in version 1.7.6.4
Date: Wed, 05 Oct 2011 16:51:58 +0200
Organization: 6WIND
Message-ID: <4E8C6F0E.7000508@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 16:52:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBSpO-00067p-DH
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 16:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934620Ab1JEOwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 10:52:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51246 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab1JEOwC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 10:52:02 -0400
Received: by wyg34 with SMTP id 34so1782842wyg.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 07:52:01 -0700 (PDT)
Received: by 10.227.5.213 with SMTP id 21mr3089163wbw.40.1317826321396;
        Wed, 05 Oct 2011 07:52:01 -0700 (PDT)
Received: from [192.168.1.4] (schneckos.n1c0.com. [88.182.61.195])
        by mx.google.com with ESMTPS id s30sm3306407wbm.12.2011.10.05.07.51.59
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 07:52:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182852>

Hi all,

in the last stable version (1.7.6.4), when I perform a git-cherry-pick, the 
initial author of the patch is erased whith my name (it was not the case in 
version 1.7.3.4 and prior). Is this behavior intended ? Is there an option to 
keep the initial author of the patch?


Regards,
Nicolas
