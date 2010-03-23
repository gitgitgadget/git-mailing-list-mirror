From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5] Improve remote-helpers documentation
Date: Tue, 23 Mar 2010 13:17:26 +0530
Message-ID: <f3271551003230047t735f592ei6d4da50d4d458758@mail.gmail.com>
References: <f3271551003220954s38ed80f2vde1a287d05ef4ad5@mail.gmail.com> 
	<7v39zscg68.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 08:47:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntyq8-0005gr-Mv
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 08:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab0CWHrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 03:47:47 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:42726 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0CWHrq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 03:47:46 -0400
Received: by ywh2 with SMTP id 2so2227847ywh.33
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=lTzOSo8ThY6z0eMrdjnD2StrAMlD0WKMP6uHgCO8v1A=;
        b=qf72Sr7XfiiS/q26azeYHHnTg4ZFfUYHKxCxXetzQpiOk1kx8JoD31osTgmNbDKHGQ
         RQlaUVQC5p9cDB+qJQOqecT92hxUNHOWK414uCriITkY407d4kqULZtU8E4ziOgzUwUZ
         xIPEi+tZN0cvFAAjfFNgHxamI6eW8ELh246fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hqWLTTOM46dxhdOOQDS8Bp4sKhXRnjFUlEieEqVCl8OE4B58Y8i78yS5GAYJ6UArMC
         kM9GsPqDE6+CnaL0Mmf6UWnzLRHGJa09AhgcDIToa4VgKD0PK+QjJNRhh0BlgrMEC5TU
         /f4m9zy9O/Uck+2Ys+mR8d0NHrO8tBo+bT2wQ=
Received: by 10.90.13.17 with SMTP id 17mr50534agm.113.1269330466102; Tue, 23 
	Mar 2010 00:47:46 -0700 (PDT)
In-Reply-To: <7v39zscg68.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142993>

Hi,

> I would suggest that you first talk about a bit higher level "purpose"
> (the four-bullet points above might be a good start) to clear the
> "remote-helper: why and what for?" question, before starting to describe
> "git comes with a "curl" family".

Thanks for the extremely detailed review! I've rewritten everything in
the latest revision. I think the part about avoiding linking/
licensing issues is important for the developer, and have included
that in the description.

-- Ram
