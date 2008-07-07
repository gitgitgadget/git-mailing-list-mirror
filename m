From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 14:29:30 -0400
Message-ID: <32541b130807071129m218059eaw8837681c0d705cd@mail.gmail.com>
References: <20080701150119.GE5852@joyeux>
	 <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
	 <20080706160758.GA23385@jhaampe.org>
	 <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
	 <20080707062142.GA5506@jhaampe.org>
	 <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807071533240.18205@racer>
	 <alpine.DEB.1.00.0807071537070.18205@racer>
	 <20080707145726.GI3696@joyeux>
	 <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sylvain Joyeux" <sylvain.joyeux@dfki.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Lars Hjemli" <hjemli@gmail.com>, "Ping Yin" <pkufranky@gmail.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 20:30:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFvTp-0003RC-NF
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 20:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbYGGS3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 14:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbYGGS3c
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 14:29:32 -0400
Received: from el-out-1112.google.com ([209.85.162.183]:3717 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbYGGS3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 14:29:31 -0400
Received: by el-out-1112.google.com with SMTP id z25so216306ele.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TlGiDIH+VmIy3k+6uCFCvB5sSPWAX/7vrrwx0oWvVms=;
        b=MouJ/zjFlmW3loq97De0rZJ2skbhrGmBMVRO5kKYge1uKKG3yU2uN8fn5fzEHEXiNX
         UY1wtES2tYCh8H16JRpNGifKFOIsUx2nk6wrRQQfi0M9Gv6Z7Iz36luP7EnAXa4Jsi7X
         MSafTcz3KxsV8n7Ir0vJgytqKMzXLat8fV8rY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pqwQh/LCbdPIZ091OmrCPrujCIEQKvyyFk3xcL7+bKnmrWjDWa3pEFyymdF/e3PaQ9
         lPKJYZupKPfTDp/xEvFI2+iOK0QGnGQU8VIHRaYHL5rvshuI49R1Rws4zlWBHtQIhSk0
         q3b0H3tqreK/Mjnf/vYONrlHLH7MrdeJkdQBU=
Received: by 10.150.54.6 with SMTP id c6mr1685173yba.207.1215455370537;
        Mon, 07 Jul 2008 11:29:30 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Mon, 7 Jul 2008 11:29:30 -0700 (PDT)
In-Reply-To: <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87640>

On 7/7/08, Junio C Hamano <gitster@pobox.com> wrote:
> Sylvain Joyeux <sylvain.joyeux@dfki.de> writes:
>  > Is it possible to make 'fetch' only .. well .. fetch objects, without
>  > updating any refs?
>
> Not very easily, and that is very deliberate.  The objects fetched will
>  become dangling if you allowed such a mode of operation, and will
>  immediately become subject to gc.

Is this really desirable?  I could imagine dropping an entry (or
several entries, or whatever) into the reflog after each fetch, to
prevent such fetched objects from being deleted right away.

Avery
