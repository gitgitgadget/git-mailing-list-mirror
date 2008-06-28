From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Revert "git-svn: Speed up fetch"
Date: Sat, 28 Jun 2008 19:58:45 -0400
Message-ID: <32541b130806281658v512c1afco9de32428db6cbae7@mail.gmail.com>
References: <20080628194808.GA29908@atjola.homenet>
	 <1214686673-28099-1-git-send-email-apenwarr@gmail.com>
	 <237967ef0806281651p3abf6ae4j9169cdc5bbf8f85d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Adam Roben" <aroben@apple.com>,
	"Samuel Bronson" <naesten@gmail.com>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 01:59:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCkKV-0007Km-DA
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 01:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbYF1X6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 19:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbYF1X6r
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 19:58:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:26440 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYF1X6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 19:58:47 -0400
Received: by fk-out-0910.google.com with SMTP id 18so948132fkq.5
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OF2GzyHnw1F72I/MLx0Z5/OHMYcFYyhOIgJXF+vw77Y=;
        b=jLZFKVOfNyiYagl3Y7LCwfpHcqAQu5harqTTRLbOpKN5kI8XQVtYEb58NW05Vhi5Ik
         XVM5K8Ki52Gb+SwDWBSgtWZaqpOE0xlKp5U2uH8pQog3yp0GYoaCus20+44TH7VI56pZ
         XEYskL8Vh+9D5BFK/p37tnVXWpD8z5ZwS6xOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rzqVzaLs11yDm/IAr3185RNm558/2Q4FX+I/rPUC4QZIRqjRgT6qkb+dP4pMmTdlxR
         LC83qgA3viSig7k1khhH0wKT+Yp8ozba6H5GxCKbH7SYWgdi0cC1GQreplihu1//92bZ
         J8T8orVIlOvt74UqG/m0/pJP/F+COIZoHdCq0=
Received: by 10.82.106.14 with SMTP id e14mr126130buc.78.1214697525250;
        Sat, 28 Jun 2008 16:58:45 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Sat, 28 Jun 2008 16:58:45 -0700 (PDT)
In-Reply-To: <237967ef0806281651p3abf6ae4j9169cdc5bbf8f85d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86750>

On 6/28/08, Mikael Magnusson <mikachu@gmail.com> wrote:
> Wasn't this the problem that was fixed by
>  d683a0e00cd4734b4fab704baef1ee76205722be?
>
>  commit d683a0e00cd4734b4fab704baef1ee76205722be
>  Author: Junio C Hamano <gitster@pobox.com>
>  Date:   Tue May 27 23:33:22 2008 -0700
>
>     Git::cat_blob: allow using an empty blob to fix git-svn breakage
> [...]

No, I have that patch and the problem still occurred.

Avery
