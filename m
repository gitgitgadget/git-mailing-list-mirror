From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH 1/5] t/test-lib-functions.sh: allow to specify the tag
 name to test_commit
Date: Wed, 14 Nov 2012 19:20:05 -0800
Message-ID: <20121115032005.GA20677@ftbfs.org>
References: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 04:20:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYq0O-0005IO-RK
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 04:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305Ab2KODU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 22:20:26 -0500
Received: from zoom.lafn.org ([108.92.93.123]:35890 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933282Ab2KODUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 22:20:25 -0500
Received: from hpe-490t.ftbfs.org (anon-163-166.vpn.ipredator.se [93.182.163.166])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id qAF3KHfx097563;
	Wed, 14 Nov 2012 19:20:20 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by hpe-490t.ftbfs.org with local (Exim 4.80)
	(envelope-from <kraai@ftbfs.org>)
	id 1TYpzq-0005yT-J0; Wed, 14 Nov 2012 19:20:06 -0800
Content-Disposition: inline
In-Reply-To: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209794>

On Wed, Nov 14, 2012 at 05:37:50PM -0800, Brandon Casey wrote:
> -# Both <file> and <contents> default to <message>.
> +# Both <file> <contents> and <tag> default to <message>.

I think this line would be better as

 # <file>, <contents>, and <tag> all default to <message>.

since there's now more than two arguments that default to message.

-- 
Matt
