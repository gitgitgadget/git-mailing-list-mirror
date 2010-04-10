From: Eric Raymond <esr@thyrsus.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 15:30:39 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100410193039.GA28768@thyrsus.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
 <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Simon <turner25@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:30:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0gOD-0005js-Om
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab0DJTak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:30:40 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:48081
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab0DJTak (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 15:30:40 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 8438D20CBBC; Sat, 10 Apr 2010 15:30:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144581>

Simon <turner25@gmail.com>:
> Why not use an XML output?
> Plain text is easier to parse, but XML may give this extra durability
> you are looking for?

Because XML is awfully heavyewight, and XML parsers tend to be slow.

If we were going to buld on a metaprotocol, JSON would be better.  IMHO.  
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
