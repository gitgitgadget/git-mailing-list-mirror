From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Query on git commit amend
Date: Tue, 06 Dec 2011 10:11:20 +0100
Message-ID: <4EDDDC38.8080108@viscovery.net>
References: <4EDDD0E4.6040003@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Viresh Kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 10:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXr3k-00015e-7m
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 10:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747Ab1LFJL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 04:11:27 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5317 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750966Ab1LFJLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 04:11:25 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RXr3Z-000359-8X; Tue, 06 Dec 2011 10:11:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 00C121660F;
	Tue,  6 Dec 2011 10:11:20 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EDDD0E4.6040003@st.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186338>

Am 12/6/2011 9:23, schrieb Viresh Kumar:
> 
> Hello,
> 
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
> which simply adds new changes to existing commit, without asking to change
> message.

$ git commit --amend -a -C HEAD

But let's count keystrokes (after -a):

<BLANK>-<SHIFT>C<BLANK>HEAD<ENTER>
10 keystrokes (more if you release SHIFT before D)

But if vi pops up you have:

<ENTER><SHIFT>ZZ
4 keystrokes

Where is the advantage of the option?

-- Hannes
