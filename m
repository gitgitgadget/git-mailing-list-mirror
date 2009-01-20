From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] contrib: add 'git bpush' to push to bundles
Date: Tue, 20 Jan 2009 07:47:32 +0100
Organization: glandium.org
Message-ID: <20090120064732.GA14580@glandium.org>
References: <1232408791-16834-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-15?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 07:49:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPAQ7-0004gI-7P
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 07:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbZATGrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 01:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbZATGrl
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 01:47:41 -0500
Received: from vuizook.err.no ([85.19.221.46]:59249 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbZATGrl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 01:47:41 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LPAOb-0003se-Va; Tue, 20 Jan 2009 07:47:36 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LPAOa-0004GK-OF; Tue, 20 Jan 2009 07:47:32 +0100
Content-Disposition: inline
In-Reply-To: <1232408791-16834-1-git-send-email-santi@agolina.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106443>

On Tue, Jan 20, 2009 at 12:46:31AM +0100, Santi B=E9jar wrote:
> 'git bpush' updates the branches in a bundle, while adding the object=
s
> necessary to complete the given branches. Basically, it is a 'git
> push' for bundles.

I think it'd be better to improve git-push to support that, instead of
adding yet another git command.

Mike
