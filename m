From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: use case: keep the output of a markup (TeX) file under revision
 control
Date: Thu, 17 Feb 2011 13:27:01 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4D5D1415.7080405@atlas-elektronik.com>
References: <1297939020.3959.12.camel@mattotaupa> <m362si97n4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:27:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2wt-0001kt-0D
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab1BQM1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:27:01 -0500
Received: from mail96.atlas.de ([194.156.172.86]:46369 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352Ab1BQM1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 07:27:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 7169D10078;
	Thu, 17 Feb 2011 13:26:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id b0XBwhPuFWQL; Thu, 17 Feb 2011 13:26:57 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 17 Feb 2011 13:26:57 +0100 (CET)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 18D1A2716A;
	Thu, 17 Feb 2011 13:26:57 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <m362si97n4.fsf@localhost.localdomain>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167076>

On 2/17/2011 1:19 PM, Jakub Narebski wrote:
> Paul Menzel <paulepanter@users.sourceforge.net> writes:
> 
> 1. Mark PDF files as binary, if they are not already considered binary.
> 
> 2. Create custom merge driver for PDF files, which would compile
>    source *.tex file to PDF, provided that TeX is installed, and that
>    source file itself is not in merge conflict
> 
> 3. Creating pre-commit hook would ensure that you have refershed PDF
>    files during ordinary commit.  Note that this hook is not always ran
>    (you can force running it with --verify option to git-commit).

??

I only see '--no-verify' in 'git help commit' to bybass the 
'pre-commit' hook but not the other way round.

Puzzled,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: Beam me up Scotty. This isn't the men's room.
