From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Tue, 06 Oct 2015 15:16:12 +0200
Organization: gmx
Message-ID: <632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:16:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjS6O-0003H5-Ro
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbbJFNQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:16:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:49543 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbbJFNQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:16:16 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MIiHs-1ZldxN3vse-002DWG; Tue, 06 Oct 2015 15:16:14
 +0200
In-Reply-To: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:6MP4G9qz3qXYTlhbMKHSTfPg0IIM/+Ika2yVV3OkGDVH1nkQORb
 9Zn0PrUWjgzzCo946FmIgysOnMOSGh6ASXdJ5qrNjNlRA2PhH1MSkPsTaabqEJtrWtLOHFd
 vFnk1jfDEAPcGHqU9P/ZJrW1JcHQCff+jAkt/7ibhY5hLbDx4JhbfPQ/xbDd8dRB3BHpq94
 MwFVmX0/Ll//Qgugb03SQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Mbyr52Ckps=:GglxaydtaMclQM4/M/S7PP
 msx8OnawtYasCFM/rTOFRihuqMC4xZs0Hlo838bgRbA9eeot5XZ7F1ngUBOJTE7hIBDabRd31
 KdEbYTCexUPCZZdrHFzUxOw/FPnBHmn+9vVtx1pY8G/uif0JGJ3UALySqfFO21EpbNYp7pns1
 50Pj3DZMhSJNSITJHcCp8OklUuhBIevP8s1jUu20bwtVz5kEXXa75wkeD/NZVq7QxRMtG5eFq
 GxyzVKIxKnSlNzslFwzOEF75vcxjjLglrhPVFAQ/iYWh5ystcGSdNuHmuIAlk7Hl06jJ9kC1N
 dKi1gfkr5YEjdjeoK7BDyqMxuI4KyKdefVFXhW0gPXAIKlCWvSR3fkWcJ7pjnSmrxewZolDLg
 I677cclp1I0lqgaqiJNLRW67AxWK8aCX/reJ1SstBHONrP2rsp5DgplgvMUwXOqc6IPANM5Pa
 rR1t8sTTgW5W6el/mFz9r3+CZueh2XnpVdsBuLqCVcgiDrrWpqtRnqj8b1XfKlIKMYqcgyytu
 A+yxwAszrndQ+LS42W2yexwLf1kKtB1hVIS+zD/m6kMJfNZAP8K3ZE/6KW3Kkm0VLMcDE5HF6
 qJykVeQQgBqnWmpPHbJRzB5b6vA1+dZHWPzRuxsE+CxcLPIJJvdAVt5UIppJlxBtDWNdfkoSt
 YVpRgUUjdQYj1ZdcNRiL1bjOcBi8yBM4KUhEDJcpEzWaAGCSIJjPEXzXCXA2zx6aX3WsWzI4X
 q4QIyxgbs09DBr6vMLbnYh7yOoXkfJsgIMeQmYl1yVntD9WfeCn7EXvdTs50OUatV+PU6lTT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279134>

Hi Tobias,

On 2015-10-06 14:15, Tobias Klauser wrote:
> prented_sha1_file() always returns 0 and its only callsite in
> builtin/blame.c doesn't use the return value, so change the return type
> to void.

While this commit message is technically correct, it would appear that there are some things left unsaid.

Is there a problem with the current code that is solved by not returning 0? If so, could you add it to the commit message? And in particular, change the oneline appropriately?

Ciao,
Johannes
