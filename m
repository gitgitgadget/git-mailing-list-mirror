From: "Gabor Z. Papp" <gzp@papp.hu>
Subject: Re: git 1.6.6.1 on glibc 2.2
Date: Sun, 24 Jan 2010 16:09:37 +0100
Message-ID: <x6d40zmte6@gzp>
References: <x6y6jn4txy@gzp> <20100124122751.GA3265@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ46d-0004Zy-2h
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 16:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0AXPJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 10:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155Ab0AXPJj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 10:09:39 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:52371 "EHLO odpn1.odpn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135Ab0AXPJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 10:09:39 -0500
Received: from odpn1.odpn.net [212.40.96.53]
	by odpn1.odpn.net 
	id 1NZ45q-0000Cc-89; Sun, 24 Jan 2010 16:09:38 +0100
User-Agent: Gnus/5.110011 (No Gnus v0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137901>

* Jonathan Nieder <jrnieder@gmail.com>:

| > trying to compile git 1.6.6.1 on Linux 2.4.37.7, glibc 2.2.5:
| > 
| > read-cache.c: In function 'fill_stat_cache_info':
| > read-cache.c:72: error: 'struct stat' has no member named 'st_ctim'

| Thanks for the report.  Perhaps:
| # Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
| # available.  This automatically turns USE_NSEC off.

Thanks Jonathan, compiles fine defining NO_NSEC, but my glibc is 2.2.5
and the comment abot USE_NSEC says it requires at least glibc
2.2.4. Maybe the comment is wrong? glibc 2.3.6 compiles fine.
