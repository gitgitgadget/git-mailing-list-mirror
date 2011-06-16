From: viresh kumar <viresh.kumar@st.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Thu, 16 Jun 2011 14:25:19 +0530
Message-ID: <4DF9C4F7.6020305@st.com>
References: <4DF87B42.1020004@st.com> <m3ei2vv0nw.fsf@localhost.localdomain> <4DF891CC.1040700@st.com> <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com> <4DF89F56.3060200@st.com> <4DF8A896.7080708@op5.se> <4DF97998.7070604@st.com> <4DF9C3BA.8010106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 10:55:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX8Mi-0002O0-Om
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 10:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab1FPIzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 04:55:48 -0400
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:44502 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752459Ab1FPIzr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 04:55:47 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob115.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTfnFAcQKhQg0iSKo+JuS/3PxU/6cIL6t@postini.com; Thu, 16 Jun 2011 08:55:46 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 46F4F147;
	Thu, 16 Jun 2011 08:55:23 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2F196F26;
	Thu, 16 Jun 2011 08:55:23 +0000 (GMT)
Received: from [10.199.16.92] (10.199.16.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 16 Jun 2011
 16:55:22 +0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <4DF9C3BA.8010106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175889>

On 06/16/2011 02:20 PM, Johannes Sixt wrote:
> Am 6/16/2011 5:33, schrieb viresh kumar:
>> > And i wanted just linux source on windows, i will not be creating any patches from
>> > windows. Just needed code for reference.
> If you only want to peek into the files, you don't need the files checked
> out. Just have them in a bare repository and use, e.g.,
> 
>   git show master:mm/vmalloc.c
> 
> You can also use a sparse checkout to omit the questionable files from the
> checkout. See man git-read-tree.

Thanks. I am doing it this way only.

-- 
viresh
