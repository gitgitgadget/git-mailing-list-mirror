From: mat <matthieu.stigler@gmail.com>
Subject: Newbie question: how to move bunch of files
Date: Mon, 08 Nov 2010 21:48:04 +0100
Message-ID: <4CD86204.1000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 21:48:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYdo-00054q-T7
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab0KHUsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 15:48:13 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:41162 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab0KHUsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 15:48:11 -0500
Received: by wwc33 with SMTP id 33so431365wwc.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=qw3sWOQJbW/6kSnNcIzdfCo9p4D6cb6iTaFZvgwfeWc=;
        b=KL49qTfhF5ulYhM4WlSUehzt+w/5Dld14OgWZFRyRX4Nw//+ijGkq5FynTWGonbxu4
         3DhxpFHq+A9IDmqsNponRCkvLb8lh9coJIn/KeX+P8gxCQ7VrgtSkAcue9ldzCkaIPop
         NoRLPoXAwqEM65RBebDfkiDiTtJShGU5JVoKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=hB8NTTN++wKFMkVnQDXRM18zCrL4+ttG3gOq5QV+vms9m5xJvzQrkJZ2uIARizO2Zg
         iZzA6kVxhzIffBgy/JAEk3rdojsJE99MDXLzJLlklnfdLd/88UWI9YRTjD2s2F+G6qt5
         AXoikpevMcOt34IQ+N8GR2MhdFlttZiG/6SQM=
Received: by 10.227.138.71 with SMTP id z7mr5895138wbt.23.1289249289651;
        Mon, 08 Nov 2010 12:48:09 -0800 (PST)
Received: from [192.168.1.2] (93-40-144-119.ip39.fastwebnet.it [93.40.144.119])
        by mx.google.com with ESMTPS id f14sm277749wbe.14.2010.11.08.12.48.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 12:48:08 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Thunderbird/3.0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160987>

Dear list

I am very sorry to bother you with such a simple question, but I 
searched for a while on the net and did not come up with any satisfying 
answer :-(

I just want to move a bunch of files (from /R to /pkg/R ), but get the 
error:
$ git mv R/*.R pkg/R/
fatal: not under version control, source=R/nll_MSAR3.R, 
destination=pkg/R/nll_MSAR3.R

What do I do wrong? Would you kindly indicate me what I should do?

Thanks a lot and sorry again!

Matthieu

PS: I am using git 1.7.0.4 on Ubuntu 10.4
