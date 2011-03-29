From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref only
Date: Tue, 29 Mar 2011 14:39:17 +0200
Message-ID: <201103291439.17197.johan@herland.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 14:39:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4YCp-0005Cs-AO
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 14:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab1C2MjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 08:39:25 -0400
Received: from smtp.opera.com ([213.236.208.81]:51240 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab1C2MjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 08:39:25 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p2TCdHLq000507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 Mar 2011 12:39:17 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170262>

On Tuesday 29 March 2011, Michael J Gruber wrote:
> As notes become increasingly popular, it's often interesting to show
> notes from a particular notes ref only. Introduce '--notes-ref=<ref>'
> as a convenience shortcut for '--no-standard-notes
> --show-notes=<ref>'.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> The idea is to use the same name as in "git notes --ref=<ref>" but
> make it clear for the rev-list option to be about notes, thus
> "--notes-ref=<ref>".

The idea and implementation look good to me. Not sure I like the 
option "bloat" (somehow feels it should be possible to express the same 
behavior using fewer options), but if there's not a better way to 
reorganize the options, then you can consider it Acked-by me.


Thanks! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
