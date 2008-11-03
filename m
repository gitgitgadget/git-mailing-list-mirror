From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: Fetch via http and proxy which requires authentication
Date: Mon, 3 Nov 2008 19:32:14 +0530
Message-ID: <c94f8e120811030602p57007278p5a2c48ce7663282d@mail.gmail.com>
References: <4d8e3fd30808272300g58d92dd8pd877d72805bc29c0@mail.gmail.com>
	 <4d8e3fd30808280313i70f572cfh9c14fbc2adbf5cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 15:03:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx01l-0002xj-1n
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 15:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbYKCOCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 09:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbYKCOCT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 09:02:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:41129 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208AbYKCOCS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 09:02:18 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1716220ugf.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=q/1JEVadREZUiZVHHAfJpFX0aM3daja1yT2N93BqTPY=;
        b=iNLdkzdkf8tR+16eOd9Ens/fhYjnF3oLRpgFan9ZTIjmwjZnWIixmbA/SIqscuNUB4
         buRsbsElmunVHC4ySrKJehpTspkn9eQqNlLoJJcI0uNTNDgCviBWN/ZHAYxfPrsegQef
         B7TYOF1CybByB6Q0MlZyKFou6zQDucGu7ZpUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HhPgXv6JhVirCtzoj3vM5+7JWU2Y7uw3aJWssiXyHURmPo6qScrYSv1jkUZtxlG28K
         nzE0qwTtq29Vh5Odae4F4p8GGIKkHpjPeIZTR/1QQqBRj3sBfrODw9byCwOAcIm2fEx9
         eCxJ+cnJjZvVLmiAoZtDbsOE79bhCwCBsB7YU=
Received: by 10.67.30.4 with SMTP id h4mr2043979ugj.11.1225720934716;
        Mon, 03 Nov 2008 06:02:14 -0800 (PST)
Received: by 10.66.220.11 with HTTP; Mon, 3 Nov 2008 06:02:14 -0800 (PST)
In-Reply-To: <4d8e3fd30808280313i70f572cfh9c14fbc2adbf5cea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99945>

On Thu, Aug 28, 2008 at 3:43 PM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
>> Hi all,
>> i'm looking for a way to use git behind a corporate proxy which
>> requires authentication.
>> i just need to be able to fetch/pull via http.
>> i'm using git on a win xp box.
>> Any hint?
>
> Yes, google for  http_proxy ;-)
>
> export http_proxy=http://host:port
> git clone http://username:password@giturl

I tried setting, export http_proxy=http://<user>:<password>@host:port

But git clone failed!

$git clone http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git git
clone http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Initialized empty Git repository in /home/dilipm/bin/linux-2.6/.git/
fatal:
http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/info/refs
download error - The requested file was not found

What may the problem?  How can debug....


PS: wget works ...



-- 
Dilip
