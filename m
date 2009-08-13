From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Thu, 13 Aug 2009 23:06:36 +0200
Message-ID: <200908132306.37947.trast@student.ethz.ch>
References: <200908121726.52121.luke-jr@utopios.org> <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org> <7vy6pna4lu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luke Dashjr <luke-jr+git@utopios.org>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 23:07:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbhWC-0000Zh-1C
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbZHMVHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756294AbZHMVHQ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:07:16 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:59241 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755143AbZHMVHP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:07:15 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 23:07:15 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 23:06:53 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7vy6pna4lu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125875>

Junio C Hamano wrote:
> 
> Chould you refresh my memory a bit?
> 
> In what circumstance is "rm --ignore-unmatch" useful to begin with?

Not sure about add --ignore-unmatch myself, but there's even an
example of rm --ignore-unmatch in man git-filter-branch, along the
lines of

  git filter-branch --index-filter '
    rm --ignore-unmach some_file_that_shouldnt_be_in_history
  ' -- --all

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
