From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/18] do_for_each_reflog(): use a strbuf to hold logfile
 name
Date: Fri, 27 Apr 2012 10:59:18 +0200
Message-ID: <4F9A5FE6.40409@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu> <1335479227-7877-9-git-send-email-mhagger@alum.mit.edu> <xmqqaa1y6poq.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:59:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNh1a-0007yc-OZ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 10:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759859Ab2D0I7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 04:59:30 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50462 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759829Ab2D0I73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 04:59:29 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3R8xIFQ026170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Apr 2012 10:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <xmqqaa1y6poq.fsf@junio.mtv.corp.google.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196458>

On 04/27/2012 01:25 AM, Junio C Hamano wrote:
> Please write this like this:
>
> 		if (...) {
> 			; /* silently ignore */
> 		}
>
> to make the "emptyness" stand out (I amended the previous round when I
> queued them to 'pu', but I forgot to point it out in my review message).

OK.  A similar construct is in patch 2 of the same series.  I've fixed 
them in my repo and will use the fixed versions if there are any future 
re-rolls.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
