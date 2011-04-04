From: Kevin Ryde <user42@zip.com.au>
Subject: Re: [PATCH] git.el: Don't use font-lock-compile-keywords
Date: Tue, 05 Apr 2011 09:15:41 +1000
Message-ID: <871v1h38wy.fsf@blah.blah>
References: <m3oc501rja.fsf@e4300lm.epcc.ed.ac.uk>
	<20110403001902.GA25671@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lawrence Mitchell <wence@gmx.li>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5ge?= =?iso-8859-1?Q?dal?= 
	<davidk@lysator.liu.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 00:46:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6sXJ-0007Ac-EM
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 00:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab1DDWqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 18:46:00 -0400
Received: from mailout2-2.pacific.net.au ([61.8.2.225]:46781 "EHLO
	mailout2.pacific.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754028Ab1DDWp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 18:45:59 -0400
X-Greylist: delayed 1826 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Apr 2011 18:45:59 EDT
Received: from mailproxy1.pacific.net.au (mailproxy1.pacific.net.au [61.8.2.162])
	by mailout2.pacific.net.au (Postfix) with ESMTP id 2EC8E2B6BDA;
	Tue,  5 Apr 2011 08:15:29 +1000 (EST)
Received: from blah.blah (unknown [203.26.175.149])
	by mailproxy1.pacific.net.au (Postfix) with ESMTP id 8C1C68C23;
	Tue,  5 Apr 2011 08:15:28 +1000 (EST)
Received: from gg by blah.blah with local (Exim 4.72)
	(envelope-from <gg@zip.com.au>)
	id 1Q6szl-0001mk-Rm; Tue, 05 Apr 2011 09:15:41 +1000
In-Reply-To: <20110403001902.GA25671@elie> (Jonathan Nieder's message of "Sat,
	2 Apr 2011 19:19:02 -0500")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170846>

Jonathan Nieder <jrnieder@gmail.com> writes:
>
> Lawrence Mitchell wrote:
>> font-lock-add-keywords rather than font-lock-compile-keywords.
>> However, it doesn't exist in XEmacs,

Oh, I didn't realize that.  In my own code I think I've only ever
set font-lock-defaults and left it at that ...



-- 
Newton's first law elucidated for the layman:
A body in motion continues in motion, unless it doesn't.
