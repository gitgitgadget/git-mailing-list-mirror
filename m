From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: Query on git commit amend
Date: Tue, 6 Dec 2011 14:52:56 +0530
Message-ID: <4EDDDEF0.6030405@st.com>
References: <4EDDD0E4.6040003@st.com> <4EDDDC38.8080108@viscovery.net> <4EDDDE5C.6040200@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <flatworm@users.sourceforge.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 10:23:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXrFA-0006cs-Jp
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 10:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941Ab1LFJXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 04:23:14 -0500
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:45007 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932901Ab1LFJXN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 04:23:13 -0500
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob103.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTt3e9dvjYO9Tk0RcK4CtS9OmP/VE4+yB@postini.com; Tue, 06 Dec 2011 09:23:12 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4979CCD;
	Tue,  6 Dec 2011 09:14:33 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 29F30BB4;
	Tue,  6 Dec 2011 09:22:59 +0000 (GMT)
Received: from [10.199.82.50] (10.199.82.50) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.3.192.1; Tue, 6 Dec 2011
 17:22:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <4EDDDE5C.6040200@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186340>

On 12/6/2011 2:50 PM, Viresh Kumar wrote:
> On 12/6/2011 2:41 PM, Johannes Sixt wrote:
>> Am 12/6/2011 9:23, schrieb Viresh Kumar:
>> $ git commit --amend -a -C HEAD
>>
>> But let's count keystrokes (after -a):
>>
>> <BLANK>-<SHIFT>C<BLANK>HEAD<ENTER>
>> 10 keystrokes (more if you release SHIFT before D)
>>
>> But if vi pops up you have:
>>
>> <ENTER><SHIFT>ZZ
>> 4 keystrokes
>>
>> Where is the advantage of the option?
>>
> 
> Thanks guys.
> 
> @Johannes: You are right but, i will make an alias for the entire command.
> So keystrokes are same for me. :)
> 

There is one more benefit, we don't have to wait for git. We can simply switch to
some other window and work. And can write further command on the same window, in
the time git processes commit --amend.

-- 
viresh
