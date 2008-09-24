From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Fix submodule sync with relative submodule URLs
Date: Wed, 24 Sep 2008 18:41:48 +0200
Message-ID: <200809241841.48934.johan@herland.net>
References: <200809221808.31730.johan@herland.net> <200809241131.16327.johan@herland.net> <20080924161902.GT3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mdl123@verizon.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 18:44:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXTS-00005F-7V
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 18:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYIXQnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 12:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbYIXQnJ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 12:43:09 -0400
Received: from sam.opera.com ([213.236.208.81]:33436 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbYIXQnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 12:43:08 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m8OGfn1K015730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Sep 2008 16:41:54 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20080924161902.GT3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96661>

On Wednesday 24 September 2008, Shawn O. Pearce wrote:
> I guess I'm unclear about why cmd_sync is different from the
> existing callers.

It's not any different as far as I'm concerned. We should probably add 
helpful error messages to the other callers as well.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
