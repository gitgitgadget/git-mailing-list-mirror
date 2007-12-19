From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/2] Make new infrastructure subdirectory safe
Date: Wed, 19 Dec 2007 23:28:20 +0100
Message-ID: <20071219222820.GA15119@diana.vm.bytemark.co.uk>
References: <20071218092419.GA16029@diana.vm.bytemark.co.uk> <20071219221848.29455.50676.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J57PD-0005gn-9h
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbXLSW2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbXLSW2Y
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:28:24 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1439 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbXLSW2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:28:24 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J57Om-0003zX-00; Wed, 19 Dec 2007 22:28:20 +0000
Content-Disposition: inline
In-Reply-To: <20071219221848.29455.50676.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68948>

On 2007-12-19 23:19:23 +0100, Karl Hasselstr=F6m wrote:

> Karl Hasselstr=F6m (2):
>       Make "stg goto" subdirectory safe
>       Test that "stg goto" can be called from a subdirectory

I forgot to say, but this goes on top of kha/experimental. The test
makes use of the "return exit code 3 when there was conflicts" patch
to make sure that there was a conflict and not another error.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
