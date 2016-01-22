From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 0/2] Let merge-file write out conflict markers with
 correct EOLs
Date: Fri, 22 Jan 2016 18:52:57 +0100
Message-ID: <56A26C79.1000506@drbeat.li>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:54:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMfuw-0004BW-QZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbcAVRyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:54:35 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:57877 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415AbcAVRye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:54:34 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id C94B0C3445;
	Fri, 22 Jan 2016 18:54:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 9D21FC3442;
	Fri, 22 Jan 2016 18:54:30 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <cover.1453482052.git.johannes.schindelin@gmx.de>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284572>

On 22.01.16 18:01, Johannes Schindelin wrote:
> The original patch was sent by Beat Bolli in
> http://thread.gmane.org/gmane.comp.version-control.git/281600
> 
> My suggestion to extend it to respect gitattributes led to
> changes that broke the original patch.
> 
> Since there have been a couple of "What's cooking" mails
> containing unheard calls for updates on this patch, I took it
> on myself to fix things.

Thanks a lot! I was really stuck on the heuristics of eol_for_path(), so
I'm very glad you took over.

Regards,
Beat
