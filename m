From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Rebase & Trailing Whitespace
Date: Thu, 1 Sep 2011 22:00:38 +0100
Organization: OPDS
Message-ID: <29267EE41F9343E68AAAE2C33AA40E1A@PhilipOakley>
References: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com> <20110901023127.GB31838@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Users" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>,
	"Hilco Wijbenga" <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 23:00:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzEMj-0002Gq-9K
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 23:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab1IAU7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 16:59:54 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:19882 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757887Ab1IAU7x (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 16:59:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFABHxX05cGnLt/2dsb2JhbAAoGoRNhUyeNniBOwUBAQQBCAEBGRUeAQEhBQYCAwUCAQMOBwUCBSECAhQBBBoGBxcGARIIAgECAwGHYQICI6gikXCBLIQeMWAEpDA
X-IronPort-AV: E=Sophos;i="4.68,315,1312153200"; 
   d="scan'208";a="7799074"
Received: from host-92-26-114-237.as13285.net (HELO PhilipOakley) ([92.26.114.237])
  by out1.ip07ir2.opaltelecom.net with SMTP; 01 Sep 2011 21:59:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180571>

From: "Jeff King" <peff@peff.net>
> On Wed, Aug 31, 2011 at 04:55:03PM -0700, Hilco Wijbenga wrote:

> problems that still exist in your current tree, you can diff against the
> empty tree with --check, like:
>
>  git diff --check 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>
> where "4b825dc..." is the well-known sha1 of an empty tree[1].
>

> [1] If you don't remember the empty tree sha1, you can always derive it
>    with:
>
>        git hash-object -t tree /dev/null
>

I've added this tip to the https://git.wiki.kernel.org/index.php/Aliases 
page

Philip 
