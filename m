From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH 0/2] git-stash last-minute fixes
Date: Sat, 28 Jul 2007 18:06:49 +0900
Message-ID: <200707280907.l6S974eE015202@mi0.bluebottle.com>
References: <7vbqdxui72.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 11:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEiGT-0006PA-T4
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 11:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbXG1JHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 05:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbXG1JHG
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 05:07:06 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:40096 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbXG1JHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 05:07:05 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6S974eE015202
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 02:07:04 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=eksPKGJcNL7AGPSczUpAf6jrlGpeLqO43ZfO8ABIvrQMlN7m3hNJPSuIJVy4dejk2
	aOHiZ3vtfRw13GcFNNqO+gppg1isAFVpLkoVYr+9PC58nKug3ZUrq6kTQE/Lxoe
Received: from nanako3.mail.bluebottle.com ([58.216.233.166])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6S96s2g008005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 02:07:00 -0700
In-Reply-To: <7vbqdxui72.fsf@assigned-by-dhcp.cox.net>
X-Trusted-Delivery: <45227772d8a88da560aa4f5b0cf72b8b>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54017>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> Here are a small patch series to git-stash.
>
>  [1/2] Fix git-stash apply --index
>
>  This fixes two rather embarrasing bugs in "apply --index".
>
>  [2/2] git-stash apply --index: optimize postprocessing
>
>  This builds on top of the previous one to avoid unnecessary
>  index manipulations that is later wiped by a read-tree.

Thank you for the patch.  I have not used the --index things
myself and did not notice these breakages.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
