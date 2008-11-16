From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Sun, 16 Nov 2008 16:30:33 +0100
Message-ID: <cb7bb73a0811160730g31eaf673n528359b8c799b2ef@mail.gmail.com>
References: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 16:31:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1jbL-0001FT-1H
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 16:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbYKPPaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 10:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYKPPaf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 10:30:35 -0500
Received: from qb-out-0506.google.com ([72.14.204.237]:1793 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbYKPPae (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 10:30:34 -0500
Received: by qb-out-0506.google.com with SMTP id f11so2064597qba.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JUOvtqZYqi6V6nmUQHMaoR377I0yFsJXT46YPk0AKxQ=;
        b=WDp3X4X1Hw83nEm8f2LI0VhroSkU975RrmAC7FJ+c9HBa6fLGeOcC4Q/3RkcKtDzVJ
         xvaP5w/9irwKBVm61wFmJHwkpDUw3QZCRHjb9Y3TnSKRgEAEUtGAudn+6m3WSrpMPR8E
         h4o6Le+8F5FHJr5MyXZ34GwdbQ+TCUf+EQKLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GOnHqGSIeX5IJB4e9WtdrSSMXa0qg2ZSJP2bCUfIsJN4PfaX3z2XqY+WLGZsiXVlic
         apxWiEJAM1Cy2R9wY4EOozjz9Fu5W/hdosF/YRBtPrZgQbAP/Lp212xg8H7MbSP9ZBLH
         ETtwHYUes9bs/+nq2w5AqG+adpF+diyDEcY9M=
Received: by 10.210.141.4 with SMTP id o4mr3094018ebd.3.1226849433152;
        Sun, 16 Nov 2008 07:30:33 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sun, 16 Nov 2008 07:30:33 -0800 (PST)
In-Reply-To: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101137>

Forgot the sign-off line

On Sat, Nov 15, 2008 at 3:26 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> The gitweb_check_feature routine was being used for two different
> purposes: retrieving the actual feature value (such as the list of
> snapshot formats or the list of additional actions), and to check if a
> feature was enabled.
>
> For the latter use, since all features return an array, it led to either
> clumsy code or subtle bugs, with disabled features appearing enabled
> because (0) evaluates to 1.
>
> We fix these bugs, and simplify the code, by separating feature (list)
> value retrieval (gitweb_get_feature) from boolean feature check (i.e.
> retrieving the first/only item in the feature value list). Usage of
> gitweb_check_feature across gitweb is replaced by the appropriate call
> wherever needed.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

-- 
Giuseppe "Oblomov" Bilotta
