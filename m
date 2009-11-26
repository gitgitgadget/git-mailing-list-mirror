From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Octopus merge
Date: Thu, 26 Nov 2009 17:44:52 +0100
Message-ID: <200911261744.56913.trast@student.ethz.ch>
References: <4B0EA512.1050001@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <Claudia.Ignat@loria.fr>
X-From: git-owner@vger.kernel.org Thu Nov 26 17:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDhTF-00034A-5Y
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 17:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759165AbZKZQpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 11:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758701AbZKZQpP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 11:45:15 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:44719 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbZKZQpO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 11:45:14 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 26 Nov
 2009 17:45:19 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 26 Nov
 2009 17:44:58 +0100
User-Agent: KMail/1.12.90 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.75; x86_64; ; )
In-Reply-To: <4B0EA512.1050001@loria.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133810>

Claudia.Ignat@loria.fr wrote:
> 
> While I am in the current workspace ws3 I perform the merge
> 
> git merge ws4 ws2 ws5
> 
> Obviously I obtain conflicts between changes in ws3 and ws2 which I fix 
> manually and afterwards I commit the new version of ws3.

In doing that last step, you ignored the crucial bit of advice printed
by the octopus merge:

  Automated merge did not work.
  Should not be doing an Octopus.		# <<--
  Merge with strategy octopus failed.

You should simply merge and resolve them separately, not least of all
because in doing so, 'git show $merge' will display your merge
resolutions.  An octopus would tangle all resolutions into a single
commit.

AFAIK the only thing that can be considered a bug here is that the
octopus strategy leaves your worktree in need of 'reset --hard'.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
