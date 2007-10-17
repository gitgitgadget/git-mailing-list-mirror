From: "Richard Quirk" <richard.quirk@gmail.com>
Subject: Re: git-cherry-pick no longer detecting moved files in 1.5.3.4
Date: Wed, 17 Oct 2007 09:55:13 +0200
Message-ID: <cac9e4380710170055t3853979by9d12a9a2f989f9b9@mail.gmail.com>
References: <cac9e4380710161517m64ba737dj8711a6ce59b1b69@mail.gmail.com>
	 <200710170035.12482.barra_cuda@katamail.com>
	 <cac9e4380710170018p26ae8935xc4d3218f4db5411d@mail.gmail.com>
	 <20071017073357.GA13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3ka-0003gY-Gr
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbXJQHzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbXJQHzQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:55:16 -0400
Received: from ag-out-0708.google.com ([72.14.246.250]:31955 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbXJQHzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:55:14 -0400
Received: by ag-out-0708.google.com with SMTP id 35so1653176aga
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RMkhiInWeiI/veR91hgR97ksyTxOu53l9kAA6tyfOx0=;
        b=U/biWfBxZZPP71YUaFEqciaYE3S5+JSEpakY3DRPXg/UkXOP+hv8XVkiYaKTfm2p5NUQT6NCIrBOB/7ldorqeXSjfX5qU+2RW72tMN27B7Xw/x5XB+XAfBypNvWd8p8sqaqC92cywN+2qOohANLebQFKeImfm8dJYbVPoqaMh1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lbwbyVlKUU3MUrGowKJ7HKZXHPxeVpLDnQgwpXCE00CYCUpcd80IyBWymoAp07u4e6UaC6rB1Ee8BdI82/atZGazdpPxQz83S6/imFmuvl5d9fE1ZorFowLfgcdElh5RjOSlqMxP1m8jseTthReyDkNvoXjAJ5Kc73tSclQ5bL4=
Received: by 10.70.19.20 with SMTP id 20mr14597034wxs.1192607713406;
        Wed, 17 Oct 2007 00:55:13 -0700 (PDT)
Received: by 10.70.63.20 with HTTP; Wed, 17 Oct 2007 00:55:13 -0700 (PDT)
In-Reply-To: <20071017073357.GA13801@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61350>

On 10/17/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> That's an "old" bug.  Lars Hjemli fixed this in df3a02f612 back on
> Sept 25th.  You can get the fix from either Junio's or my git tree
> in the master branch.

Yes, with that fix setting the diff.renamelimit config value to 0
really does work. Thanks!
