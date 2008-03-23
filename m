From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 23 Mar 2008 13:39:59 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803231334210.11994@cougar>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 13:43:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdPYF-0001Eq-9Z
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 13:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYCWMnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 08:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYCWMnK
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 08:43:10 -0400
Received: from mailer.zib.de ([130.73.108.11]:40781 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbYCWMnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 08:43:09 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2NCd7hv027063;
	Sun, 23 Mar 2008 13:39:07 +0100 (CET)
Received: from cougar (brln-4db97827.pool.einsundeins.de [77.185.120.39])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2NCd622007529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Mar 2008 13:39:06 +0100 (MET)
In-Reply-To: <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77886>

On Sun, 23 Mar 2008, Junio C Hamano wrote:

> * lt/case-insensitive (Sat Mar 22 14:22:44 2008 -0700) 9 commits
>  - Make git-add behave more sensibly in a case-insensitive
>    environment
>  - When adding files to the index, add support for case-independent
>    matches
>  - Make unpack-tree update removed files before any updated files
>  - Make branch merging aware of underlying case-insensitive
>    filsystems
>  - Add 'core.ignorecase' option
>  - Make hash_name_lookup able to do case-independent lookups
>  - Make "index_name_exists()" return the cache_entry it found
>  - Move name hashing functions into a file of its own
>  - Make unpack_trees_options bit flags actual bitfields
> 
> The beginning of ASCII-only case insensitive filesystem support.  It is
> not complete yet, though.  E.g. if you enable core.ignorecase in t0050,
> the merge test fails.

The merge test passes for me (on hfs+).  The "git mv" test still fails;
Linus made clear that "git mv" is not yet fixed.

            Steffen
