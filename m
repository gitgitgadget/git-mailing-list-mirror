From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Git and Media repositories....
Date: Fri, 7 Nov 2008 14:19:05 +0100
Message-ID: <adf1fd3d0811070519qc54369vf0da3bc28182460a@mail.gmail.com>
References: <1225655428.11693.10.camel@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Ansell" <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 14:20:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyRGF-0006Z4-Je
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 14:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbYKGNTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 08:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbYKGNTI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 08:19:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:32139 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbYKGNTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 08:19:07 -0500
Received: by nf-out-0910.google.com with SMTP id d3so598967nfc.21
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 05:19:05 -0800 (PST)
Received: by 10.103.175.9 with SMTP id c9mr1754149mup.3.1226063945295;
        Fri, 07 Nov 2008 05:19:05 -0800 (PST)
Received: by 10.103.179.20 with HTTP; Fri, 7 Nov 2008 05:19:05 -0800 (PST)
In-Reply-To: <1225655428.11693.10.camel@vaio>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100313>

On Sun, Nov 2, 2008 at 8:50 PM, Tim Ansell <mithro@mithis.com> wrote:
> Hey guys,
>

[...]

>
> The general idea is that we always clone the complete meta-data (tags,
> commits and trees) and then only clone blobs when they are needed (using
> something like alternates). This allows us to support shallow, narrow
> and sparse checkouts while still being able to perform operations such
> as committing and merging.
>

A related use case could be to remove a blob from a repo but being
able to work normally with it, similar to:

http://wiki.freebsd.org/VCSFeatureObliterate

Santi
