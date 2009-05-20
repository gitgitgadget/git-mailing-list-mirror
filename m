From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/3] http*: refactor fetching code (v2)
Date: Wed, 20 May 2009 20:14:59 +0800
Message-ID: <be6fef0d0905200514p55317a80ra765f6027f47c339@mail.gmail.com>
References: <20090518163025.58842505.rctay89@gmail.com>
	 <20090520074352.GC21455@glandium.org>
	 <alpine.DEB.1.00.0905201220270.16461@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 20 14:15:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6khT-0000Ek-Hc
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 14:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbZETMO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 08:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755998AbZETMO6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 08:14:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:50195 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbZETMO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 08:14:58 -0400
Received: by wa-out-1112.google.com with SMTP id j5so89187wah.21
        for <git@vger.kernel.org>; Wed, 20 May 2009 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ulhey7vuD7utAqWq+swWGZhQ99p62VPrWthikA7kEeQ=;
        b=eN03Yjg/fydrJ1WinIDufQDgcynwvQVeeahToCN65OCQuSL05T+kIAR/TV37N7yLme
         Zi/Rqlb+3JSJaaAinFTYTOT3xVfp9m8yhUHoxG7S/nBK+Rs3Jezyp/YwRuGKCNv5qzhY
         5FuAubMVGPw32UaoNDgktjuDuzZ/wZ7+tt/X8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SPQAuaDKu2W5x/8Zorfm8tUAmBd/uhYfjDBx95TOG0rACAE+DMA191H87vV+MZyIlH
         ZrDGqQ/sJGdVbonZfbiVT//QjwMh6omIfIpkqhNwFG5GhxUbLSEtpyzSZd7qbR5imVu2
         ES09lDaLP/ltON05+H05NSu6PWxGLvUPQ4gFk=
Received: by 10.114.255.1 with SMTP id c1mr2559863wai.4.1242821699594; Wed, 20 
	May 2009 05:14:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905201220270.16461@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119606>

Hi,

On Wed, May 20, 2009 at 6:21 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Oops, sorry, I know I promised to work on that, but I simply lack the
> time.

a quick list of tests available for http* (I left out some minor ones):

t5540-http-push:
 *push to remote repository with packed refs
 *push to remote repository with unpacked refs
 *http-push fetches unpacked objects
 *http-push fetches packed objects
 *create and delete remote branch

t5550-http-fetch:
 *fetch changes via http
 *http remote detects correct HEAD
 *fetch packed objects

Mike and Johannes, what else do you have in mind?

-- 
Cheers,
Ray Chuan
