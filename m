From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-import-tarball
Date: Mon, 30 Aug 2010 08:49:22 -0500
Message-ID: <20100830134922.GB2315@burratino>
References: <20100830063421.GA797@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 15:57:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4rW-0004TC-P3
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab0H3NvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 09:51:13 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63005 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab0H3NvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 09:51:12 -0400
Received: by qyk33 with SMTP id 33so5150188qyk.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PsvIT2ZvHUa29N5vUWmHVl3sBwitjDuAW6iVqt0i4Mc=;
        b=PjOuamzSadSvl73u/61SaNnlnA3o03pwe966dTrgkcXfvCdSYBKQBZ4NdsI8NvnPIE
         V1SbNeWEmSBBiz5A5EJ8pucmOu532oc7yIZBJ4/ck+hL/pqm088MIrEts0mhd2AZCMPP
         3lov8cG2OnMroddlDl5NYug11O5twmUoMhBOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oxO4ZBg6fR9hKYI/4xF6uE3qQlN0DGb++eKxQ1wt7AySI8iQBOyjG4rxx1ePX8rZGF
         JceFm4TM9qbchNWerDdya5sJ0z+Uy5/Ta3Pn1K1A4i90p/e/RJoRFGFZAAMmXPetaxOE
         AZrw4iIoiVobJU/OGSC4dTXtRPrRlJzq40SZ0=
Received: by 10.224.10.204 with SMTP id q12mr2874030qaq.192.1283176270678;
        Mon, 30 Aug 2010 06:51:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm8334023qcq.10.2010.08.30.06.51.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 06:51:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100830063421.GA797@nibiru.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154802>

Hi Enrico,

Enrico Weigelt wrote:

> written a little shellscript which imports an existing
> tarball as new commit into a git repo.

You might also like contrib/fast-import/import-tars.perl. :)

Cheers,
Jonathan
