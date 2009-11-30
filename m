From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git include
Date: Mon, 30 Nov 2009 13:45:57 +0700
Message-ID: <fcaeb9bf0911292245t6b18c238s2859d2cbd5dd26be@mail.gmail.com>
References: <4B136932.9000908@gulfsat.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Rakotomandimby Mihamina <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Mon Nov 30 07:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF01f-00073Z-1e
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbZK3GqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbZK3GqM
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:46:12 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:33247 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbZK3GqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 01:46:11 -0500
Received: by pwi3 with SMTP id 3so1995109pwi.21
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 22:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=i31J3BTDk+NhFDm2Ar6NqeapKgneqgCrF2c+omJ5WM8=;
        b=mFh6LEmDiWgpyPI95R0V0doKx7/F6z+aIUG//7k8BMtpnwkxnJ21tzAbktXtgjEEIE
         vebgveV4+q5xmc4hXgUxxrzI2l6xJzuNtu5ZOKAPBO+hR0TvWo5nGZPjQgU3IydKmhrq
         6UeCqkesArVM0xx00okM0WKkgLU5RXdMwZ0bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fzT35/agIKi9Hmclmo+KZaRu4ua4KvVYt+QB5KMyTaH2ywCAc7ZKfapFDbEEVGlGjA
         pU+3Jw0ADNhntXmkwdOSHOfjPEiqjJrUKpSFyTw/5yQ51qstaqV6XuPi1FyATtoTnLpZ
         uQKxLIMCLxUVMZyiXuzYt4bBo+18pPe1LCOJM=
Received: by 10.115.133.38 with SMTP id k38mr6642598wan.120.1259563577274; 
	Sun, 29 Nov 2009 22:46:17 -0800 (PST)
In-Reply-To: <4B136932.9000908@gulfsat.mg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134058>

On Mon, Nov 30, 2009 at 1:41 PM, Rakotomandimby Mihamina
<mihamina@gulfsat.mg> wrote:
> Hi all,
>
> I would like to track only *.ml files and ignore all others.
> Is there a way to do that in .gitignore?

This .gitignore should work (of course for new files only):
-->8--
*
!*.ml
-->8--
-- 
Duy
