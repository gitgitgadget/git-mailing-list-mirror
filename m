From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
 characters
Date: Mon, 21 Jan 2008 11:21:35 +0100
Message-ID: <4794722F.7060401@users.sourceforge.net>
References: <20080117153252.GD2816@coredump.intra.peff.net> <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net> <47905F70.5090003@viscovery.net> <4790746D.1000502@users.sourceforge.net> <47907914.6000105@viscovery.net> <7v1w8fh2ef.fsf@gitster.siamese.dyndns.org> <20080118141638.GA14928@coredump.intra.peff.net> <7v8x2mdf7e.fsf@gitster.siamese.dyndns.org> <4793CCA2.4060407@users.sourceforge.net> <20080120225313.GA14762@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 21 11:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGuAz-0001Wk-KU
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 11:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572AbYAUKqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 05:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758879AbYAUKqT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 05:46:19 -0500
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:55042 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758472AbYAUKqS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 05:46:18 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0LAP2da002359;
	Mon, 21 Jan 2008 11:25:07 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.65] (pc1065.et.put.poznan.pl [150.254.11.65])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0LALZD22346;
	Mon, 21 Jan 2008 11:21:36 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <20080120225313.GA14762@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.9.11357
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_800_899 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71258>

* Jeff King [20 I 2008 23:53]:
> On Sun, Jan 20, 2008 at 11:35:14PM +0100, Adam Piatyszek wrote:
> 
>> I support this idea. "git-format-patch --attach" is a good place to  
>> implement such an additional encoding. Of course, git-mailinfo needs to  
>> be extended with a decoding method as well.
> 
> I think mailinfo already does support qp, but I haven't tested it (see
> builtin-mailinfo.c:decode_q_segment).

You are right. I've just tested it and it works fine when 
"Content-Transfer-Encoding: quoted-printable" is declared in the header 
part of the email. So only the git-format-patch needs some extension for 
optional QP encoding.

BR,
/Adam


-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
