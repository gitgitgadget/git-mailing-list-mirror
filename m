From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Aug 2009, #04; Sun, 23)
Date: Mon, 24 Aug 2009 17:22:06 +0200
Message-ID: <200908241722.06982.johan@herland.net>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 17:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfbNL-0002iO-4V
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 17:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbZHXPWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 11:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZHXPWQ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 11:22:16 -0400
Received: from sam.opera.com ([213.236.208.81]:34844 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbZHXPWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 11:22:16 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n7OFM75w031164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 24 Aug 2009 15:22:12 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7v1vn2qb29.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126939>

On Monday 24 August 2009, Junio C Hamano wrote:
> * sr/gfi-options (2009-08-13) 3 commits
>  - fast-import: test the new option command
>  - fast-import: add option command
>  - fast-import: put option parsing code in seperate functions
>
> What is this used by?

I'm planning to use it in the CVS remote helper, as a somewhat cleaner 
replacement of this one:

> * db/vcs-helper (2009-08-09) 17 commits
>  - Allow helpers to request marks for fast-import

In other words, I need one or the other, and I currently find the 
gfi-options solution somewhat more elegant than adding the 'marks 
<filename>' command to the foreign remote API.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
