From: Mike Hommey <mh@glandium.org>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Tue, 18 Nov 2014 12:14:06 +0900
Message-ID: <20141118031406.GB15358@glandium.org>
References: <20141118003426.GA6528@glandium.org>
 <20141118022137.GA8418@glandium.org>
 <20141118025359.GI4336@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 04:14:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqZFB-0006JT-5u
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 04:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbaKRDON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 22:14:13 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:46335 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbaKRDOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 22:14:12 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XqZF0-00041s-5O; Tue, 18 Nov 2014 12:14:06 +0900
Content-Disposition: inline
In-Reply-To: <20141118025359.GI4336@google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 06:53:59PM -0800, Jonathan Nieder wrote:
> Mike Hommey wrote:
> 
> > BTW, if it so happens that all the operations that were done end up
> > creating objects that already existed for some reason, checkpoint
> > doesn't do anything, which is fine for the pack and tags, but not
> > necessarily so for export-marks.
> 
> Does something like this help?

I'm not sure about branches and tags, as they would mostly be noops,
but dump_marks definitely needs to happen. I did try to move dump_marks
out of the if already, and that did what I wanted.

Mike
