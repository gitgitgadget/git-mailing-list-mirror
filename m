From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v3 1/5] git-p4: Allow setting rename/copy detection
 threshold
Date: Mon, 22 Aug 2011 08:18:37 -0400
Message-ID: <20110822121837.GA3761@arf.padd.com>
References: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
 <1314001989-29017-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 14:19:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvTTB-0004qK-On
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 14:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab1HVMTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 08:19:02 -0400
Received: from honk.padd.com ([74.3.171.149]:53074 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab1HVMTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 08:19:01 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 3D7FA5B26;
	Mon, 22 Aug 2011 05:18:58 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A58F431448; Mon, 22 Aug 2011 08:18:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1314001989-29017-2-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179859>

vitor.hda@gmail.com wrote on Mon, 22 Aug 2011 09:33 +0100:
> Copy and rename detection arguments (-C and -M) allow setting a threshold value
> for the similarity ratio. If the similarity is below this threshold the rename
> or copy is ignored and the file is added as new.
> This patch allows setting git-p4.detectRenames and git-p4.detectCopies options
> to an integer value to set the respective threshold.
> 
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>

This series looks great.  Thanks for fixing the --bool issue and
the tests.

Acked-by: Pete Wyckoff <pw@padd.com>

		-- Pete
