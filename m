From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Tests in Cygwin
Date: Fri, 08 May 2009 16:28:38 +0200
Message-ID: <4A044196.7050106@viscovery.net>
References: <83prfbhasp.fsf@kalahari.s2.org>	 <4A01E64C.7050703@SierraAtlantic.com>	 <7vvdoet13g.fsf@alter.siamese.dyndns.org>	 <4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com>	 <20090508020037.GA1264@coredump.intra.peff.net>	 <4A03CAFE.4060503@viscovery.net>	 <7v4ovwaygf.fsf@alter.siamese.dyndns.org> <81b0412b0905080228j6b114631p35395464c0c98540@mail.gmail.com> <4A043F7E.5070702@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Hannu Koivisto <azure@iki.fi>,
	git@vger.kernel.org
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Fri May 08 16:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2R4D-0007gU-R7
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 16:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbZEHO2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 10:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbZEHO2l
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 10:28:41 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13453 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbZEHO2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 10:28:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M2R40-0007fD-RC; Fri, 08 May 2009 16:28:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2206A4E4; Fri,  8 May 2009 16:28:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A043F7E.5070702@SierraAtlantic.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118606>

Don Slutz schrieb:
> So which should we go with? foo2() which does the original way or foof()
> which allows you to use ',' and '+', and spaces?

I'd say take Junio's original proposal (that separates with spaces), but use

     for prerequisite in $*      # split args at spaces

(including the comment!) instead of merely

     for prerequisite

I can certainly live with the quoting at the call sites of
test_expect_success that is needed in the few cases where there is more
than one prerequisite.

-- Hannes
