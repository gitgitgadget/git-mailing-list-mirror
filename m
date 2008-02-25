From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Tue, 26 Feb 2008 08:59:43 +1300
Message-ID: <46a038f90802251159j591c16c2g1e5b5aa20e9edb00@mail.gmail.com>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org>
	 <200802071056.19370.robin.rosenberg.lists@dewire.com>
	 <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	 <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	 <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	 <20080225080739.GA13610@piper.oerlikon.madduck.net>
	 <18370.45020.940192.10482@cargo.ozlabs.ibm.com>
	 <30e4a070802250535g72b59106yb1e4478eb9b9f47a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"martin f krafft" <madduck@madduck.net>,
	"Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:00:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjVQ-0008QD-33
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbYBYT7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756236AbYBYT7q
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:59:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:59132 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbYBYT7p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:59:45 -0500
Received: by ug-out-1314.google.com with SMTP id z38so939970ugc.16
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 11:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=78TXa0s7Ll7zgxy8edzKQZe2wkYNczKUajOIhevO8VU=;
        b=iBBt0hodRWOZTv8nS3iX4v0mH/ryAIQpzjq9ysw8Hwt1OASHA2l0WXDqgxqf8FdqvBqSpvJIZvJ6zADRxijNiaihsZGeYZu2t+8IG2KQBUesqYsg0v3XPw4EbCilQiBAG6qvc45pCmwnmHYgt1tXOblnRfy3RC64kOrP9n4z/Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LkRPleWIUdIe26WkBgIg2f5XWrgzdSG5zTgxr5uf18nSMFJJ0UfcIl25qYCLrAHNnBAkHZjN5xsKIsrCOq0M9TXUUZGM6BwFCs5OF43zAWJ7qgg/um5nl5NEMVPR54ElqddJnh9sIE2/ccRqajIa/YOqKdIUFZlY4Kzk90s3/oo=
Received: by 10.67.123.19 with SMTP id a19mr3698881ugn.4.1203969583247;
        Mon, 25 Feb 2008 11:59:43 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Mon, 25 Feb 2008 11:59:43 -0800 (PST)
In-Reply-To: <30e4a070802250535g72b59106yb1e4478eb9b9f47a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75056>

On Tue, Feb 26, 2008 at 2:35 AM, Mark Levedahl <mlevedahl@gmail.com> wrote:
>  2) Perform a screen geometry check at load time to see if the corners
>  of the main window would be visible before applying the main window
>  geometry.

As a multi-screen-layouts, multi-machine user, this approach has my
vote. I see a proto-patch from Edgar too. Even if the wm has similar
capabilities, those will be limited to main window geometry, not
inner-panel geometry so this is still useful.

cheers,


m
