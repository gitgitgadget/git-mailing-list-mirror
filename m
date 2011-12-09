From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: Query on git commit amend
Date: Fri, 9 Dec 2011 10:19:28 +0530
Message-ID: <4EE19358.8080600@st.com>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com> <7vobvlfowk.fsf@alter.siamese.dyndns.org> <87wra9und4.fsf@gmail.com> <4EDEE988.2070902@st.com> <20111207045325.GA22990@atjola.homenet> <4EDEFD66.4020404@st.com> <7vvcprar3v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Vijay Lakshminarayanan <laksvij@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 05:49:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYsP3-0000Nb-C4
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 05:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab1LIEtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 23:49:40 -0500
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:58568 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751287Ab1LIEtk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 23:49:40 -0500
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob102.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTuGTXr3v2+7WbT0M00M+/ke9LJO58hNO@postini.com; Fri, 09 Dec 2011 04:49:39 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D53EBEC;
	Fri,  9 Dec 2011 04:41:04 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A249BEE5;
	Fri,  9 Dec 2011 04:49:30 +0000 (GMT)
Received: from [10.199.82.50] (10.199.82.50) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.3.192.1; Fri, 9 Dec 2011
 12:49:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <7vvcprar3v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186607>

On 12/8/2011 11:22 PM, Junio C Hamano wrote:
> So by saying "--amend -C HEAD" you are saying "I want to reuse the log
> message of the commit I am amending,... eh, scratch that, I instead want
> to use the log message of the HEAD commit", as if the commit you are
> amending and HEAD are two different things. That is idiotic.
> 
> Of course, if "git commit --amend" honoured "--no-edit", that is even more
> direct, straightforward and intuitive way to say so ;-)

Got your point. That's correct.

-- 
viresh
