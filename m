From: Daniel Holtmann-Rice <flyingtabmow@gmail.com>
Subject: git submodule update --quiet is very loud
Date: Tue, 26 Jul 2011 07:26:47 -0400
Message-ID: <3A1F23B2-AC3F-416C-BFBD-97096724C400@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 13:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlfnL-0006Ey-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 13:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab1GZL0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 07:26:55 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54926 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab1GZL0t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 07:26:49 -0400
Received: by qyk29 with SMTP id 29so1373810qyk.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=pWY83Qk6RA3xb8K7R7VbO7u6DNcwo+lsIf8YGlntd6E=;
        b=x6mePsrVj7jic11TIO3iWmeVE1dspHEE2u030suUZsIyXV5BQpVtRXjjPrjPNOzm5m
         fzqaj6eEIdixjnjIINW4Wpmfx0bTmJoq3iBNd2IQ67DRzTpqS9mzSGPJXZsljICkRHZ1
         3ZRN1+Na7Y7V/vqBhSHCImvofs07Uzr5SXMO8=
Received: by 10.224.183.3 with SMTP id ce3mr2552551qab.100.1311679608554;
        Tue, 26 Jul 2011 04:26:48 -0700 (PDT)
Received: from [192.168.0.200] (c-71-235-85-18.hsd1.ct.comcast.net [71.235.85.18])
        by mx.google.com with ESMTPS id k5sm220367qct.21.2011.07.26.04.26.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 04:26:48 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177855>

Hi,

I can't find a place to submit bug reports, so I'll post this here... the --quiet/-q flag seems to have no effect for 'git submodule update'.  For example (http://pastebin.com/0KWT4EeA):

#!/bin/bash

git clone -q git://github.com/dhr/evp-tools.git
cd evp-tools
git submodule -q init
git submodule -q update

This doesn't run quietly (the first three commands do, the last does not).  I've tried this through Git 1.7.6.

Cheers,
Dan