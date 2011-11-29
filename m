From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git Submodule Problem - Bug?
Date: Tue, 29 Nov 2011 11:25:41 +0100
Message-ID: <201111291125.41943.trast@student.ethz.ch>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com> <201111291024.01230.trast@student.ethz.ch> <20111129101546.GB2829@kolya>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Manuel Koller <koller.manuel@gmail.com>, <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 11:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVKsn-0007PT-Tx
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 11:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab1K2KZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 05:25:44 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:32476 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967Ab1K2KZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 05:25:44 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 Nov
 2011 11:25:41 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 Nov
 2011 11:25:42 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20111129101546.GB2829@kolya>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186051>

Fredrik Gustafsson wrote:
> > [removing a submodule and adding another under the same name
> > confuses git]
> 
> This is something I did not thought about when writing that patch. The
> reason that this fails is that the part when the first submodule is
> removed is no longer complete (as intended). Before this patch
>      git config --remove-section submodule.sub &&
>      git rm .gitmodules &&
>      rm -rf sub &&
> Did remove all the data associated with the submodule. That's no longer
> the case.

So maybe the right questions to ask would be: what's the *official*
way of removing a submodule completely?  Do we support overwriting
submodules in the way Manuel wanted to?  Why not? :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
