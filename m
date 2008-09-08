From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [ANNOUNCE] Guilt v0.31
Date: Mon, 8 Sep 2008 20:33:23 +0200
Message-ID: <36ca99e90809081133s58e3d32h8b85804f5bb76902@mail.gmail.com>
References: <20080908135244.GB27550@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	guilt@lists.josefsipek.net, "Brandon Philips" <brandon@ifup.org>
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KclZJ-0002TV-1F
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYIHSd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 14:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbYIHSdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:33:25 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:64794 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYIHSdY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:33:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so284911and.103
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LIuP761xi6lPqmr6W6NYwmb2GxazeYcqzgpUIWyqU6A=;
        b=fFutvu3+eZpRm6Z7NE1l+s61b3gCfuhYZjV3gh8LF4s/ra/36An9xAEpCp7btFTe57
         SPkvxQf5VRcHN7Ynfr7hM1WU9rgoaVEmlpZ+JwhaSsehUnFGIBoW397cbED9cyex1ZPt
         9pzcR2efZ0OSgViYMyN8Rv3j6zCMDEl2fTWv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XWuZ4DtTHQRSYFguf8Dn6t1WHSpfpQSenBkhKk6jy25Y8l3TT4uhGhgGv4jajjYpow
         Pa2TDzEIJqnCVn3mA1YtyPpCEw/kJ+kfRrY1h8BBzms20lXd4RmObO4BJLVlpiV7zx7t
         IUGN9FhTOOoeMaXB23H93hMXUS+6a2n7qzHEE=
Received: by 10.100.120.6 with SMTP id s6mr15985925anc.106.1220898803478;
        Mon, 08 Sep 2008 11:33:23 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 8 Sep 2008 11:33:23 -0700 (PDT)
In-Reply-To: <20080908135244.GB27550@josefsipek.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95286>

Hi,

On Mon, Sep 8, 2008 at 15:52, Josef 'Jeff' Sipek <jeffpc@josefsipek.net> wrote:
> Guilt v0.31 is available for download.

Is it possible to include pre-generated docs in the tarballs?

I downloaded one and run 'make doc' and get these messages:

fatal: Not a git repository

which looks like it comes from this line in Documentation/Makefile:

VERSION=$(shell git describe)

Its not critical, but looks awkward.

Thanks

Bert
