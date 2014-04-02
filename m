From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: emacs buffer names
Date: Wed, 02 Apr 2014 18:22:45 -0500
Message-ID: <8538hvwc3e.fsf_-_@stephe-leake.org>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
	<CACsJy8A9b2eccm_BJMjW5RwWLux90xs7HfUQEn0_jrzhHWeajQ@mail.gmail.com>
	<xmqq38hw272q.fsf@gitster.dls.corp.google.com>
	<CACsJy8BVXk248VDBi-pAMDY4QpDSbFuAf5qxRxCCq71yGNzpqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 12:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVed3-000348-60
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbaDBXWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 19:22:53 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:64447 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161080AbaDBXWw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 19:22:52 -0400
Received: from [75.87.81.6] ([75.87.81.6:54378] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 36/53-16704-BCB9C335; Wed, 02 Apr 2014 23:22:51 +0000
In-Reply-To: <CACsJy8BVXk248VDBi-pAMDY4QpDSbFuAf5qxRxCCq71yGNzpqA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 2 Apr 2014 06:40:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245676>

Duy Nguyen <pclouds@gmail.com> writes:

> The --daemon part is probably not worth mentioning because I always
> have one emacs window open. The problem is switch-buffer based on file
> name can be confusing ("git.c" and "git.c<2>", which belongs to which
> checkout?). I ended up modifying files in the wrong checkout all the
> time.

(setq uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))

This puts enough of the directory name in the buffer name to make the
buffer names unique; very helpful!

-- 
-- Stephe
