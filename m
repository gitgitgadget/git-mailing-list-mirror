From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH 10/10] merge-recursive: add a label for ancestor
Date: Mon, 15 Mar 2010 09:18:32 -0400
Message-ID: <jwvd3z5d8u0.fsf-monnier+inbox@gnu.org>
References: <20100305215253.364.63583.reportbug@localhost>
	<20100305221950.GB5083@progeny.tock>
	<20100315074748.GA28827@progeny.tock>
	<20100315080703.GJ8824@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 14:28:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrALN-0000pC-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 14:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952Ab0CON2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 09:28:17 -0400
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:8715 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964902Ab0CON2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 09:28:17 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2010 09:28:16 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAGbQnUtFxL9q/2dsb2JhbACacHS3BYR7BIsP
X-IronPort-AV: E=Sophos;i="4.49,643,1262581200"; 
   d="scan'208";a="58261826"
Received: from 69-196-191-106.dsl.teksavvy.com (HELO pastel.home) ([69.196.191.106])
  by ironport2-out.pppoe.ca with ESMTP; 15 Mar 2010 09:18:32 -0400
Received: by pastel.home (Postfix, from userid 20848)
	id 5C57D8828; Mon, 15 Mar 2010 09:18:32 -0400 (EDT)
In-Reply-To: <20100315080703.GJ8824@progeny.tock> (Jonathan Nieder's message
	of "Mon, 15 Mar 2010 03:07:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142209>

> I would be interested to know which merge tool chokes on |||||||. ;)

In my case, it was smerge-mode.el (a minor mode included in Emacs since
Emacs-22, which highlights such conflicts and tries to help you resolve
them).


        Stefan


PS: As you may have guessed, I'm the primary author of this
Emacs package.
