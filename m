From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Splitting a repository but sharing the common parts of the
 object database
Date: Mon, 13 Dec 2010 13:20:53 -0600
Message-ID: <20101213192053.GA30315@burratino>
References: <4D066873.4020208@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:21:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSDxP-0004Yk-IT
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab0LMTVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 14:21:06 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48933 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab0LMTVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 14:21:04 -0500
Received: by vws16 with SMTP id 16so3756372vws.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Jhkp0jaJo1uN9OjFlrRqHybpTZQm/zjs0P0PQIcO3Ak=;
        b=fjnNFmvYsy0Q71NrMloJ4/V9r1484H4NvD2WlSD35ldhOSdzobdcyRSQmxVdbnggje
         ZsppWgzICyILpmsdVCLA456EXIltjAaIr2cBnEpqooz3jP0u4p7eCr2kp5OUjWCg2/V5
         R5nuZgJuXQsmu7ltM3jcuVmGEFKnuzFH6/V0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ucsD+1PGCNLrFu5DL0EP38BELZNy33b8FNN+DBcVhD4hLZXwp9C2UbMICzE5/9Yc2j
         dwAmOCykLEJt2zgI+MFDPFIOF1EI/hIiWqzBR+mv+6IAC0MrfUMfiywNE4c2htu0ngFA
         5nArDbq+fEWag4re04Z8Z0LhLk0zCwQSomEmk=
Received: by 10.220.182.196 with SMTP id cd4mr1168432vcb.223.1292268063245;
        Mon, 13 Dec 2010 11:21:03 -0800 (PST)
Received: from burratino ([69.209.48.248])
        by mx.google.com with ESMTPS id v26sm1459237vcr.37.2010.12.13.11.21.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 11:21:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D066873.4020208@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163583>

Hi Phillip,

Phillip Susi wrote:

> If I run a repack -a, then the new project has everything copied out of
> the archive and into its new main pack, rather than continuing to use
> the archive repository for old history, and just pack everything since
> then.  I guess I am looking for is somewhere between a full repack and
> an incremental; a way to make repack -a discard existing local packs,
> but to respect the alternate packs and omit objects they contain from
> the new local pack.

You might be interested in girocco's fork support.  See
http://repo.or.cz/w/girocco.git/blob/HEAD:/jobd/gc.sh for starters.

(Yes, the short answer is "-l" but showing where I got that answer
from seems a little easier. :))
