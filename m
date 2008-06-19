From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Best practice question
Date: Thu, 19 Jun 2008 17:40:10 +0200
Message-ID: <8aa486160806190840m697ac1en3214626a56014be1@mail.gmail.com>
References: <485A6E03.6090509@et.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: stuart.freeman@et.gatech.edu
X-From: git-owner@vger.kernel.org Thu Jun 19 17:41:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9MG5-0003bu-7X
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 17:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbYFSPkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYFSPkM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 11:40:12 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:36358 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYFSPkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 11:40:11 -0400
Received: by rn-out-0910.google.com with SMTP id k40so39793rnd.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gXNoyiD7gSIqpg0fioia8Bw4Q9DonY9rXMp8ZXryd/w=;
        b=NN0sAGn7HMn5sHpatCKnopiatv3s5ZTUFMNguIBu9BfNImnzc63aW8BpgsaRgir9iU
         oKBXLz6SM7mOT8ETfPj53Kp+D0c3lZ2M3F9Ml0BX7kWmIj8H/m2xMzYRM5gknQdhTMZ+
         /WbbOV0Y+wLnD8CPX8so28rMV6mPYVd7Ce4yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=W4iOCviMt5YZtgBqgvf3tFwpROhz6nHKVF8bpZZsAHhon+zdvWkx6l+ZxWzCwqo4AQ
         3jw7yJZM196byFuE5k21FpYzHb+k7vH2P/xfBbRDAaasMNBRiZvbh9RjO+6/K2XHz1S7
         ZDh9y7A+O75mr1GRW0hpQxy2XoLwruajw7eVI=
Received: by 10.151.157.1 with SMTP id j1mr3321258ybo.173.1213890010102;
        Thu, 19 Jun 2008 08:40:10 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Thu, 19 Jun 2008 08:40:10 -0700 (PDT)
In-Reply-To: <485A6E03.6090509@et.gatech.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85483>

On Thu, Jun 19, 2008 at 16:32, D. Stuart Freeman
<stuart.freeman@et.gatech.edu> wrote:
> My project has an "about" page that lists the version.  I understand why
> git doesn't do keyword expansion, but I'm wondering if there's a
> recommended best practice for keeping that up to date.

You can look at how git does it:
It generates a GIT-VERSION-FILE with:

http://git.kernel.org/?p=git/git.git;a=blob;f=GIT-VERSION-GEN;hb=HEAD

and reads it in the Makefile. Or you could generate a version.h file.

Santi
