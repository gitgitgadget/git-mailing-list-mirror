From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/8] revert: Improve error handling by cascading errors upwards
Date: Fri, 13 May 2011 16:00:47 +0530
Message-ID: <20110513103045.GJ14272@ramkum.desktop.amazon.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-2-git-send-email-artagnon@gmail.com> <20110511095949.GA2676@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 12:30:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKpe4-0002ug-RP
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 12:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758163Ab1EMKaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 06:30:52 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:48613 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452Ab1EMKav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 06:30:51 -0400
X-IronPort-AV: E=Sophos;i="4.64,363,1301875200"; 
   d="scan'208";a="435401515"
Received: from smtp-in-0102.sea3.amazon.com ([10.224.19.46])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 May 2011 10:30:50 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0102.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p4DAUl45024801;
	Fri, 13 May 2011 10:30:48 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 1D5DD75483F; Fri, 13 May 2011 16:00:47 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110511095949.GA2676@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173525>

Hi,

As you've pointed out, this patch is a complete disaster.  Error
handling is very non-trivial, and my earlier attempts have failed.
I'll try to redo this, and then respond to your review.

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> [...]
> *whew*

-- Ram
