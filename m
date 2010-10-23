From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the
 remote(-tracking) branch terms
Date: Sat, 23 Oct 2010 14:08:17 -0500
Message-ID: <20101023190817.GL21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:12:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jVn-0000jX-GQ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758812Ab0JWTML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:12:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32976 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758418Ab0JWTMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:12:08 -0400
Received: by gyg4 with SMTP id 4so1350173gyg.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=R3VZ9fbpiPvIjocfX6lkSctqdU63Zt2mWiV42eN+qOM=;
        b=AnfZlvBhJ23SqTuqLgk9rqNQPPb69w8FC/mpVlyITLXS+DyqiOW5VIsvNJwcHiLz79
         SnoBVijWaLWXU/CTdUlYKAAbFDcft+2JbI9Y+aLLEyalLtjbxkFMV0ipIn2RDxphmmDy
         d7Gil265huh3YbN1mz37c3DzYq9RpKu9l/Xts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Bx8HsuAlZsHyLrprpZTPyDe6vdQBMhbWOaCB+KdAOQUm/96/0IsHlW+c4TXQuQ6Ndy
         +1hT3NLVC/Y/wXkDWRqSpft4JrlD+8R41PFSdpPDBLtKVqg76ZYn3qKUP4GE8EOrRk9o
         gysrz1mp9lvSiE51xnmxFk+1tfmn5lMB3eVqs=
Received: by 10.150.57.5 with SMTP id f5mr4534759yba.411.1287861128026;
        Sat, 23 Oct 2010 12:12:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q36sm4772333ybk.6.2010.10.23.12.12.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 12:12:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159819>

Matthieu Moy wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1716,6 +1721,10 @@ one step:
>  $ git pull origin master
>  -------------------------------------------------
>  
> +This command will fetch the changes from the remote branch to your
> +remote-tracking branch `origin/master`, and merge the result in the
> +current branch.
> +

I wish. :)  Actually this fetched to FETCH_HEAD and left origin/master
alone the last time I checked.
