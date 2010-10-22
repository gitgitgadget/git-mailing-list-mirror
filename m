From: Kevin Ballard <kevin@sb.org>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Thu, 21 Oct 2010 18:11:34 -0700
Message-ID: <7FC32402-F0D4-4420-B984-ACAB45DBDDB3@sb.org>
References: <4CC05E4B.1010106@xiplink.com> <4CC06439.8040003@xiplink.com> <20101021191045.GC11759@burratino> <20101021210842.6545a661@montecarlo.grandprix.int>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 03:11:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P96AZ-0000cQ-9D
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 03:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab0JVBLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 21:11:38 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40425 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab0JVBLi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 21:11:38 -0400
Received: by pwj3 with SMTP id 3so131296pwj.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 18:11:37 -0700 (PDT)
Received: by 10.143.3.8 with SMTP id f8mr1556830wfi.193.1287709897609;
        Thu, 21 Oct 2010 18:11:37 -0700 (PDT)
Received: from [10.8.8.46] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm3416449wfh.3.2010.10.21.18.11.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 18:11:36 -0700 (PDT)
In-Reply-To: <20101021210842.6545a661@montecarlo.grandprix.int>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159629>

On Oct 21, 2010, at 6:08 PM, Peter van der Does wrote:

> I don't have the knowledge to determine which Bash version is running
> in the git.spec.in file. If you could that would be a way to either
> install the new version or the old one.

Could you instead teach the script how to work on both Bash 3 or Bash 4? If you could extract the references to the completion words into a function, you could define one function for Bash 3 and one for Bash 4, and use ${BASH_VERSINFO[0]} to determine which to use.

-Kevin Ballard