From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9 gitk] gitk: chmod +x po2msg
Date: Mon, 25 Nov 2013 13:00:10 -0800
Message-ID: <20131125210010.GV4212@google.com>
References: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 22:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3GX-00035h-RD
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 22:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab3KYVAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 16:00:16 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:52014 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3KYVAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 16:00:13 -0500
Received: by mail-yh0-f41.google.com with SMTP id f11so3333431yha.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 13:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7f3ub+IzvTTtu8RobPGzWx5fwgU5uqnGKifLQnWv8YA=;
        b=WUdYljfdH8MLAb347EbCy9rSyARZyVGMOtf6sRWbTqjgMPgmMbMQP4qY1b339E40B1
         hVSRGYlA6scl+bDNhiHC74zDdH/PuPEcF/GHb1BqFXi2oG35qso7Vgc6LHN8WhhK0xnU
         guqKmyIlYav6K/D0HGCdGXGRw/7MrTCjPw/dL16l7W1BbjslV79lL5vpRAJOlWcbEpnP
         2u/24FVhuJNVbpz+gaTXI1XNNOdxLHVJizTxjGIF7tjeNML5WHAYukafpr9/BwiMvCh+
         h+ASiukbOfHXcKYMhpEaAzYbCV2E6dZ02jdyY335q2uhyuwI3VwZuScWAUca+IrIhALf
         y2Iw==
X-Received: by 10.236.168.196 with SMTP id k44mr9626yhl.102.1385413212975;
        Mon, 25 Nov 2013 13:00:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e39sm78027888yhq.15.2013.11.25.13.00.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 13:00:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131125205119.GQ4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238352>

The Makefile only runs it using tclsh, but because the fallback po2msg
script has the usual tcl preamble starting with #!/bin/sh it can also
be run directly.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 po/po2msg.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 po/po2msg.sh

diff --git a/po/po2msg.sh b/po/po2msg.sh
old mode 100644
new mode 100755
-- 
1.8.4.1
