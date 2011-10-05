From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 05 Oct 2011 16:52:31 +0200
Organization: 6WIND
Message-ID: <4E8C6F2F.1070306@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 16:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBSpt-0006Li-5b
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 16:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934422Ab1JEOwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 10:52:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64893 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820Ab1JEOwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 10:52:36 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so2678880wwf.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 07:52:35 -0700 (PDT)
Received: by 10.227.201.67 with SMTP id ez3mr1329430wbb.75.1317826353924;
        Wed, 05 Oct 2011 07:52:33 -0700 (PDT)
Received: from [192.168.1.4] (schneckos.n1c0.com. [88.182.61.195])
        by mx.google.com with ESMTPS id z9sm3280637wbn.19.2011.10.05.07.52.32
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 07:52:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182853>

Hi,

still with version 1.7.6.4, when I do a cherry-pick, that succeeded, I cannot do 
a commit --amend after:

# git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
[dev 1a04a23] drivers/net/usb/asix.c: Fix unaligned accesses
  1 files changed, 33 insertions(+), 1 deletions(-)
# echo $?
0
# git commit --amend
fatal: You are in the middle of a cherry-pick -- cannot amend.
#

The same operations (with the same patch), with version 1.7.3.4 is ok.


Regards,
Nicolas
