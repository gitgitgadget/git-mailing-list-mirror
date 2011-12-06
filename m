From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Query on git commit amend
Date: Tue, 6 Dec 2011 13:01:38 +0400
Message-ID: <20111206130138.119db519.kostix@domain007.com>
References: <4EDDD0E4.6040003@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Viresh Kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 10:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXquQ-0005UR-7q
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 10:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629Ab1LFJBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 04:01:49 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:53647 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1LFJBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 04:01:49 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id pB691cVS006036;
	Tue, 6 Dec 2011 13:01:41 +0400
In-Reply-To: <4EDDD0E4.6040003@st.com>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186337>

On Tue, 6 Dec 2011 13:53:00 +0530
Viresh Kumar <viresh.kumar@st.com> wrote:

> Suppose i want to add few new changes to my last commit (HEAD).
> The way i do it is
> $ git add all_changed_files
> $ git commit --amend
> 
> OR
> $ git commit --amend -a
> 
> With both these ways, i get a screen to edit the message too.
> 
> I want to know if there is a way to skip this screen.
> 
> i.e.
> $ git commit --amend -a -some_other_option
> 
> which simply adds new changes to existing commit, without asking to
> change message.
> 
> If there is no such way, then can we add a patch for this, if it
> looks a valid case.
git commit --amend -C HEAD
