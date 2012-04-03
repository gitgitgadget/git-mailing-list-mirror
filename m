From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: Re: query: picking dependant commits from a latest tree
Date: Tue, 3 Apr 2012 09:30:01 +0530
Message-ID: <20120403040001.GQ1766@localhost.localdomain>
References: <20120327095504.GM1806@localhost.localdomain>
 <4F75DF56.10902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 06:01:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEuvo-0003z8-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 06:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821Ab2DCEBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 00:01:16 -0400
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:38632 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750722Ab2DCEBQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 00:01:16 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob111.postini.com ([207.126.147.11]) with SMTP
	ID DSNKT3p2CNxKVW4sVG/m35wcsyByZ8E/uS9k@postini.com; Tue, 03 Apr 2012 04:01:15 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8B6B8CD;
	Tue,  3 Apr 2012 03:52:46 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas1.st.com [10.80.176.8])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 42C1679D;
	Tue,  3 Apr 2012 04:01:09 +0000 (GMT)
Received: from localhost (10.199.82.228) by Webmail-ap.st.com (10.80.176.7)
 with Microsoft SMTP Server (TLS) id 8.3.192.1; Tue, 3 Apr 2012 12:00:02 +0800
Content-Disposition: inline
In-Reply-To: <4F75DF56.10902@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194591>

Hi Neal,

On Sat, Mar 31, 2012 at 12:29:10AM +0800, Neal Kreitzinger wrote:
> On 3/27/2012 4:55 AM, Shiraz Hashim wrote:
> >
> > If I try to pick commits from a latest tree for a particular feature
> > then what is the best way to find out all dependant commits.
> >
> > So for example for the commit which I want to pick there are 10 other
> > commits around that file but some affect other files which themselves
> > have several commits which I must apply.
> >
> > Is their a way to do this efficiently ?
> >
> You're assuming all dependencies reside in the same commits or in common 
> files.  If the changes in a commit are dependent on the previous commit 
> and they do not share any of the same files then what you are proposing 
> is not going to catch that.

You are right, but this would perhaps be caught during tests. But in
the first place how can I find dependent commits to pass build test.

--
regards
Shiraz
