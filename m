From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] xdiff/xprepare: improve O(n*m) performance in xdl_cleanup_records()
Date: Sun, 21 Aug 2011 11:24:35 +0200
Message-ID: <4E50CED3.10704@kdbg.org>
References: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>	<1313546037-4104-1-git-send-email-rctay89@gmail.com>	<20110817052147.GA11253@sigill.intra.peff.net>	<CALUzUxovdmhnRKPaEq01-q0pvez91s_Z_rHWg-FkwcU0VD3HQQ@mail.gmail.com>	<20110818224427.GB8481@sigill.intra.peff.net> <CALUzUxoPwNhziRX3WU-YhSEXkjm_FvVLmN=pAffexr-QpmhGgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 11:24:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv4Gr-0006MG-6C
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 11:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726Ab1HUJYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 05:24:39 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:27390 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752174Ab1HUJYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 05:24:38 -0400
Received: from [178.112.189.57] (178.112.189.57.wireless.dyn.drei.com [178.112.189.57])
	by bsmtp.bon.at (Postfix) with ESMTP id 39B412C4003;
	Sun, 21 Aug 2011 11:24:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <CALUzUxoPwNhziRX3WU-YhSEXkjm_FvVLmN=pAffexr-QpmhGgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179798>

Am 19.08.2011 19:12, schrieb Tay Ray Chuan:
>> Is msysgit's bash "time" just broken?

I think it is broken. The only thing I would use it is to record elapsed 
time (the 'real' part).

-- Hannes
