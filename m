From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] A simple python script to parse the results from the testcases
Date: Mon, 12 May 2008 15:05:42 +0200
Message-ID: <bd6139dc0805120605ka869f58xd3c6915f2a4e5bed@mail.gmail.com>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
	 <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
	 <m3hcd34ynv.fsf@localhost.localdomain>
	 <bd6139dc0805120316oe704c8ek149d37552d72ab30@mail.gmail.com>
	 <alpine.DEB.1.00.0805121400200.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	dsymonds@gmail.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 12 15:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvXjd-0000iz-Bf
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 15:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbYELNFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 09:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbYELNFo
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 09:05:44 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:13697 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbYELNFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 09:05:43 -0400
Received: by py-out-1112.google.com with SMTP id u52so2455379pyb.10
        for <git@vger.kernel.org>; Mon, 12 May 2008 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=HRRXgztlcI4gIUmHyFYXvDI9kSh+UMHqlghYsdyR77A=;
        b=T57mA9S2wDnctuEeb9kCuml4+FBFMfez31UZoPa1+TJ3m7P4iZ44axwiM7HxPYHDmTz2DLKoDMNnlsCq/DA+DYGciMqSsSAtVBl8TngXTEF7fXTcwqPTmqEbOwYM2j67HQPOxVfdDljf+s1aSz2WhXAdVFc3aUWY6931w5zJIwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=reXUrBxTeRi/16mghmUEVP5znAFxag3Hi11PlQOGbeOLa0S7cc8u06UTetyUpHvbZU9TqpSKA8PRwg5DTvb17kwVPUvDItkNIBf38Nk2jBCGqZcrtgf1j0iyUOIwcxjLgaM78NcRgDnmcHKTRFPeOd0EbiSqlto6uXxGr0pFAOM=
Received: by 10.143.36.15 with SMTP id o15mr3259261wfj.182.1210597542328;
        Mon, 12 May 2008 06:05:42 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 12 May 2008 06:05:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805121400200.30431@racer>
Content-Disposition: inline
X-Google-Sender-Auth: d57a22434af30f34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81860>

On Mon, May 12, 2008 at 3:00 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  Umm.  Perl cannot be so difficult as to reintroduce the dependency.
>  Remember: msysGit comes _without_ Python.

Agreed, as said in the commit message, it  "serves more as a
demonstration on how to use the testcase output".

-- 
Cheers,

Sverre Rabbelier
