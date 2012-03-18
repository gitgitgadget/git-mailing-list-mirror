From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH resend] gitk: Skip over AUTHOR/COMMIT_DATE when searching
 all fields
Date: Mon, 19 Mar 2012 10:24:36 +1100
Message-ID: <20120318232436.GF26977@bloggs.ozlabs.ibm.com>
References: <20120308123539.GA5862@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:26:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9PUf-00087s-O3
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 00:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099Ab2CRX0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 19:26:22 -0400
Received: from ozlabs.org ([203.10.76.45]:47611 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754844Ab2CRX0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 19:26:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 650FAB6FFD; Mon, 19 Mar 2012 10:26:09 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20120308123539.GA5862@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193400>

On Thu, Mar 08, 2012 at 06:35:50AM -0600, Jonathan Nieder wrote:
> From: Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net>
> Date: Sun, 14 Mar 2010 18:59:09 -0400
>=20
> This prevents a search for a number like "105" on "All Fields" from
> matching against the raw author and commit timestamps.  These
> timestamps were already not searchable by themselves, and the
> displayed format does not match the query string anyway.
>=20
> Signed-off-by: Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, applied.

Paul.
