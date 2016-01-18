From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Mon, 18 Jan 2016 14:35:24 +0100
Message-ID: <569CEA1C.90700@drmicha.warpmail.net>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 14:35:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL9y2-0002if-0H
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 14:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbcARNfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 08:35:31 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53839 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755279AbcARNf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2016 08:35:28 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 5FB4D20AB2
	for <git@vger.kernel.org>; Mon, 18 Jan 2016 08:35:27 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 18 Jan 2016 08:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=N0XOwxnfvtRsuocuKSXgAwIlGjQ=; b=HJB0gO
	ZkTEh7+ajaNYSsmjwXefhOpShJs3hThD64JypIU2oLn4XCe7ck1BFMQ3u9f+ul9Y
	jf/SGH2stM14yPUnVE+c84sVtqVPCB85U3/puJGmqci9p5hJrPgmME7VAFSMmRRu
	At5koLWGgtWqnxvxgiNJf6LtzUrcbFv8qi2X0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=N0XOwxnfvtRsuoc
	uKSXgAwIlGjQ=; b=IIW1GHn9I3+TMtTsLNJXtQFKlv9SxZsbBM/09y5bbUrAgBe
	vRdr75LXcjJ5kRWnP2YzzjghB46KQQ3CzAcVMfJ25gQY4dB8KqQANiuElPYWbPlj
	1vZGDpDbwwndhAWyyR0ZIitdYkpHndKOLMaWyc/UiuFkTFYJaHuMdbfwhIOU=
X-Sasl-enc: 0wxPYyhypWtMFvoxZTK1OMNwr2Zf/6h/Iq3rCPqkRKFc 1453124127
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id E3279C013FE;
	Mon, 18 Jan 2016 08:35:26 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284292>

Junio C Hamano venit, vidit, dixit 12.01.2016 00:45:

> 
> * mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
>  - t/lib-git-svn: check same httpd module dirs as lib-httpd
>  - t/lib-httpd: load mod_unixd
> 
>  This is the first two commits in a three-patch series $gmane/266962
> 
>  Becoming tired of waiting for a reroll.
>  with updated log message ($gmane/268061).
>  Will discard.

Oh, sorry. Work killing me plus I was waiting for help, too.

I don't care for these tests myself. I just noticed we're not really
running them (resp. are running them locally only) due to the noted
problems, i.e. default configs in which we fail to start the server.

Michael
