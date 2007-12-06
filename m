From: "Adam Mercer" <ramercer@gmail.com>
Subject: XML parsing error from gitweb at freedesktop.org
Date: Thu, 6 Dec 2007 16:34:55 -0500
Message-ID: <799406d60712061334q33d2dba5r5496ba21069a4547@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 22:35:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ONO-0007ML-MT
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 22:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbXLFVe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 16:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbXLFVe6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 16:34:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:60945 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbXLFVe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 16:34:57 -0500
Received: by nz-out-0506.google.com with SMTP id s18so227715nze
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 13:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=pGqNndOPCCJnIlP8yd+XdTWNEcajlCFfd+F8ESx24+0=;
        b=awj+e3rEZgDH2NP+NeekPLTx6Z0T278zDoA2X8+uZRMIGFeUt7/JGlpIUDZse5XpeFklbpPqy+km+Ct5S4NZdIrxNanWB0g1n/kDJofqxcp522ET2OZyESdMm6YhaIu+2AhZbSYSlWiN5zRcwdmChshk27TMH+e3VFdkq3VrOs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fsMCFmem28UVcjw4qIRtQrQXboFsIqeYFrNR1WqAAgs3jjNRoplLkdQlciP2f/i4wBC88vDmQvdTbxTApFN+fhH1LC20Alh5fx5OklDGj+yArIi878a/vGU6kZaXhasIElOc4SZVlQqIzRrULNbZrBvwmwqSMumKb+5ygNCUI+A=
Received: by 10.142.222.21 with SMTP id u21mr1968023wfg.1196976895289;
        Thu, 06 Dec 2007 13:34:55 -0800 (PST)
Received: by 10.142.86.21 with HTTP; Thu, 6 Dec 2007 13:34:55 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67339>

Hi

In looking through some commits on the freedesktop.org gitweb I
encountered an error trying to view the following commit

<http://gitweb.freedesktop.org/?p=xorg/xserver.git;a=commitdiff;h=48e6a75fbdd0fee86e364f02ace83f20b312a2b2>

In viewing the page under Safari on Mac OS X Leopard the following
error is displayed:

This page contains the following errors:
error on line 7998 at column 129634: internal error

Camino & Firefox both display:

XML Parsing Error: not well-formed
Location: http://gitweb.freedesktop.org/?p=xorg/xserver.git;a=commitdiff;h=48e6a75fbdd0fee86e364f02ace83f20b312a2b2
Line Number 7998, Column 24:

<div class="diff rem">- </div>
-----------------------^

as cgit displays the commit OK

<http://cgit.freedesktop.org/xorg/xserver/commit/?h=xorg-server-1.2-apple&id=48e6a75fbdd0fee86e364f02ace83f20b312a2b2>

leads me to think that the problem lies in gitweb.  Could this be a
problem with gitweb?

Cheers

Adam
