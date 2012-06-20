From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 04/11] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 16:12:25 -0500
Message-ID: <20120620211225.GD6142@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183133.GD30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:18:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShSHn-0008Dt-59
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 23:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085Ab2FTVRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 17:17:32 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36290 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab2FTVRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 17:17:31 -0400
Received: by ghrr11 with SMTP id r11so6087066ghr.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Eg9UWMIq49AM7gN0oetpb+h3/NHpHOP720qf24MyGmo=;
        b=igK0O4NfjO3ZXlJCTQbl8mSHaxNTfqg8ZLn/FVr8KamoSulfQs2AFHgYX8TBR7L4wv
         EBrxWojorRmOeKMmwmZrFNRtY/n6NoT6W6Ad45DROD5fOOaLcREQFb66/IwcsxU2I4Uj
         gTLem9neWJSAcTyJjTfV6849UEryCY/s7pcmzEydYovatgMRLlHgqr4RECcgxyMDrlvf
         AcgUuzdKdxb2L62y1bpAACPDkNAjoiUvEZSWI6fxNMQq37MgDfqa7Nrc/WgDMw25abG/
         KUJe6LA4A6LlOxn8WRhZCus4qX8GUbFcTs8+ESpDq9kxaEOUWwxyhUyV0lNEriXdrU4m
         9PEQ==
Received: by 10.236.165.102 with SMTP id d66mr1323941yhl.54.1340226750710;
        Wed, 20 Jun 2012 14:12:30 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id a64sm98895194yhe.11.2012.06.20.14.12.29
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 14:12:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620183133.GD30995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200364>

Jeff King wrote:

>                                                      These
> flags may sometimes require extra dependencies to be added
> (e.g., like GIT-VERSION-FILE; this is not the case for any
> of the updated lines in this patch, but it is establishing a
> style that will be used in later patches).
[...] 
> This patch explicitly does not update the static header
> dependencies used when COMPUTED_HEADER_DEPENDENCIES is off.

I think you are asking the commit message to do more work than it
needs to, and to answer questions that no one just trying to
understand the patch would ask. :)

Wouldn't it be simpler to put the ground rules in a comment or a
document somewhere under Documentation/ where they can be easily
found?

Hope that helps,
Jonathan
