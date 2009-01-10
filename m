From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline
	'Subject:' header
Date: Sat, 10 Jan 2009 13:12:40 +0300
Organization: St.Petersburg State University
Message-ID: <20090110101240.GA9048@roro3.zxlink>
References: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090108100813.GA15640@myhost> <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <7vy6xm42l3.fsf@gitster.siamese.dyndns.org> <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <20090108231135.GB4185@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 11:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLapr-0006kQ-Qt
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbZAJKL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 05:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZAJKL2
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:11:28 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:4596 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbZAJKL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 05:11:27 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 8CC6B17B65D; Sat, 10 Jan 2009 13:11:25 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LLapc-0003en-Pi; Sat, 10 Jan 2009 13:12:40 +0300
Content-Disposition: inline
In-Reply-To: <20090108231135.GB4185@roro3>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105082>

On Fri, Jan 09, 2009 at 02:11:35AM +0300, Kirill Smelkov wrote:
> Changes since v1:
> 
>  o incorporated Junio's description and code about padding
>  o incorporated Junio's description and code about LWS between encoded
>    words
>  o incorporated tests from RFC2047 examples  (one testresult is unclear
>    -- see patch description)
> 
> 
> From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> Subject: mailinfo: correctly handle multiline 'Subject:' header

[...]

Junio, All, just in case this again got spam-detected:

http://marc.info/?l=git&m=123145624611936&w=2


Thanks,
Kirill
