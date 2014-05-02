From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH] Detect endianness on more platforms that don't use
 BYTE_ORDER
Date: Fri, 2 May 2014 21:02:01 +0100
Message-ID: <20140502200201.GA30940@hashpling.org>
References: <20140502074917.GA25198@hashpling.org>
 <1399017329-25645-1-git-send-email-cbailey32@bloomberg.net>
 <xmqqwqe4azyd.fsf@gitster.dls.corp.google.com>
 <20140502165830.GA29339@hashpling.org>
 <xmqq7g64asae.fsf@gitster.dls.corp.google.com>
 <xmqq38gsarvf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 22:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJeu-0005FM-SP
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbaEBUCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:02:05 -0400
Received: from avasout06.plus.net ([212.159.14.18]:45875 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbaEBUCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 16:02:02 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id x81z1n00A2iA9hg01820WL; Fri, 02 May 2014 21:02:00 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=TcUYtHgh c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=8phGgmHQHDQA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=dYGvcnGeTc3sxRj19i0A:9
 a=CjuIK1q_8ugA:10 a=zVao0t87pJoA:10 a=BsQueKayftcA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1WgJej-00085y-9d; Fri, 02 May 2014 21:02:01 +0100
Content-Disposition: inline
In-Reply-To: <xmqq38gsarvf.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247965>

On Fri, May 02, 2014 at 12:43:32PM -0700, Junio C Hamano wrote:
> So,... I am inclined to queue this on top of your patch at least for
> now, before I go into incommunicado-mode to finish preparing -rc2.

Yes, I'd agree with that.
