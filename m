From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] Documentation: Add definition of "evil merge" to GIT Glossary
Date: Sat, 26 May 2007 02:34:38 +0200
Message-ID: <200705260234.39095.jnareb@gmail.com>
References: <11801326601014-git-send-email-jnareb@gmail.com> <1180132662719-git-send-email-jnareb@gmail.com> <20070526001423.GF32073@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat May 26 02:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrkAC-0007WP-Uc
	for gcvg-git@gmane.org; Sat, 26 May 2007 02:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbXEZA3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 20:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbXEZA3i
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 20:29:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:45278 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbXEZA3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 20:29:37 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1241432ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 17:29:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Hlxe7KN0Y5T0KlmzpXIJa02FvDmT/G792h4o2glbA6E+6F8TpKyIgyoUiReLgtgOgHKXCCHcZbhh5waZcbRypbIfBHUFnkCJ5CBKVtsNe9m7a+wsVPoo80kHJxqqp9H7NzICx1hkvKQ5XrlStP798D7A3/AwwC31NzRqYGwwZTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TW5uzYw0QrCjDnuyTEPPMuH1fOeoavRrrfhjEgRhKoX88O8x586cNKkibwSMUA1f7oK28YVkmopXoI7TLJcpk55m+VWBDC6JwNnEIzvsvmwYeSBPjSDGru1/YvfaoErXu7NLoZwNTFPNFG4n8sxYAhzGb2MJjDFiWYW5KVF0ZP4=
Received: by 10.66.254.2 with SMTP id b2mr3310962ugi.1180139375515;
        Fri, 25 May 2007 17:29:35 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e8sm16006838muf.2007.05.25.17.29.34;
        Fri, 25 May 2007 17:29:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070526001423.GF32073@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48435>

J. Bruce Fields wrote:
> On Sat, May 26, 2007 at 12:37:39AM +0200, Jakub Narebski wrote:

>> +[[def_evil_merge]]evil merge::
>> +	An evil merge is a <<def_merge,merge>> that introduces changes that
>> +	do not appear in any <<def_parent,parent>>.
>> +
> 
> I'm a little skeptical.  This term doesn't appear to be used anywhere in
> the current documentation, for example--are you sure it's worth
> including at this point?  I don't know--I just don't want to end up with
> an entry for every piece of cute jargon that's been used as shorthand on
> the mailing list a few times.  But if you think it's sufficiently useful
> and well-established, then OK.

Currently only t/annotate-tests.sh uses "evil merge" term, but it is
I think quite commonly used in discussion.

Feel free to skip this patch, if you think it is not worth it, Junio.
-- 
Jakub Narebski
Poland
