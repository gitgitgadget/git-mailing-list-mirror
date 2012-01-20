From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: crash with git and latest mainline: EIP: 0060:[<c106c2d2>] EFLAGS:
 00210006 CPU: 0
Date: Fri, 20 Jan 2012 07:00:00 -0800
Message-ID: <4F198170.9070605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 20 16:00:20 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RoFwv-0003bn-SK
	for glk-linux-kernel-3@lo.gmane.org; Fri, 20 Jan 2012 16:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab2ATPAJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 20 Jan 2012 10:00:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60363 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab2ATPAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2012 10:00:04 -0500
Received: by iaeh11 with SMTP id h11so424571iae.19
        for <multiple recipients>; Fri, 20 Jan 2012 07:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=INdgkoVu5i8+F7jjk9HUa8pdcseQgVwQP0+z9IYAJhY=;
        b=HTvrwV/2UQhp2RyYuz2VNdLNRnbjAZtKXLepPtxBXh0SbaDnq3ZgEZraSvbdq3CtQN
         fTqCcspkaNBuYOP/dsrk6PYJk54RueiboXN6+d7Kxkw+rr6LHPRfwce6H7yn4t5Kq1Dq
         oLARds2ATgH8GKzXUbdA4WDZNN3eF/hHoLMyU=
Received: by 10.50.6.227 with SMTP id e3mr2910207iga.20.1327071604020;
        Fri, 20 Jan 2012 07:00:04 -0800 (PST)
Received: from [192.168.5.144] ([64.134.224.181])
        by mx.google.com with ESMTPS id f8sm10759211ibl.6.2012.01.20.07.00.02
        (version=SSLv3 cipher=OTHER);
        Fri, 20 Jan 2012 07:00:03 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188881>

not sure if this means anything or not, but I was doing a apt-get 
upgrade and a git pull at the same time and had a total system freeze.
I was only able to capture an image of the crash. here are the images of it:

http://www.flickr.com/photos/44066293@N08/6730938347/in/photostream
http://www.flickr.com/photos/44066293@N08/6730937479/in/photostream
http://www.flickr.com/photos/44066293@N08/6730936509/in/photostream

will keep an eye out or for this, tried to reproduce but with no luck 
doing so.

Justin P. Mattock
