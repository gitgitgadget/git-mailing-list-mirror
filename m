From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't 
	loop forever
Date: Mon, 30 Mar 2009 10:18:59 -0400
Message-ID: <76718490903300718m7d172a12y4aab63f0ff75f286@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	 <vpqd4bzjlk1.fsf@bauges.imag.fr>
	 <76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoILs-0003sY-P3
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbZC3OTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753542AbZC3OTE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:19:04 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:60166 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbZC3OTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:19:03 -0400
Received: by gxk4 with SMTP id 4so4318805gxk.13
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cBZQeFht0YFOw9mUIBiYAzbUDJfXN69uoxlkRIbdbUE=;
        b=azSQcuMKWxvSe2AifveuMGYOfywSuDMd+A3KK0VOssTkjNr7ktbnJnjtw1I1bjftqo
         CtP+qng7bHiunHOSCooqmfJnfA/zmIABtoi/uSCfvXrVtBfuAPgXpMWd8WDkKlGcI91t
         GlJMJrSMC1WIEtkRoPYz/brt8d41KP5JFZrLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MUSJlJHVaY+y4JC6mbVexgIcTp8z+CNpvGye535IdjjcWr2XGGRj1SqsoGVyvz8TSL
         4rXGlnI6iV9P4TTOLg+kC/OuB3j5awe0CUyJvScVEW6q9/LQEt2bMbwiOr5WEy/s3i0i
         ky13dUILOUnecrS4HXimyEgpkM+fam+QkymAE=
Received: by 10.150.225.17 with SMTP id x17mr10524530ybg.223.1238422739721; 
	Mon, 30 Mar 2009 07:18:59 -0700 (PDT)
In-Reply-To: <76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115157>

On Mon, Mar 30, 2009 at 10:17 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> perl send-email ... 2>/dev/null :-)

Hmfph, perl on the mind. That should of course be "git send-email ...
2>/dev/null" but it was only a half-serious suggestion anyway.

j.
