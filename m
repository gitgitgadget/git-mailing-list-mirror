From: Mike Hommey <mh@glandium.org>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Tue, 18 Nov 2014 11:21:37 +0900
Message-ID: <20141118022137.GA8418@glandium.org>
References: <20141118003426.GA6528@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 03:21:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqYQP-0007tP-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbaKRCVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:21:45 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:46125 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbaKRCVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:21:45 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XqYQD-0003Xw-4x
	for git@vger.kernel.org; Tue, 18 Nov 2014 11:21:37 +0900
Content-Disposition: inline
In-Reply-To: <20141118003426.GA6528@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 09:34:26AM +0900, Mike Hommey wrote:
> Hi,
> 
> For some reason, I need to know the sha1 corresponding to some marks
> I'm putting in a fast-import stream. Unfortunately, this does not appear
> to be possible.
> - I'd rather not require a checkpoint to export marks each time I need
>   such a sha1, and I'd rather not do that work that requires them after
>   all the marks have been created (although currently, I'm forced to).

BTW, if it so happens that all the operations that were done end up
creating objects that already existed for some reason, checkpoint
doesn't do anything, which is fine for the pack and tags, but not
necessarily so for export-marks.

Mike
