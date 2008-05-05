From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] graph API: eliminate unnecessary indentation
Date: Mon, 5 May 2008 19:38:38 +0800
Message-ID: <46dff0320805050438m44c266f4w77e23e823663be6b@mail.gmail.com>
References: <1209897414-10091-4-git-send-email-adam@adamsimpkins.net>
	 <1209974223-2875-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam Simpkins" <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon May 05 13:39:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsz2W-0008VS-I8
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 13:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbYEELik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 07:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbYEELik
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 07:38:40 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:8444 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbYEELij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 07:38:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so533369and.103
        for <git@vger.kernel.org>; Mon, 05 May 2008 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Uvko5SvJCZRdBYUjNJcnWp228B0a8dTJbF+wwb56NWQ=;
        b=ttEIStXvHKDwCFJisMnOIyDk3YkiIKNnW6FvmykhiL+/FZ1yKsIFVjuM9VF/1bHz4ln/jIA3b1vs/LhGJgLCdVHCF4yRHdSLL6fKpS3uWhtlS255CHmlUWErIIyIUINO6OwS4robNA/uvEXu4wouwQuIuW9y8VYlPkUQBbtCjmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FFQ/J9C/XeO5n088Z5+ONJKKINtrN/0EW64yzhSesIfVLLtIJIeoqbH1LfhGHUH7A10p2PeoFz6GJeUDdESBlPbRv0Td7Wop0dT3vIXYFtFR7PdmOY1ZHjuBK4sNbXXDrNHOTdWk9z/Q7T2g0G8Fk5cm3hjeRyp2MvJ+N31HP68=
Received: by 10.100.120.6 with SMTP id s6mr7403827anc.72.1209987518092;
        Mon, 05 May 2008 04:38:38 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 5 May 2008 04:38:38 -0700 (PDT)
In-Reply-To: <1209974223-2875-1-git-send-email-adam@adamsimpkins.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81269>

On Mon, May 5, 2008 at 3:57 PM, Adam Simpkins <adam@adamsimpkins.net> wrote:
> This change improves the calculation of the amount of horizontal
>  padding, so that there is always exactly 1 space of padding.
>  Previously, most commits had 3 spaces of padding, but commits that
>  didn't have any children in the graph had only 1 space of padding.
>
>  Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
>  ---
>
>  This fixes the issue reported by Ping Yin.
>

Yes, this patch has fix that problem. THX.

-- 
Ping Yin
