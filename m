From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport: skip commits that are too recent
Date: Mon, 8 Jan 2007 21:24:43 +1300
Message-ID: <46a038f90701080024p6629b1a6t227cd1992ad1418@mail.gmail.com>
References: <11682386193246-git-send-email-martin@catalyst.net.nz>
	 <46a038f90701072317h9bede00o939d4c078ccd569c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 08 09:24:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3poH-0006T5-BG
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 09:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbXAHIYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 03:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbXAHIYq
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 03:24:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:10030 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161190AbXAHIYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 03:24:45 -0500
Received: by wr-out-0506.google.com with SMTP id i28so7659wra
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 00:24:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RYK7BE2EAwHKY3ucpS+FiKNtWy3Sr59iacnW0MZjm/lfsAeow1rkzwnmUqCNaI+7ppaG1OMZaPf5F8/OOCkrMf49n/UPBRlR3IxnR2tET35kJHlgUz2DFEtdKdle3qTV7Ma0rxdHBMvHH2EuMfQ6BIPUNR3Mr2FKjkueRHZ5xVo=
Received: by 10.90.93.6 with SMTP id q6mr2045248agb.1168244685456;
        Mon, 08 Jan 2007 00:24:45 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Mon, 8 Jan 2007 00:24:43 -0800 (PST)
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <46a038f90701072317h9bede00o939d4c078ccd569c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36241>

On 1/8/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> In any case -- this should be a bit of a warning. cvsps is not
> particularly reliable (not that cvs data ever is!), and passing -o '
> -x' may help.

Correction:  it is -p ' -x ' that you need to pass. Things _are_ saner
here with it. YMMV.

cheers,


martin
