From: vireshk <viresh.kumar@st.com>
Subject: Re: Issue: Mails sent twice if patch is mentioned twice while sending
 mail.
Date: Wed, 17 Aug 2011 14:46:33 +0530
Message-ID: <4E4B86F1.2010802@st.com>
References: <4E4B5B9D.1070901@st.com> <CALkWK0nv=NrCzxfePL50GiJya+DbqdOmSMjPVEa-Sf1Qm5oAvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 11:16:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtcF8-0002EC-Qp
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 11:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab1HQJQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 05:16:53 -0400
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:46315 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751419Ab1HQJQw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 05:16:52 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob115.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTkuHAVSUbvf8r+FCMroM+jozAsDwVg/0@postini.com; Wed, 17 Aug 2011 09:16:52 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B332E153;
	Wed, 17 Aug 2011 09:16:35 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A1D48427;
	Wed, 17 Aug 2011 09:16:35 +0000 (GMT)
Received: from [10.199.82.50] (10.199.82.50) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Aug 2011
 17:16:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <CALkWK0nv=NrCzxfePL50GiJya+DbqdOmSMjPVEa-Sf1Qm5oAvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179506>

On 8/17/2011 2:22 PM, Ramkumar Ramachandra wrote:
> Viresh kumar writes:
>> git send-email --to=abc@xyz.com 0001-xyz.patch 0001-xyz.patch
>>
>> What should be the desired behavior of this command, Should we get
>> mail only once or twice?
> 
> I'd expect it to send out two emails.  Why should 'git send-email'
> check the supplied command-line arguments for duplicates?  I can't
> think of a usecase for it. It's a simple Perl script that mails out
> the mbox files specified on the command-line.  Could you tell us your
> usecase?  If it's a shell script that calls 'git send-email' with
> duplicate arguments, I think you should fix the shell script, not 'git
> send-email'.
> 

Hi Ram,

Actually i did this by mistake once and thought git send-email should
have taken care of this. I may be wrong, but it was just an thought.

--
viresh
