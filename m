From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 5/5] Use start_comand() in builtin-fetch-pack.c instead
 of explicit fork/exec.
Date: Thu, 04 Oct 2007 11:22:55 +0200
Message-ID: <4704B0EF.3040207@viscovery.net>
References: <200709302340.17644.johannes.sixt@telecom.at>	<1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>	<1191442180-15905-2-git-send-email-johannes.sixt@telecom.at>	<1191442180-15905-3-git-send-email-johannes.sixt@telecom.at>	<1191442180-15905-4-git-send-email-johannes.sixt@telecom.at>	<1191442180-15905-5-git-send-email-johannes.sixt@telecom.at>	<1191442180-15905-6-git-send-email-johannes.sixt@telecom.at> <7v8x6jb6of.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 11:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdMvJ-0003YQ-59
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 11:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759593AbXJDJXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 05:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760423AbXJDJXD
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 05:23:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12112 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760570AbXJDJXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 05:23:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IdMuz-0006Bz-K1; Thu, 04 Oct 2007 11:22:54 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 20A556B7; Thu,  4 Oct 2007 11:22:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v8x6jb6of.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59936>

Junio C Hamano schrieb:
> I think Daniel and Shawn's git-fetch-in-C should graduate
> 'master' before this series.  If you can re-send the series
> rebased on 2b5a06edca8f7237aad6464b349b79772024d2a2 (Restore
> default verbosity for http fetches.), it would be much
> appreciated.

Sure, will do this evening.

-- Hannes
