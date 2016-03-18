From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH][Outreachy] branch: allow - as abbreviation of '@{-1}'
Date: Sat, 19 Mar 2016 02:02:55 +0900
Message-ID: <20160318170255.GA9846@glandium.org>
References: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
 <xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 18:41:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agyP7-0002W3-1o
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 18:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563AbcCRRlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 13:41:02 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:39508 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587AbcCRRlA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 13:41:00 -0400
X-Greylist: delayed 2273 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Mar 2016 13:40:58 EDT
Received: from glandium by zenigata with local (Exim 4.86_2)
	(envelope-from <mh@glandium.org>)
	id 1agxnb-0002iJ-TT; Sat, 19 Mar 2016 02:02:55 +0900
Content-Disposition: inline
In-Reply-To: <xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289236>

On Fri, Mar 18, 2016 at 09:10:37AM -0700, Junio C Hamano wrote:
>  * We forbid declaration-after-statement in our codebase.

By the way, why not enforce it with -Werror=declaration-after-statement?
If people patching git get an error when they do it, they won't submit
a patch with it, and you won't have to tell them about it :)

Mike
