From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] git property page for project properties.
Date: Tue, 21 Oct 2008 07:37:31 +0200
Message-ID: <200810210737.31377.robin.rosenberg.lists@dewire.com>
References: <1224529604-42397-1-git-send-email-tomi.pakarinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Tomi Pakarinen <tomi.pakarinen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Oct 21 07:38:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks9xI-0006bR-Cf
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 07:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbYJUFhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 01:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYJUFhl
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 01:37:41 -0400
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:43119 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbYJUFhk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 01:37:40 -0400
Received: by av12-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 83472380E7; Tue, 21 Oct 2008 07:37:38 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 6B716380E0; Tue, 21 Oct 2008 07:37:38 +0200 (CEST)
Received: from sleipner.dewire.com (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 24B2E37E4B;
	Tue, 21 Oct 2008 07:37:37 +0200 (CEST)
Received: from dewire.com (unknown [10.9.0.1])
	by sleipner.dewire.com (Postfix) with ESMTP id 29F9B5AC;
	Tue, 21 Oct 2008 07:37:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1C289802E07;
	Tue, 21 Oct 2008 07:37:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tBwnZdNsPeS1; Tue, 21 Oct 2008 07:37:36 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 924AA80267D;
	Tue, 21 Oct 2008 07:37:36 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1224529604-42397-1-git-send-email-tomi.pakarinen@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98758>

m=E5ndagen den 20 oktober 2008 21.06.44 skrev Tomi Pakarinen:
>  Show git property page in project's properties, if project
> has git repository provider.
>=20
> Signed-off-by: Tomi Pakarinen <tomi.pakarinen@iki.fi>
> ---
>=20
>  This is similar to CVS's property page. Current
> information on page is very limited and non editable.
>=20
>  Tomi.
>=20
> +	Text gitDir;
> +
> +	Text branch;
> +
> +	Text id;
> +
> +	Text state;
> +
> +	Text workDir;

Should be private. I'll squash that in and patch Egit to detect
the 1.6-way of recording repository state, which I noted it does
not handle.

-- robin
