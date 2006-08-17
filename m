From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 13:22:15 -0400
Message-ID: <9e4733910608171022w25886d13ka40e5752fec4680b@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <20060817040719.GC18500@spearce.org>
	 <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
	 <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0608171220260.11359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 19:22:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDlZU-0008B1-K3
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 19:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWHQRWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 13:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWHQRWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 13:22:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:3926 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030186AbWHQRWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 13:22:15 -0400
Received: by nz-out-0102.google.com with SMTP id n1so390334nzf
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 10:22:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a3Cn67m/qB/8ugnw4g7WWtvjHeFQDID+GZW7J9w8ycrGIIsKUXQLd34SA+j2t+qVad1ZOG5l20pT3wERba1djBG7fTjs7/EbVzmCa3oXtJN/4hJQ0i2PZ+SBZ45iMpu3a8MqxsLTir3ZqTRPhBfnDe9pxAc4s81+mdQWH6QieZ0=
Received: by 10.65.251.1 with SMTP id d1mr2510267qbs;
        Thu, 17 Aug 2006 10:22:15 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Thu, 17 Aug 2006 10:22:15 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608171220260.11359@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25595>

On 8/17/06, Nicolas Pitre <nico@cam.org> wrote:
> Nah.  The only overhead for a server to feed an "old" pack format from a
> "new" pack file is to inflate and deflate some data.  That is not _that_
> costly.

It is costly because the Mozilla pack is going to inflate from 295MB
to 845MB. It will take you much longer to download an extra 500MB than
upgrading your client would take.

-- 
Jon Smirl
jonsmirl@gmail.com
