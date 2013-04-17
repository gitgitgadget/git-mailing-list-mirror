From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 10:49:01 +0200
Message-ID: <20130417084901.GA7632@blizzard>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 10:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USO3G-0004Ju-W6
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 10:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965981Ab3DQItI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 04:49:08 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:3943 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965802Ab3DQItG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 04:49:06 -0400
Received: from localhost (p57B41090.dip.t-dialin.net [87.180.16.144])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 960e6384
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Wed, 17 Apr 2013 10:49:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221523>

On Mon, Apr 15, 2013 at 01:28:53PM -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
> [...]
> --------------------------------------------------
> [New Topics]
> [...]
> * lf/read-blob-data-from-index (2013-04-15) 3 commits
>   (merged to 'next' on 2013-04-15 at 09f92c6)
>  + convert.c: Remove duplicate code
>  + Add size parameter to read_blob_data_from_index_path()
>  + Add public function read_blob_data_from_index_path()
> 
>  Reduce duplicated code between convert.c and attr.c.
> 
>  Will merge to 'master'.

Not sure if you care but the commit messages of these are all wrong now
that you squashed your API fix into the first commit. They all refer to
read_blob_data_from_index_path() instead of read_blob_data_from_index()
and most of the details mentioned in the first commit of this series no
longer apply...

Just saying :)
