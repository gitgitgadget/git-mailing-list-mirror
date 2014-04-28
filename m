From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 02/12] MINGW: compat/bswap.h: include stdint.h
Date: Mon, 28 Apr 2014 18:52:35 +0400
Message-ID: <20140428145234.GA18918@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-3-git-send-email-marat@slonopotamus.org>
 <CABPQNSaE9ua_JM0bY8QNSThqSKHG3d7N_PV5hmnKRt93sZkVBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:52:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WemvI-0008F2-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 16:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbaD1Owm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 10:52:42 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:52594 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbaD1Owl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 10:52:41 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wemv5-0004ve-3k; Mon, 28 Apr 2014 18:52:35 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSaE9ua_JM0bY8QNSThqSKHG3d7N_PV5hmnKRt93sZkVBQ@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247345>

On Mon, Apr 28, 2014 at 04:45:43PM +0200, Erik Faye-Lund wrote:
> bswap.h is included after stdint.h from git-compat-util.h anyway...

That only becomes true after PATCH 05 when talking about MinGW.

Will drop this one.
