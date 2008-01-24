From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/4] --diff-opts in config file
Date: Thu, 24 Jan 2008 09:18:19 +0100
Message-ID: <20080124081819.GA20346@diana.vm.bytemark.co.uk>
References: <20080124074827.GA29572@nan92-1-81-57-214-146.fbx.proxad.net> <20080124075935.25525.24416.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 09:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHxId-000072-Cy
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 09:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYAXISZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 03:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbYAXISZ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 03:18:25 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2330 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbYAXISY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 03:18:24 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JHxHv-0005NY-00; Thu, 24 Jan 2008 08:18:19 +0000
Content-Disposition: inline
In-Reply-To: <20080124075935.25525.24416.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71605>

On 2008-01-24 09:06:54 +0100, Karl Hasselstr=F6m wrote:

> I've solved the problem of overriding the config on the command line
> by making --diff-opts=3D'--foo --bar' _add_ options, and special-case=
d
> --diff-opts=3D'' to clear all options, including those from the confi=
g
> file, since appending no options makes no sense.

Mph. I just realized that none of the patches add any documentation
that explains this.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
