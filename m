From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Wed, 06 Jan 2010 15:05:48 +0100
Message-ID: <4B4498BC.5040400@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org> <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org> <4B439A86.3020500@web.de> <7vbph8oxg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 15:07:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSWWL-00083u-IX
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 15:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab0AFOFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 09:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755836Ab0AFOFw
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 09:05:52 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:48005 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab0AFOFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 09:05:51 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 885B314B659F4;
	Wed,  6 Jan 2010 15:05:50 +0100 (CET)
Received: from [80.128.107.143] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NSWWD-0005c6-00; Wed, 06 Jan 2010 15:05:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vbph8oxg0.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19e503Fl6Kr8uCGHG1NfHnF0faj14OhW13t6EGP
	Q4vfP/8j36YkXppFAZNYAWJxCUt/jlJgdANshM1IcXr+Vgl4GU
	xW7Fq1IWtDpVdqdHcVwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136268>

Am 06.01.2010 02:04, schrieb Junio C Hamano:
> After all we _were_ in agreement.  We both think the user should be told
> about untracked files in submodule directory when inspecting the status to
> make a commit in the superproject.

Thanks. So i'll take a closer look at the diff core (but i suspect i'll
need some time until i can come up with some patches because i don't know
this part of git very well).
