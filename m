From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH/RFC 0/2] git-gui: issues with merge tool series
Date: Thu, 18 Sep 2008 02:24:03 +0400
Organization: HOME
Message-ID: <200809180224.03833.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com> <bb6f213e0809170550q5be339d1s825f95b1165e6507@mail.gmail.com> <200809172340.16367.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Sep 18 00:27:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg5UK-0006Qi-An
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 00:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718AbYIQWZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 18:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756695AbYIQWZY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 18:25:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:60625 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205AbYIQWZW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 18:25:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3071325fkq.5
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zIDBp9sNBqe9Us53CvsGza7ny09hUzyor8YIn+feBTo=;
        b=a/7rdIpjkLsa+fYT2hWTvv6ePwJvl7lKWbec2hRNJEKWi2KYaWdLfh51iIIGqZObpd
         6e3PSEnxOKmoUgwAD/04ao08hWPeapRCyYes3zIDB7jab8x7gdWXWCGHFAypE3YqpCR5
         KXv147nUzjt1CTUvPPKkSoGOGzAJpvvB5Tn3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uv0h00BzkCdaJJovhSV6wnsEum8cXCwMzQEFNeF2vQS8ZRNJuuU/P28bhWu4y5dpJ/
         uVpn3KnGfJXYNxPBQuI9dkXgmJnrvq2bTannSHWseuJivrF1NdJi77mEOW0VlnMPqG5K
         nK6/AkzL8fF+2GiZexY/G88G3VzWrLqBwcDdo=
Received: by 10.180.224.4 with SMTP id w4mr2355440bkg.51.1221690320088;
        Wed, 17 Sep 2008 15:25:20 -0700 (PDT)
Received: from keydesk.localnet ( [92.255.85.78])
        by mx.google.com with ESMTPS id z15sm17477207fkz.16.2008.09.17.15.25.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 15:25:19 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.0; i686; ; )
In-Reply-To: <200809172340.16367.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96148>

On Thursday 18 September 2008 01:40:16 Johannes Sixt wrote:
> On Mittwoch, 17. September 2008, Alexander Gavrilov wrote:
> >    By the way, is there a simple way to re-create a conflict file from
> > the saved multistage index entries?
> 
> There's 0cf8581e (checkout -m: recreate merge when checking out of unmerged 
> index) in 'next'. But that does not address how the unmerged entries get into 
> the index.

If everything else fails, the entries can be fetched from the index and
cached in RAM by git-gui itself. Then it will be able to put them back
via update-index --index-info.

Alexander
