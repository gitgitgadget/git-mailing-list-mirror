From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-svn should default to --repack
Date: Fri, 18 Jan 2008 16:56:07 +0100
Message-ID: <20080118155607.GA21236@diana.vm.bytemark.co.uk>
References: <96C7A3A5-D750-43AB-A8A6-8A3A6D09AF4E@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 16:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFtaZ-0007L3-Hj
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 16:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760931AbYARP4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 10:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760856AbYARP4U
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 10:56:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4812 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758959AbYARP4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 10:56:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JFtZf-0005Zp-00; Fri, 18 Jan 2008 15:56:07 +0000
Content-Disposition: inline
In-Reply-To: <96C7A3A5-D750-43AB-A8A6-8A3A6D09AF4E@sb.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71032>

On 2008-01-18 07:17:55 -0500, Kevin Ballard wrote:

> I was very surprised to find that git-svn does not in fact default
> to --repack. I firmly believe it should.

I believe so too. And nowadays there's "git gc --auto", which was made
for occasions such as this, so it should be a breeze to implement. The
overhead might be low enough that it can be called after _every_
imported revision.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
