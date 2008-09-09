From: Mike Hommey <mh@glandium.org>
Subject: Re: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 9 Sep 2008 10:18:09 +0200
Organization: glandium.org
Message-ID: <20080909081808.GA22697@glandium.org>
References: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Sep 09 10:20:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcySK-00031I-7N
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbYIIISg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbYIIISf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:18:35 -0400
Received: from vuizook.err.no ([194.24.252.247]:59683 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504AbYIIISe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:18:34 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KcyQa-0005wt-Jf; Tue, 09 Sep 2008 10:18:31 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1KcyQL-0005ud-1G; Tue, 09 Sep 2008 10:18:09 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95349>

On Tue, Sep 09, 2008 at 07:19:55AM +0100, Peter Krefting <peter@softwolves.pp.se> wrote:
> Hi!
> 
> I find myself tracking OpenOffice files every now and then. Mostly to
> synchronise to be able to edit documents in multiple locations, less
> for the actual history.
> 
> I notice, however, that the Git history tend to grow quite a bit,
> especially for larger documents (I have a 175 kilobyte spredsheet that
> has a git database of about 8 megabytes).
> 
> Since OpenOffice doucuments are just zipped xml files, I wondered how
> difficult it would be to create some hooks/hack git to track the files
> inside the archives instead?

It could be worth having a generic tool that would do similar things
to what pristine-tar[1] does.

Mike

1. http://joey.kitenet.net/code/pristine-tar/
