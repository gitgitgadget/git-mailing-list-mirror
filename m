From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 14:20:23 +0000
Message-ID: <e1dab3980711120620l61d3e84ene094ea9235af5a15@mail.gmail.com>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	 <20071112131927.GA1701@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Bruno Cesar Ribas" <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Mon Nov 12 15:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ira9a-0005Uq-03
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbXKLOU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbXKLOU0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:20:26 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:26211 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbXKLOUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:20:25 -0500
Received: by py-out-1112.google.com with SMTP id u77so1245147pyb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MGUoZL6XNWw9WZ5dvLhY1GUqbxjEkJREDPoMJOJ+Aso=;
        b=ADU2wumkjGecH8Mz4OFCZrxm5zJluRevgT+0lnUBmyb3GmCKkGidNAGzToCCnNGcE89tnwqytWZ3ClOMd1lyhDFZmZBXZ3zW50mqInMWyJnVbaInj3pcdsno1jxutGn9RPotKDwysysNZmxzHDrJ9I0eNO9+aq9mDPseVTDOetE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p+PWii7zpxJDJl2jJNdSOeL4FZ39NCLrhnmsCsKwnpqLRn7L+z4LvW8o9ypP9tk1l2D/JrXKwmdmTmkqFC3+HSLcqFRN+HYzoVSOXFy7nEBYfF620VU628ODV8YzzAEg8spMR8Wxv+7xIPL1HA0mqvYaPwJ8BhI3rP+T+tO+xQQ=
Received: by 10.65.121.9 with SMTP id y9mr13845046qbm.1194877223493;
        Mon, 12 Nov 2007 06:20:23 -0800 (PST)
Received: by 10.64.181.10 with HTTP; Mon, 12 Nov 2007 06:20:23 -0800 (PST)
In-Reply-To: <20071112131927.GA1701@c3sl.ufpr.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64625>

On Nov 12, 2007 1:19 PM, Bruno Cesar Ribas <ribas@c3sl.ufpr.br> wrote:
> A bare repository is the way to publish your changes to the public.

Just to mention this: an incredibly minor use, but a bare repository
is also useful for "temporary storage" on a non-case-preserving
filesystem (particularly if you don't have the authority/capability to
change the filesystem for one that is case preserving).

[I have a USB stick that I also occasionally use on Windows so
couldn't reformat. My repo doesn't have files whose names differ only
by case, but does have files with capitals somewhere. Not caring
either way about having checked out files, I initially tried to put a
standard repo on the stick and it wouldn't fast-forward when I tried
to push an update to it because some files checked out files had
"vanished". Making it a bare repository avoided the issue problem.]

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
