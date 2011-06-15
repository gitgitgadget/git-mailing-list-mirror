From: Andreas Ericsson <ae@op5.se>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 14:41:58 +0200
Message-ID: <4DF8A896.7080708@op5.se>
References: <4DF87B42.1020004@st.com> <m3ei2vv0nw.fsf@localhost.localdomain> <4DF891CC.1040700@st.com> <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com> <4DF89F56.3060200@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "kusmabite@gmail.com" <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 14:42:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWpQD-00033o-IJ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 14:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab1FOMmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 08:42:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61220 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab1FOMmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 08:42:03 -0400
Received: by fxm17 with SMTP id 17so361600fxm.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 05:42:00 -0700 (PDT)
Received: by 10.223.30.82 with SMTP id t18mr543302fac.106.1308141720591;
        Wed, 15 Jun 2011 05:42:00 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id e15sm198619faa.47.2011.06.15.05.41.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 05:42:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <4DF89F56.3060200@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175828>

On 06/15/2011 02:02 PM, viresh kumar wrote:
> 
> I got rid of them with core.filemode as false, but there is one more issue, as pointed out by
> Andreas. There are few files in kernel with same file name but in different _cases_ (one in caps
> and another in small.) and so i am getting issues with these now.
> 
> And don't have any idea how to get rid of that?

You can't. git dubs such filesystems as "retarded" and simply can't
work around it. Imo, that's the only sensible thing to do.

> And why does kernel have such file names at all?
> 

Because linux kernel developers are expected to work with linux
development work using linux and nowhere near enough find it an
actual problem for anyone to care about fixing it. Note that all
build-scripts and configuration stuff will have to be fixed as
well. Complaining about it on lkml will probably have very little
effect unless you're a very valuable contributor and/or lots of
other people chime in to agree with you.

If I may ask; Why do you need to be able to work with a linux kernel
repository on windows?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
