From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] gitk: add a checkbox to control the visibility of tags
Date: Sun, 2 Dec 2012 15:40:06 -0600
Message-ID: <CAMP44s1UeAqO_4ous1Bp-PgJ2OJ+=f=CmfbNOKD51whd_jEmsQ@mail.gmail.com>
References: <1354309737-4280-1-git-send-email-stlman@poczta.fm>
	<7vlidhmc5i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	=?UTF-8?Q?=C5=81ukasz_Stelmach?= <stlman@poczta.fm>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:40:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfHHB-000484-An
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 22:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab2LBVkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 16:40:08 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36919 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab2LBVkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 16:40:07 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so1904119obb.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cwhoDw5yE2C7i69UVoEcvq+nIEVuoXjb9JlYprq+MeY=;
        b=p6JIuchWfY4pGBYRYx5L+fDxFojZe1DmWRJj1pi16ztmvHQQ17dtPtyi/TwpsHo8fL
         9je2B1OzqfBuiI6hXRcH5vPbHpVM84/5aFZIHYKBf/tFQQaH5wONs7MoOp5aYRs7nDSc
         +cE4E2N4SCrEARkMTZ64u2urkJx6SGczNDI531F1TjbK3dWOq16AD1vbWij1XAz784U/
         uzZnIPoYWSaP5m6IkUF8WI59ibgereVjnxkntfNxVWWdfY99sW33uzkDTBdzEkxe2/h3
         F49Euj7KQzMYacQ4EEGTHXrXYJG+9B2WZ3plZ1drQ6FqybPkGgeWjKx2CyITPwjDTW+8
         WACg==
Received: by 10.182.69.36 with SMTP id b4mr2798835obu.96.1354484406186; Sun,
 02 Dec 2012 13:40:06 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 2 Dec 2012 13:40:06 -0800 (PST)
In-Reply-To: <7vlidhmc5i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211022>

On Sat, Dec 1, 2012 at 8:16 PM, Junio C Hamano <gitster@pobox.com> wrote:

> We _may_ want to unify these two "hidestuff" into a list of patterns
> that hides any ref that match one of the patterns in the list, e.g.
>
>         set hidestuff {refs/heads/*/* refs/tags/* refs/remotes/*}
>
> may hide all tags, all remote-tracking branches and local branches
> that have a slash in their names.

And hide the rest. Currently gitk shows all other refs (e.g. refs/hg/*).

-- 
Felipe Contreras
