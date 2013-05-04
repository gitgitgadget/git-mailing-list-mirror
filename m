From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH] revision.c: Fix a sparse warning
Date: Sat, 04 May 2013 21:13:57 +0300
Message-ID: <51854FE5.4050907@bracey.fi>
References: <518544A4.4080202@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat May 04 20:14:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYgyG-0001pd-PR
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 20:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758427Ab3EDSOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 14:14:04 -0400
Received: from mo2.mail-out.ovh.net ([178.32.228.2]:48510 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756831Ab3EDSOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 14:14:03 -0400
Received: from mail240.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id ACE9BDC0E55
	for <git@vger.kernel.org>; Sat,  4 May 2013 20:14:00 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 4 May 2013 20:14:00 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 4 May 2013 20:13:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <518544A4.4080202@ramsay1.demon.co.uk>
X-Ovh-Tracer-Id: 5757289175496757371
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223369>

On 04/05/2013 20:25, Ramsay Jones wrote:
> Sparse issues an "'sole_interesting' not declared. Should it be static?"
> warning. In order to suppress the warning, since this symbol does not
> need more than file visibility, we simply add the static modifier to
> its declaration.
>
>
Thanks! I'll include that fix.

Kevin
