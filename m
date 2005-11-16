From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 12:33:34 -0800
Message-ID: <20051116203334.GA3968@reactrix.com>
References: <437B6997.8010903@mc.com> <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net> <437B8CEC.8040002@mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 21:35:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTyt-0001G5-Op
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbVKPUeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 15:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbVKPUeI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:34:08 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:7431 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030492AbVKPUeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 15:34:07 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAGKXZ9J008007;
	Wed, 16 Nov 2005 12:33:35 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAGKXYab008005;
	Wed, 16 Nov 2005 12:33:34 -0800
To: Andrew Wozniak <awozniak@mc.com>
Content-Disposition: inline
In-Reply-To: <437B8CEC.8040002@mc.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12054>

On Wed, Nov 16, 2005 at 02:47:56PM -0500, Andrew Wozniak wrote:

> Unfortunately, now there are other failures:
> 
> gcc -o http-push.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'
> http-push.c
> http-push.c: In function `start_mkcol':
> http-push.c:479: `CURLOPT_HTTPGET' undeclared (first use in this
> function)

http-push requires a curl option that looks like it was added around
version 7.8.1.  If you have the option to upgrade your version of curl,
it should fix the problem.  You can also disable building http-push but
keep http-fetch by defining NO_EXPAT.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
