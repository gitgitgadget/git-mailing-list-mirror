From: Phil Susi <phillsusi@gmail.com>
Subject: What happened to having to recover from upstream rebase?
Date: Mon, 11 May 2015 15:50:15 -0400
Message-ID: <555107F7.1040906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 11 21:50:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrtiv-0007QC-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 21:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbbEKTum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 15:50:42 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35925 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbEKTuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 15:50:40 -0400
Received: by qku63 with SMTP id 63so94567487qku.3
        for <git@vger.kernel.org>; Mon, 11 May 2015 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=R+fHZ9+wMLUhX2kma0killZqBgjdvUbmXzqJY7U7gps=;
        b=pD3t5UGSxAnGmVsH6lJb85C/ESM8Ojbzz9UwqHGrikVcWqKxaZuSqgZDk/1hgFtURv
         +L6tAuunZFZoSHjqH0AEWyypoCsna6Eegu+aiiUaUINquq24VRkuiXDyPPLsiXY65XIb
         hecfM+VGP05/YKWH94oShaFkVSzfEV2MUfZ7qCALlFtd71jaOWKzOgpVjt9XJO9Qj3JS
         kFL/rIzPdcscFe2nRLZWk4P7aUO4yIITiwF1xXVhXeTALaCSfsyGa025eDoZuH9Imx/O
         XoQQKXoaEOmpjokjzM2mtG+8krmD3VJQh/Jh9FrIDx1y8afcDMoXSegIE9Es3ST+ALZD
         qu2g==
X-Received: by 10.140.83.116 with SMTP id i107mr15352811qgd.97.1431373839702;
        Mon, 11 May 2015 12:50:39 -0700 (PDT)
Received: from [10.1.1.212] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id t33sm11462404qge.19.2015.05.11.12.50.38
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 12:50:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268820>

So it used to be that when upstream rebased, you'd get an error when you 
tried to pull again and have to fix things up with some git reset or 
rebase hackery.  Trying to demo this today I found that the pull 
*worked*, using an automatic recursive merge.

Am I crazy in thinking this used to error, and if not, when did it change?
