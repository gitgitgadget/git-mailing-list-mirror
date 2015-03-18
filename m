From: Kevin D <me@ikke.info>
Subject: Re: Git with Lader logic
Date: Wed, 18 Mar 2015 12:29:36 +0100
Message-ID: <20150318112936.GC11832@vps892.directvps.nl>
References: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Bharat Suvarna <bharat.bs84@icloud.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 12:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYCAd-0003vj-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 12:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599AbbCRL3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 07:29:38 -0400
Received: from ikke.info ([178.21.113.177]:48457 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755449AbbCRL3h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 07:29:37 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 663D91DCF6D; Wed, 18 Mar 2015 12:29:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265719>

On Tue, Mar 17, 2015 at 11:33:54PM +0000, Bharat Suvarna wrote:
> Hi 
> 
> I am trying to find a way of using version control on PLC programmers like Allen Bradley PLC. I can't find a way of this.
> 
> Could you please give me an idea if it will work with Plc programs. Which are basically Ladder logic.
> 

I'm not familiar with these programs, so I can't give you specific
advice about this.

Although git is not very picky about the contents, it is optimized to
track text files. Things like showing diffs and merging files only works
on text files.

Git can track binary files, but there are some disadvantages:

- Diff / merge doesn't work well
- Compression is often difficult, so the repository size may grow
  depending on the size of the things stored

These disadvantages are not limited to only git, other SCM systems also
have to deal with these problems.

So if the Ladder logic is represented as text source, there is no
problem with it. If it'sbinary, there might be other sollutions better
suited.

Kevin
