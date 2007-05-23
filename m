From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: just fetching HEAD of repository
Date: Wed, 23 May 2007 19:12:27 +0200
Message-ID: <8b65902a0705231012p7b711094qc855a2805f2fd255@mail.gmail.com>
References: <566574ef0705210201wc5c0adbmaa22d197b16bf72d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stian Haklev" <shaklev@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 19:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HquOe-0003xz-KM
	for gcvg-git@gmane.org; Wed, 23 May 2007 19:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935717AbXEWRMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935714AbXEWRMb
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 13:12:31 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:20676 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935354AbXEWRMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 13:12:30 -0400
Received: by an-out-0708.google.com with SMTP id d31so71321and
        for <git@vger.kernel.org>; Wed, 23 May 2007 10:12:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XvuJaDOT6VDPXbgfW11Fv3d49t9J1S7CjP2FBKGFP+dRoz0D3rOtBOoLgCStBu08tRmtCV2TVZOLUf2J3ssyXbi8PdM9r1v/yGQgmSfzvmI6QK/azjH7AE4Ay+0AEazPdZ0reXcv0Rvwg7CI7vyHRW7tYbxcHtnHpvnj8jtLfoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dym2QbB/R/1Y1yOypFBZA32ujwbvHZjYncnAUvNbi3oyIfCrWKNTxLOLVvlgT85DYlqkYi/NIkFn1X8RI9c80d+W38jBrB1PxU0ckyAigJ0B9dnqu4+Z5c2yBy7ukc6+fgxu4Adpic3PlWEJyPga0KSJuTb3GCDXVydZWuZQwck=
Received: by 10.100.153.17 with SMTP id a17mr702664ane.1179940347576;
        Wed, 23 May 2007 10:12:27 -0700 (PDT)
Received: by 10.100.46.11 with HTTP; Wed, 23 May 2007 10:12:27 -0700 (PDT)
In-Reply-To: <566574ef0705210201wc5c0adbmaa22d197b16bf72d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48165>

Are you looking for something to "shallow clone" the remote git repo
(as replyed by Matthieu, or something more similar to the "cvs export"
or "svn export" commands (ie exporting a current snapshot, not a
working repo)?

On 5/21/07, Stian Haklev <shaklev@gmail.com> wrote:
> After checking all the docs, I am still wondering if there is a way to
> get only the last commit from a given git repository. Sometimes I
> really just want the latest code so I can compile it - and let's say
> they are not running gitweb, or it is not convenient to go to gitweb
> and ask for a tar package to be made? This is especially relevant in
> countries with slow internet connection - here in Indonesia it takes
> me an hour to clone the git repository for example, never mind let's
> say the Linux kernel.
>
> Thank you
> Stian
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
