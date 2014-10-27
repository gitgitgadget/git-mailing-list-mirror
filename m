From: Charles Bailey <charles@hashpling.org>
Subject: Re: git ls-files -o seems to ignore .gitignore
Date: Mon, 27 Oct 2014 06:47:47 +0000
Message-ID: <20141027064747.GA7773@hashpling.org>
References: <544DE351.9060800@netbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard PALO <richard@netbsd.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 07:55:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XieDD-0002kx-Sh
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 07:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbaJ0Gz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 02:55:27 -0400
Received: from avasout05.plus.net ([84.93.230.250]:57689 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaJ0Gz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 02:55:27 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Oct 2014 02:55:26 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id 86no1p0012iA9hg016npkh; Mon, 27 Oct 2014 06:47:50 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=V4jz0IXi c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=X8pPqeFO1vkX7Ef0DB4A:9 a=CjuIK1q_8ugA:10 a=Oz7YPCkRBbQA:10
 a=aBXhzJLfrLYA:10 a=oN8DWymLxccA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.org>)
	id 1Xie5j-00022o-TW; Mon, 27 Oct 2014 06:47:47 +0000
Content-Disposition: inline
In-Reply-To: <544DE351.9060800@netbsd.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 07:16:49AM +0100, Richard PALO wrote:
> Hash: SHA1
> 
> I'm having an issue in that 'git ls-files -o' seems to ignore
> [parts of] .gitignore whereas other commands, such as 'git status'
> seem fine.

This is, as far as I am aware, by design. If you want to apply the
standard ignore rules to the output of ls-files -o then you can use the
--exclude-standard option.
