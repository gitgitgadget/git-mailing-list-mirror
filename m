From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] send-email: Clear To: field for every mail
Date: Mon, 4 Oct 2010 13:19:56 +0530
Message-ID: <4CA98724.2020203@st.com>
References: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com> <7v7hhya0yc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	"bebarino@gmail.com" <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:50:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2foU-0000gA-77
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab0JDHuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:50:15 -0400
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:58349 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753136Ab0JDHuO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 03:50:14 -0400
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob120.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTKmHKuD7JrzMOCobUtc07H0ShUznd0cg@postini.com; Mon, 04 Oct 2010 07:50:13 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 79D90105;
	Mon,  4 Oct 2010 07:49:58 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 63DE964D;
	Mon,  4 Oct 2010 07:49:58 +0000 (GMT)
Received: from [10.199.16.92] (10.199.16.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 4 Oct 2010
 15:49:58 +0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <7v7hhya0yc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158001>

On 10/04/2010 12:39 PM, Junio C Hamano wrote:
> Heh, are people who send patches with only S-o-b by your definition not
> testing their patches at all ;-)?  As far as I can tell, your patch
> applied to 'next' will break t9001 rather badly.
> 
> I agree there is a bug that you are trying to address in the series by
> Stephen that keeps adding To: address that is read from an earlier output
> of format-patch created with its --to option, but I do not think this is a
> right fix.  Have you tested sending a series with a plain format-patch
> output without extraneous To:, Cc: and such headers?
> 
> A normal send-email session takes the recipient address from either --to
> or interactively upfront, and then use those addresses kept in @to
> variable in the loop, repeatedly.  I do not see anything in your patch to
> avoid losing these addresses.

Junio, Stephan,

Ya! my patch wasn't good enough. I just tried to solve it the way it was done
for cc.

-- 
viresh
