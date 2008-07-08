From: Mike Hommey <mh@glandium.org>
Subject: Re: GiT and CentOS 5.2
Date: Tue, 8 Jul 2008 20:37:04 +0200
Organization: glandium.org
Message-ID: <20080708183704.GA16301@glandium.org>
References: <49523.216.185.71.22.1215539200.squirrel@webmail.harte-lyne.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "James B. Byrne" <byrnejb@harte-lyne.ca>
X-From: git-owner@vger.kernel.org Tue Jul 08 20:38:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGI4n-0000Ww-Og
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 20:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbYGHShO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 14:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbYGHShN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 14:37:13 -0400
Received: from vuizook.err.no ([194.24.252.247]:42728 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546AbYGHShM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 14:37:12 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KGI3i-00018Q-ON; Tue, 08 Jul 2008 20:37:09 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KGI3k-0004Hw-SI; Tue, 08 Jul 2008 20:37:04 +0200
Content-Disposition: inline
In-Reply-To: <49523.216.185.71.22.1215539200.squirrel@webmail.harte-lyne.ca>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87782>

On Tue, Jul 08, 2008 at 01:46:40PM -0400, James B. Byrne wrote:
> OS = CentOS-5.2
> perl = 5.8.8
> 
> I get git from the yum repository at kernel.org.  Up until the most recent
> update I had no problems.  Now I am getting these dependency errors:
> 
> Error: Missing Dependency: libcurl.so.4 is needed by package git
> Error: Missing Dependency: perl(:MODULE_COMPAT_5.10.0) is needed by
> package perl-Git
> Error: Missing Dependency: libc.so.6(GLIBC_2.7) is needed by package git
> Error: Missing Dependency: libexpat.so.1 is needed by package git
> Error: Missing Dependency: libcrypto.so.7 is needed by package git
> 
> 
> Are these dependencies actually meaningful?  By that I mean, are there
> features used in the latest release of GiT that depend upon features of
> GLIBC 2.7 that are not part of glibc-2.5?  Similarly, are there features
> of curl used in the latest git that are not present or work differently in
> curl 7.15.2?  Ditto for OpenSSL and libxpat.

This only means the rpms in the yum repository at kernel.org were built
on a system more recent than yours, and that run-time dependencies (as
opposed to build dependencies) require some libraries to be newer than
what your system provides.

Mike
