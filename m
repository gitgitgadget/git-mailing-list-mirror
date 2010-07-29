From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/5] tests: implicitly skip SYMLINKS tests using
	<prereq>
Date: Wed, 28 Jul 2010 20:00:05 -0500
Message-ID: <20100729010005.GE29156@dert.cs.uchicago.edu>
References: <1280313299-721-1-git-send-email-avarab@gmail.com> <1280313299-721-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 03:00:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeHTu-0002Us-Dd
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab0G2BAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 21:00:13 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:45760 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0G2BAM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 21:00:12 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 82975A204;
	Wed, 28 Jul 2010 20:00:11 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 0A8FF20DBC; Wed, 28 Jul 2010 20:00:10 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1280313299-721-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152136>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

>  t/t2007-checkout-symlink.sh       |   14 ++++----------
>  t/t4011-diff-symlink.sh           |   18 ++++++------------
>  t/t4023-diff-rename-typechange.sh |   14 ++++----------
>  t/t4114-apply-typechange.sh       |   28 +++++++++++----------------=
-
>  t/t4115-apply-symlink.sh          |   12 +++---------
>  t/t4122-apply-symlink-inside.sh   |   12 +++---------
>  t/t5522-pull-symlink.sh           |   14 ++++----------
>  t/t6035-merge-dir-to-symlink.sh   |   20 +++++++-------------
>  8 files changed, 42 insertions(+), 90 deletions(-)

I like it. :)
