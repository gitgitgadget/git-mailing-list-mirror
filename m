From: Eric Raymond <esr@thyrsus.com>
Subject: Re: [RFC/PATCH] status: Add a new NUL separated output format
Date: Sat, 10 Apr 2010 15:50:03 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100410195003.GA28871@thyrsus.com>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
 <20100410040959.GA11977@coredump.intra.peff.net>
 <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
 <20100410192529.23731.79803.julian@quantumfyre.co.uk>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:50:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0gh1-0004P4-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab0DJTuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:50:05 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:58276
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab0DJTuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 15:50:04 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 96F4C20CBBC; Sat, 10 Apr 2010 15:50:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100410192529.23731.79803.julian@quantumfyre.co.uk>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144585>

Julian Phillips <julian@quantumfyre.co.uk>:
> Add a new output format option to git-status that is a more extreme
> form of the -z output that places a NUL between all parts of the
> record, and always has three entries per record, even when only two
> are relevant.  This make the parsing of --porcelain output much
> simpler for the consumer.

If you're open to changing this to lose the exiguous "-> " and use "-"
instead of " " as a status character, that would make me happy 
and fix the rest of the design problems with the format.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
