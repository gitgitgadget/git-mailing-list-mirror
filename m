From: Mike Hommey <mh@glandium.org>
Subject: Re: Allowing weak references to blobs and strong references to
 commits
Date: Wed, 1 Apr 2015 08:35:45 +0900
Message-ID: <20150331233545.GA16511@glandium.org>
References: <20150331100756.GA13377@glandium.org>
 <xmqq8uecrk5g.fsf@gitster.dls.corp.google.com>
 <20150331223919.GA24362@glandium.org>
 <20150331231449.GF22844@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:36:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd5hZ-00060B-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 01:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbbCaXgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 19:36:05 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:44282 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbbCaXgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 19:36:04 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Yd5hB-0004X1-GM; Wed, 01 Apr 2015 08:35:45 +0900
Content-Disposition: inline
In-Reply-To: <20150331231449.GF22844@google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266584>

On Tue, Mar 31, 2015 at 04:14:49PM -0700, Jonathan Nieder wrote:
> Mike Hommey wrote:
> 
> > Octopus merges are limited to 16 parents.
> 
> The note about this in fast-import is out of date (e.g., see
> t/t7602-merge-octopus-many.sh and v1.6.0-rc0~194, 2008-06-27).  How
> about this patch?

Aha! I wasn't stoned! Thanks for fixing this :)

Mike
