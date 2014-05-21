From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [RFC/PATCH v4 1/3] add high resolution timer function to debug
 performance issues
Date: Wed, 21 May 2014 18:14:00 -0400
Message-ID: <537D2528.3090806@bbn.com>
References: <537BA806.50600@gmail.com> <537BA8D1.1090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:14:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEm0-0008Mm-Ic
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbaEUWOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:14:04 -0400
Received: from smtp.bbn.com ([128.33.1.81]:19096 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414AbaEUWOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:14:03 -0400
Received: from socket.bbn.com ([192.1.120.102]:57770)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WnEm4-0005zd-8U; Wed, 21 May 2014 18:14:12 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id BDDE03FF32
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <537BA8D1.1090503@gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249850>

On 2014-05-20 15:11, Karsten Blees wrote:
> Add a getnanotime() function that returns nanoseconds since 01/01/1970 as
> unsigned 64-bit integer (i.e. overflows in july 2554).

Must it be relative to epoch?  If it was relative to system boot (like
the NetBSD kernel's nanouptime() function), then you wouldn't have to
worry about clock adjustments messing with performance stats and you
might have more options for implementing getnanotime() on various platforms.

-Richard
