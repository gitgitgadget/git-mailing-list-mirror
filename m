From: Mike Hommey <mh@glandium.org>
Subject: Re: Multiblobs
Date: Thu, 29 Apr 2010 08:55:41 +0200
Message-ID: <20100429065541.GB3268@glandium.org>
References: <loom.20100428T164432-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 21:38:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7w2y-0008Of-H0
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934340Ab0D3Thq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:37:46 -0400
Received: from vuizook.err.no ([85.19.221.46]:55408 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934254Ab0D3Thg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:37:36 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1O7New-0000nA-Sz; Thu, 29 Apr 2010 08:55:46 +0200
Received: from mh by glandium.org with local (Exim 4.71)
	(envelope-from <mh@glandium.org>)
	id 1O7Nev-00012C-MT; Thu, 29 Apr 2010 08:55:41 +0200
Content-Disposition: inline
In-Reply-To: <loom.20100428T164432-954@post.gmane.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 2.5): No, score=2.5 required=5.0 tests=DNS_FROM_OPENWHOIS,RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146052>

On Wed, Apr 28, 2010 at 03:12:07PM +0000, Sergio Callegari wrote:
> Hi,
> 
> it happened to me to read an older post by Jeff King about "multiblobs"
> (http://kerneltrap.org/mailarchive/git/2008/4/6/1360014) and I was wandering
> whether the idea has been abandoned for some reason or just put on hold.
> 
> Apparently, this would marvellously help on
> - storing large binary blobs (the split could happen with a rolling checksum
> approach)
> - storing "structured files", such as the many zip-based file formats
> (Opendocument, Docx, Jar files, zip files themselves), tars (including
> compressed tars), pdfs, etc, whose number is rising day after day...
> - storing binary files with textual tags, where the tags could go on a separate
> blob, greatly simplifying their readout without any need for caching them on a
> note tree.
> - etc...

This sounds very much like what I've had in mind for a while, but I
always thought that git as a VCS doesn't need that, and that it could be
a feature of a new program, for which the git object database would be a
special case. That is, a program using the git object database format
for individual objects and packs, but with additional object types.

Mike
