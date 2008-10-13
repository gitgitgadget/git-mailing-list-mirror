From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 0/5] *** SUBJECT HERE ***
Date: Mon, 13 Oct 2008 13:00:33 +0200
Message-ID: <200810131300.35309.jnareb@gmail.com>
References: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 13:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpLBS-0000Dz-Dy
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 13:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150AbYJMLAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 07:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756060AbYJMLAn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 07:00:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:28925 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbYJMLAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 07:00:42 -0400
Received: by ey-out-2122.google.com with SMTP id 6so556071eyi.37
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 04:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1dVhUzOXV60Bte7xNzTj9kzr0qi13+Nf31dxxBM/Sh8=;
        b=q87yUW/uHFpy/6aXo31MZd2aD/N+3oqg8VMFEpa7NQfu/n8ny1cbZYOOF+jcZmB2VC
         p7NCYb5ijTEdQFJyEZtxEeXgBr4qb6yLoPhtaSOs1tiFrBZ2lOtnZhP9pgBKC+5MmCU3
         9noTXQV28MxOAWcRVjq+1gzMILWY5nH5xVvek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bTzhL/jikgO4O/HMav7RRErJU60rDH72bZNVja9YG33EzsRXXXyi5cWQF7Dk1myTPg
         PdHx/SnzvVp+4BBDZE8ynUTSNapij0b8Wjdy5E8e4wExeJwq4GHQYVIVuJsYh4aQkpf3
         HY8vneRHQNw5DHxxjLCAxFqv77P3Z0c8LyJQ0=
Received: by 10.210.21.6 with SMTP id 6mr5314824ebu.99.1223895640210;
        Mon, 13 Oct 2008 04:00:40 -0700 (PDT)
Received: from ?192.168.1.11? (abwv110.neoplus.adsl.tpnet.pl [83.8.245.110])
        by mx.google.com with ESMTPS id 20sm9700068eyk.4.2008.10.13.04.00.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 04:00:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98109>

Err... "*** SUBJECT HERE ***"? Not that it matters...

On Mon, 13 Oct 2008, Giuseppe Bilotta wrote:

> Fifth attempt for my gitweb PATH_INFO patchset, whose purpose is to
> reduce the use of CGI parameters by embedding as many parameters as
> possible in the URL path itself, provided the pathinfo feature is
> enabled.
[...]

> Giuseppe Bilotta (5):
>   gitweb: parse project/action/hash_base:filename PATH_INFO
>   gitweb: generate project/action/hash URLs
>   gitweb: use_pathinfo filenames start with /
>   gitweb: parse parent..current syntax from PATH_INFO
>   gitweb: generate parent..current URLs

I like it, and with the exception of the last patch (which looks like
it doesn't check if $file_name contains '..', even as it checks if
$file_parent contains '..', and which probably should not esc_url)
it looks OK. from (superficial) browsing through patches.

I'll try to review them soon.
-- 
Jakub Narebski
Poland
