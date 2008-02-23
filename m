From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Sat, 23 Feb 2008 13:52:36 +0100
Message-ID: <200802231352.37934.robin.rosenberg.lists@dewire.com>
References: <47AAA254.2020008@thorn.ws> <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org> <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 13:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JStsb-0002Ct-JW
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 13:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbYBWMwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 07:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbYBWMwq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 07:52:46 -0500
Received: from [83.140.172.130] ([83.140.172.130]:9274 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbYBWMwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 07:52:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A2DC080069D;
	Sat, 23 Feb 2008 13:52:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KMYFim4s5Am; Sat, 23 Feb 2008 13:52:43 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 26ECC80019B;
	Sat, 23 Feb 2008 13:52:42 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74818>

l=F6rdagen den 23 februari 2008 skrev Gerrit Pape:
> Saving the geometry can cause several inconveniences, e.g. when using=
 a
> temporary dual screen setup, or sharing ~/.gitk between multiple
> systems.  Additionally it can be argued that window placement and siz=
ing
> are the tasks of the window manager.  So don't do that anymore.

Shouldn't the restoring code also be dropped then?=20

Other than that, I agree. The Gitk current behaviour wrt dual screens=20
is really inconvenient.

-- robin
