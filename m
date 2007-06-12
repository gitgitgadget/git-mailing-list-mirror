From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Tue, 12 Jun 2007 08:16:01 +0200
Message-ID: <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <20070611064203.GG6073@spearce.org>
	 <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	 <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 08:16:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxzfj-0005jj-SV
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 08:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbXFLGQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 02:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbXFLGQE
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 02:16:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:53202 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791AbXFLGQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 02:16:02 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1536000nzf
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 23:16:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z3dO+mrtalLr9l2J9zWgip7yxNnhd3xAhwv2XtCo4zQY2ygo2Hv8gEkJjYn8NVkajyioOZifeR4cvwxhOo0ftNV/c7xKvJymSk3iohYth8KyuV0EtZ1WhEpEJjwMAWCz4aYGbuuMthP2eBXAT43hDnrmDmdB34Ej1iNkHC8qg00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EUOpenwpE20FpkLsSOV7QQIUExB1kHTrF1RhV2EoYYLLbSa32RoWUWlood8pl7wRz0p1ntM1kIe2ASEjnBjERkj4iPMwONlwdDbgLAFeH4bwmNt5siwoJkVHVJfA7pfqdUETJ5ZpeCXslXtN7m3zRx9HqG//hDxnd4ViSoR/8+M=
Received: by 10.114.14.1 with SMTP id 1mr6292676wan.1181628961663;
        Mon, 11 Jun 2007 23:16:01 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Mon, 11 Jun 2007 23:16:01 -0700 (PDT)
In-Reply-To: <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49924>

On 6/11/07, Junio C Hamano <gitster@pobox.com> wrote:
>
> An option to re-blame starting from the parent commit of what is
> currently blamed (i.e. "peel" one level) would certainly be
> interesting but I do not think git-gui has it (yet).

Not to advertise, but qgit has already that from ages.

Annotate algorithm of qgit is little different in that it starts from
the oldest revision that modified a file and goes to the latest. In
this way we can have the whole file history annotated in one pass and
very fast.

Currently the slowest steps are, from fastest to slowest:

1 - annotating the files
2 - getting the file history
3 - getting the corrisponding patches (in case of long histories)


Thanks for your patience.
Marco
