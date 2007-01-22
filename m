From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: modifying commit's author
Date: Mon, 22 Jan 2007 16:04:00 -0500
Message-ID: <20070122210400.GB6614@fieldses.org>
References: <20070122203734.GB23187@fieldses.org> <200701222150.16465.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 22:06:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H96Lg-0003XM-Nk
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 22:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbXAVVEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 Jan 2007 16:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbXAVVEE
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 16:04:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:53121 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932658AbXAVVED (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 16:04:03 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H96Ke-0001wv-QZ; Mon, 22 Jan 2007 16:04:00 -0500
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
In-Reply-To: <200701222150.16465.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37455>

On Mon, Jan 22, 2007 at 09:50:16PM +0100, Robin Rosenberg wrote:
> m=E5ndag 22 januari 2007 21:37 skrev J. Bruce Fields:
> > If I got the author wrong on a commit, is there a quick way to fix =
it
> > (e.g. by passing the right arguments or environment variables to co=
mmit
> > --amend)?
>=20
> Set these:
> GIT_AUTHOR_EMAIL
> GIT_AUTHOR_NAME
> GIT_COMMITTER_EMAIL
> GIT_COMMITTER_NAME

That doesn't seem to work in this case, since with the commands that
take an existing commit as a model (like commit --amend and commit -c),
the author information from the existing commit overrides those
environment variables.  Which is normally what you want.

--b.
