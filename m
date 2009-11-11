From: David Aguilar <davvid@gmail.com>
Subject: Re: Move repository from OS X to Windows
Date: Wed, 11 Nov 2009 09:08:35 -0800
Message-ID: <20091111170833.GB45475@gmail.com>
References: <4AFABCF8.9060601@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 18:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Ggs-0001V8-Un
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 18:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992AbZKKRId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 12:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757987AbZKKRId
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 12:08:33 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:62242 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757943AbZKKRIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 12:08:32 -0500
Received: by pzk26 with SMTP id 26so861840pzk.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wxUXmiAMMy/fBOLVcKwl7lLh2LrQk7gWJBj+agsezrw=;
        b=Z4ORRukt6tNakdMucnPNkpUFAuKKdegc6vWvnEJWuZXMRUZvoRK280l140nneLYBpa
         BPHhb/RutO+yms4m8xmOACjUq5WQgnxHRhhh+uBjb+R7uHdhWcy/IWawSKRoZI+H+Z7C
         NEvbIelfZv/wYwVFHDmse+WbBv9sguXl/swG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fjZwRQnLh8BXCm7I/eVyD2srUxhDgbpQmcTH+eU3l76Hd3HPcaRZU/OsRVrlQoErEq
         rNjHHlCdTCHPKsvgJl3BbW3+yo9D0O7+oabHO/Gy2lBHSrPCEd4u76AhuECa1Cq8keuk
         UXsbVPZzxCQLLC5ZdMUdSXRhZ86h9VhcmV3m8=
Received: by 10.114.33.30 with SMTP id g30mr2434368wag.214.1257959318184;
        Wed, 11 Nov 2009 09:08:38 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 23sm1114639pzk.0.2009.11.11.09.08.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 09:08:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AFABCF8.9060601@syntevo.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132676>

On Wed, Nov 11, 2009 at 02:32:40PM +0100, Thomas Singer wrote:
> Hi,
> 
> I've cloned a very large repository on OS X and want to move that to Windows
> (trying to avoid to clone the repository a second time). What steps should I
> do to make it working (currently, I'm getting an error on pull/merge that
> "Entry 'foo' is not uptodate. Cannot merge.")?


Check the git documentation for "core.filemode" and "core.autocrlf".

My guess is that you need to set core.filemode false.
If it's not that then look into core.autocrlf.


Good luck,

-- 
		David
