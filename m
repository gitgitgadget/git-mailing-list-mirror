From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
	index)
Date: Wed, 8 Apr 2009 23:32:03 +0200
Message-ID: <fabb9a1e0904081432x57b6811bubb6a40237710a3d6@mail.gmail.com>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de> 
	<61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 23:34:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrfPV-0008BZ-5p
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 23:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761544AbZDHVcV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 17:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758917AbZDHVcV
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 17:32:21 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59332 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758373AbZDHVcU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 17:32:20 -0400
Received: by fxm2 with SMTP id 2so327874fxm.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EDWiLJWF330+LHW+qlCNVG/6lXeQCQTltXbOBt8aqX0=;
        b=vsdlmufLWUr8d/R5GS0XA00NT+8nI1UgispjHLfgBTxCaWNy+CNrKgPJJxJp7yYJIR
         +hZUY8OWxE8UdZ670ljnUJ4GYYlBoxCc0WVUneSvWfJmidKxCRAoN5hMAmMt9frX+GhN
         gcsJbyQcNvkmvqslWndjh5dNOyw6Q0i91/B0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=O/GfO5PHD7c5tE+jgUAD4jRLisKMt82aHzbNx0BFmV+mi3+D0Fi0IjhhcOpwhtVe80
         jzmv0z9GZGxf3mVGVGqvjZiRbtykQz3rT/P7qaSbXy8Ed3KPb/pEWi7LctbRKW74PrTI
         I6ZvDUV4nGPfG1gS8hQpfAhSHSb6RI2mNbmvI=
Received: by 10.103.213.19 with SMTP id p19mr837986muq.9.1239226338282; Wed, 
	08 Apr 2009 14:32:18 -0700 (PDT)
In-Reply-To: <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116125>

Heya,

On Wed, Apr 8, 2009 at 23:30, Johannes Schindelin <johannes.schindelin@=
gmx.de> >
> =A0 =A0 =A0 =A0I actually promised myself not to resend this patch, b=
ut a
> =A0 =A0 =A0 =A0certain guy who has a hat now asked for it.

Whoever it may be that asked you for it, I am glad they did! It's
really nice to help massage a patch series into shape. I'm a big fan
of 'git add -p', this would seem like the logical compliment to it imo
:).

--=20
Cheers,

Sverre Rabbelier
