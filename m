From: John Keeping <john@keeping.me.uk>
Subject: Re: Colorize output
Date: Thu, 7 Nov 2013 18:32:48 +0000
Message-ID: <20131107183248.GO24023@serenity.lan>
References: <527BD783.7080606@homecomputing.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas <sanpi@homecomputing.fr>
X-From: git-owner@vger.kernel.org Thu Nov 07 19:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeUO4-0004BI-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 19:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab3KGSc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Nov 2013 13:32:57 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:48841 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab3KGScz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 13:32:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DBFD9CDA599;
	Thu,  7 Nov 2013 18:32:54 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Vxvob4v153b; Thu,  7 Nov 2013 18:32:53 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id ED869CDA5D2;
	Thu,  7 Nov 2013 18:32:50 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <527BD783.7080606@homecomputing.fr>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237421>

On Thu, Nov 07, 2013 at 07:10:11PM +0100, Nicolas wrote:
> I=E2=80=99m developping a git command in shell and I would like color=
ize the output.
>=20
> I don=E2=80=99t find anything in git-sh-setup.
>=20
> What is the best way for don=E2=80=99t reinvent the wheel?

I normally use "git config --get-color ..." either with standard colors
if my command is close to a standard command or with my own config keys
and sensible defaults.
