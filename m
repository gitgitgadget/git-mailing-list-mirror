From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH RFC 2/6] send-email: --smtp-server-port should take an integer
Date: Sat, 11 Apr 2009 15:01:05 -0600
Organization: icecavern.net
Message-ID: <200904111501.05734.wjl@icecavern.net>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> <1239139522-24118-2-git-send-email-mfwitten@gmail.com> <7vvdpbf11m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 23:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LskOn-00081p-Sg
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 23:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbZDKVBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 17:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbZDKVBQ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 17:01:16 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:38682 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753255AbZDKVBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 17:01:15 -0400
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id DEFF336580;
	Sat, 11 Apr 2009 15:01:10 -0600 (MDT)
User-Agent: KMail/1.11.0 (Linux/2.6.27-14-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <7vvdpbf11m.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116349>

On Saturday 11 April 2009 13:22:29 Junio C Hamano wrote:
> Hmm, I have to wonder if there somebody who is using symbolic names for
> ports, e.g. --smtp-server-port=ssmtp which this patch may start
> rejecting.

An common example is --smtp-server-port=submission (for 587).
