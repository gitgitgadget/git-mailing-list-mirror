From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] git-stash: add new 'drop' subcommand
Date: Sat, 5 Jan 2008 13:36:25 +0100
Message-ID: <e5bfff550801050436k61760cv9cf5c04c537907d6@mail.gmail.com>
References: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil>
	 <477EDDD4.5060509@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jan 05 13:37:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB8Gt-0006xu-NM
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 13:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbYAEMg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 07:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbYAEMg3
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 07:36:29 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:37928 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611AbYAEMg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 07:36:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6442724rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5Aj2wN6PfKLRV6ha7WZjtLUnVCnePyIyc80BUXKr9wU=;
        b=IEpCNGrbD5CMlX/wiHQZtiB/cqzExoxCE9zGyRpqImSUCeDwy/amJ8f8nnt1WAfXC+QJpIc79sYiIop8Ylmm/3IKdVdWDP5WLwKXkGtYsQAfQ3vgl16vjry2NbDsJULYLgZDaZcfy8Hgye99cLEuHBSYZWQqicLpY447hfqxZzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pmll9l6f1deytyMo7WeALjeBYLu/kuRYm0+uEPtanp5bVBESOeuekMJ0U+riz5kWTe0omSmRs34gFi9YneRZ2XvPNComG0XTpYwkA1K2yK7Z7ITBPORWzGKAM5VRbBc9rgWOvuImIr1uBmmle0/IEA8O5/9b3vNOBCCQe+WB8h4=
Received: by 10.141.15.19 with SMTP id s19mr9445969rvi.161.1199536585725;
        Sat, 05 Jan 2008 04:36:25 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 5 Jan 2008 04:36:25 -0800 (PST)
In-Reply-To: <477EDDD4.5060509@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69668>

On Jan 5, 2008 2:31 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>
>
> +drop_stash () {
> +       if ! have_stash
> +       then
> +               echo >&2 'No stash entries to drop'
> +               exit 0
> +       fi

Please, or

> +               echo >&2 'No stash entries to drop'
> +               exit 1

or

> +               echo 'No stash entries to drop'
> +               exit 0

I would prefer the latter.

Thanks
Marco
