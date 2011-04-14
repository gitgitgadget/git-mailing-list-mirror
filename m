From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] Allow git mv FILENAME Filename when core.ignorecase = true
Date: Wed, 13 Apr 2011 22:39:26 -0700
Message-ID: <1B0C04AB-0710-43A9-8046-C08593752BDE@gmail.com>
References: <201104100750.29950.tboegi@web.de>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 14 07:39:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAFHF-0005Rc-JH
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 07:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab1DNFjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 01:39:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48759 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab1DNFjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 01:39:31 -0400
Received: by iwn34 with SMTP id 34so1159626iwn.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 22:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=RokMpRM79exUKGROmnG0SSZTchCqSyOPMaiCyCPqdQE=;
        b=Uraki7a+I3zhLOyFsh6MGPzpa4h8kUoYmAVfBg8029zJP2uN/rZ2+BqJDppAxSCD4R
         AmjRm6F0gvfT1SZvHQ0l12C8/VlEXrF0bowE4wO8I6h9QOnG0VITUskCmzMTYWfoKByb
         TEFwz/uTtBrZI8KjFk+bkBVc4gRVpEfAvpYg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=pTz+Klvg/yIfHZUgk00iZ+hgk81Pl37coDey6irjheopOY9YWUUAgjm7k3xKYJ8YPJ
         8pxl8JhTkbEQGsqjnk2sDj10ARXN5T4P01n0gsnmckm6ZxbWQY6/qea34W4hPT5dY2zA
         TjZFsFA88e6Yj84xP55lsUk0gucmOIufugVAk=
Received: by 10.42.18.72 with SMTP id w8mr501607ica.352.1302759570408;
        Wed, 13 Apr 2011 22:39:30 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id t1sm937043ibm.38.2011.04.13.22.39.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 22:39:28 -0700 (PDT)
In-Reply-To: <201104100750.29950.tboegi@web.de>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171505>

On Apr 9, 2011, at 10:50 PM, Torsten B=F6gershausen wrote:

> The following discussion assumes, that we are on a
> "case ignoring" file system, and core.ignorecase =3D true.

Both commas should be removed.

Josh
