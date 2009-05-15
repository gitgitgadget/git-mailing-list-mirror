From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git daemon request logging?
Date: Fri, 15 May 2009 22:56:07 +0200
Message-ID: <81b0412b0905151356t7bf613d5me39af08d37f72857@mail.gmail.com>
References: <4A0DC4E0.7020001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri May 15 22:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M54S2-00067T-Js
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 22:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbZEOU4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 16:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbZEOU4J
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 16:56:09 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:48952 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbZEOU4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 16:56:08 -0400
Received: by bwz22 with SMTP id 22so2133618bwz.37
        for <git@vger.kernel.org>; Fri, 15 May 2009 13:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r2IRf/eFJZANqHG/fxbD4QWHh+Ny/PO0zrtYADLYcLM=;
        b=gENfSZa+7AVJ5c5JDs51/3X+/ikHxC87yHVf+yD2zLS70+svHvxzYiHBLNdx05e6x2
         V+hZiqQnoGEX8+U5a6e4c5FssUxRSEq5CzVuXOFLgqgDrhGN3bsQ3oxHf5OOCVBABSkD
         xzpRRRuWGK8mt9C2CVO5QHN60A6CMq3YEzJx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hW09EgeL6bDn6Wbz0QVa3nR3Kd4ohU5HJ0NlnBz5F4JQEDxSA/M9y8UIxTafYtou0k
         Sylys75Zd6GCLK0HYB1oik+dRbbCBp9USVdN1RcHIpE0tgLEaUkw8bcJIJzw8T+6x8Gl
         SxOniErcjbBavpR1T5oIWXxuPqX+atAdChDRg=
Received: by 10.204.60.148 with SMTP id p20mr3676398bkh.165.1242420967920; 
	Fri, 15 May 2009 13:56:07 -0700 (PDT)
In-Reply-To: <4A0DC4E0.7020001@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119295>

2009/5/15 Jeff Garzik <jeff@garzik.org>:
> Does the git daemon do any sort of request logging? =C2=A0Could it?
>
> I was thinking it would be nice to see the amount of pulls/clones for=
 each
> git.kernel.org repository.

Does this count?

May 15 22:54:47 tigra git[28923]: connect from 192.168.0.8 (192.168.0.8=
)
May 15 22:54:47 tigra git-daemon[28924]: Connection from 192.168.0.8:40=
845
May 15 22:54:47 tigra git-daemon[28924]: Extended attributes (11
bytes) exist <host=3Dgate>
May 15 22:54:47 tigra git-daemon[28924]: Request upload-pack for '~raa/=
src/git'

fetch(pull)/clone are the same for daemon.
