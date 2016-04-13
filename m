From: Mike Hommey <mh@glandium.org>
Subject: Re: Ambiguous sha-1 during a rebase
Date: Thu, 14 Apr 2016 07:52:34 +0900
Message-ID: <20160413225234.GA21602@glandium.org>
References: <20160413222919.GA10474@glandium.org>
 <xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:52:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTeP-0003ko-F2
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbcDMWwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:52:42 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34386 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbcDMWwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:52:41 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1aqTeE-0005ct-9O; Thu, 14 Apr 2016 07:52:34 +0900
Content-Disposition: inline
In-Reply-To: <xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291509>

On Wed, Apr 13, 2016 at 03:42:44PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Should git-rebase use full sha-1s under the hood to avoid these type of
> > races?
> 
> It already should be doing so since Aug 2013, IIRC.

I'm using 2.8.1. Would there have been a regression?

Mike
