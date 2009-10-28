From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: how to split a hunk
Date: Wed, 28 Oct 2009 14:06:10 +0100
Message-ID: <200910281406.12923.trast@student.ethz.ch>
References: <20091028022105.GE3938@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 14:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N38FL-0007Bn-SE
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 14:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbZJ1NHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 09:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbZJ1NHN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 09:07:13 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:33823 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447AbZJ1NHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 09:07:12 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 28 Oct
 2009 14:07:14 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 28 Oct
 2009 14:06:54 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091028022105.GE3938@debian.b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131462>

bill lam wrote:
> There are occasions where diff of a file is
> 
> - aaaa
> + bbbb
> + cccc
> 
> I want to add lines bbbb and cccc as separated commits, but git-add -p
> seem cannot further split this hunk.  Do I have no choice but to edit
> it by hand and commit the bbbb and then edit the file to add back the
> cccc?

There's also the 'git add -p' [e]dit feature, which pops up the patch
in an editor.  There are instructions in that file, but in this case,
you can simply remove one of the additions.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
