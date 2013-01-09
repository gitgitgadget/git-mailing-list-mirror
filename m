From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH 03/19] reset.c: pass pathspec around instead of (prefix,
 argv) pair
Date: Wed, 9 Jan 2013 03:42:34 -0800
Message-ID: <20130109114234.GA3528@ftbfs.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-4-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 12:43:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsu4H-0001nX-SH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 12:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635Ab3AILnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 06:43:16 -0500
Received: from zoom.lafn.org ([108.92.93.123]:31198 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756170Ab3AILnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 06:43:14 -0500
Received: from yeeloong.ftbfs.org ([206.29.182.178])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id r09Bh2ll014451;
	Wed, 9 Jan 2013 03:43:05 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by yeeloong.ftbfs.org with local (Exim 4.80)
	(envelope-from <kraai@ftbfs.org>)
	id 1Tsu3I-0002Wu-1Y; Wed, 09 Jan 2013 03:42:36 -0800
Mail-Followup-To: Martin von Zweigbergk <martinvonz@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1357719376-16406-4-git-send-email-martinvonz@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213055>

On Wed, Jan 09, 2013 at 12:16:00AM -0800, Martin von Zweigbergk wrote:
> We use the path arguments in two places in reset.c: in
> interactive_reset() and read_from_tree(). Both of these call
> get_pathspec(), so we pass the (prefix, arv) pair to both
                                          ^^^
argv is misspelled.

-- 
Matt
