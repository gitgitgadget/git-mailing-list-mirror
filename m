From: Charles Bailey <charles@hashpling.org>
Subject: Re: What's cooking in git.git (Aug 2014, #02; Fri, 8)
Date: Sat, 9 Aug 2014 21:01:05 +0100
Message-ID: <20140809200105.GA25206@hashpling.org>
References: <xmqq1tsqk4m4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 22:04:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGCs6-0004Kj-Sp
	for gcvg-git-2@plane.gmane.org; Sat, 09 Aug 2014 22:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbaHIUEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2014 16:04:01 -0400
Received: from avasout06.plus.net ([212.159.14.18]:59119 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaHIUEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 16:04:01 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id ck3x1o0042iA9hg01k3y77; Sat, 09 Aug 2014 21:03:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=cqEVkjIi c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=iMhL93IOMpsA:10 a=OlOhyZeGbxUA:10
 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=mEce8GYnVkJUgQF5VN4A:9 a=CjuIK1q_8ugA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1XGCp7-0006bX-OC; Sat, 09 Aug 2014 21:01:05 +0100
Content-Disposition: inline
In-Reply-To: <xmqq1tsqk4m4.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255075>

On Fri, Aug 08, 2014 at 03:18:11PM -0700, Junio C Hamano wrote:
> * cb/mergetool-difftool (2014-07-21) 2 commits
>  - difftool: don't assume that default sh is sane
>  - mergetool: don't require a work tree for --tool-help
> 
>  Update the way the "difftool --help" shows the help message that is
>  shared with the "mergetool" to reduce one shell dependency.
> 
>  Will merge to 'next'.

Can you hold off on merging this? I think I want to have another go at
making this neater.

Specifically, --tool-help doesn't need a working tree but I hadn't
spotted that it still requires a GIT_DIR / --git-dir when it really
shouldn't.
