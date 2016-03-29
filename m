From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: [RFC/PATCH] t/perf:
Date: Tue, 29 Mar 2016 10:44:29 +0000 (UTC)
Message-ID: <loom.20160329T124227-493@post.gmane.org>
References: <xmqqfuvaxsr1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 14:00:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aksJu-0006BL-Sw
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 14:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbcC2MAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 08:00:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:41627 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbcC2MAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 08:00:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aksJZ-00062J-Hp
	for git@vger.kernel.org; Tue, 29 Mar 2016 14:00:07 +0200
Received: from 193.5.216.100 ([193.5.216.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 14:00:05 +0200
Received: from dev+git by 193.5.216.100 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 14:00:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.5.216.100 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290122>

Junio C Hamano <gitster <at> pobox.com> writes:

> +	cd perf && $(MAKE) clean

I think the clean way to do this is

	$(make) -C perf clean

Regards,
Beat
