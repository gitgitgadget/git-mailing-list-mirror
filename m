From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Splitting Git Repository
Date: Wed, 23 Jun 2010 11:22:35 +0000
Message-ID: <AANLkTilyjiC4IlnlYi1_RG81GadggISB1H1_KRuaRP0x@mail.gmail.com>
References: <AANLkTimlFeeZtpSYHmfyeY8WZXrUzv0gTp-EBysQFXA3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 13:22:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORO2U-00074k-6A
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 13:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab0FWLWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 07:22:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46303 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab0FWLWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 07:22:36 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so611450iwn.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7N9shoJBq9iXZ1/KZXN93MKSiblRVKJAvghGBoj65mQ=;
        b=XmfaMlycvD8Zt9NN6u5TtvKkoWt2qHiPF6jiZ7ltNk79FXCyr20ge62VWnrDQHlHJv
         r0DdnJoIY9PqSqGsERfQyKzt+M3dTsKtJo3GYAUNQ2PmYiYsFn5vIElcuENXdQsfDcLX
         5hCXD8NUMfXOUnvM9zsclm/Voq8n+tCBEkYIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iMH9vtI6sCmBimal9sOqh2JhMm9RfNfaMlAJdM6DBGdGF8p1Y/Jikz2JZuGuPFJ1sa
         RsJLiYS0nRKRfxuoDwsNuwMkQlSrKHdfxeMANAZGZKvycgsKmtsN5uDoI8xmV/agFj8K
         kPZkLr2VTDLifSWcaKvd11xmqlGLm35U31YKg=
Received: by 10.42.8.69 with SMTP id h5mr2859977ich.4.1277292155778; Wed, 23 
	Jun 2010 04:22:35 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 23 Jun 2010 04:22:35 -0700 (PDT)
In-Reply-To: <AANLkTimlFeeZtpSYHmfyeY8WZXrUzv0gTp-EBysQFXA3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149508>

On Wed, Jun 23, 2010 at 11:05, Mahesh Vaidya <forvaidya@gmail.com> wrote:
> With increased adoption of GIT; there could be situations of splitting
> / merging Git Repositories.
>
> If there is a support for splitting git repository and construction 2
> pieces of repository as 2 independent repository with history

Have you read the git-filter-branch(1) manual page?
