From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and remote branches
Date: Fri, 31 Aug 2007 01:53:28 +0200
Message-ID: <200708310153.29625.jnareb@gmail.com>
References: <favitd$3ff$1@sea.gmane.org> <7vbqco91fi.fsf@gitster.siamese.dyndns.org> <cb7bb73a0708301609s330f8d6fna3755bff346452ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 01:53:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQtpU-0005Jt-Bn
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 01:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762864AbXH3Xxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 19:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762586AbXH3Xxh
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 19:53:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:51202 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761369AbXH3Xxg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 19:53:36 -0400
Received: by nf-out-0910.google.com with SMTP id f5so588796nfh
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 16:53:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tamidOJdx9YVoLpA0kmPzhCqVqpRQydOH5CxYf7NUe1/khOXPrGlShr8d+iiKoHPqec6Gge/smECiyD3SHjoVZ76Mv7TJnXlvsmKbM8GKg4pzu+MurkatqAqzMPbn/SybYSUPVGNVjeSaXOvgIRP0pZwor5g+CrJSRm3+LISWYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pwSODj+/tRIQ+CYLS2BfRtsnkTnozkFJc/+VFSFVub2EBzIqmTclBUgdwhKxKyFxq5Bg14w0qZsbjkpLcsu5VfOtIzANEwCRdxfFqOYb8at36duXa3J/zTUayYc/FZd7p1QC6m1cyCKgnAffFTJnDDygGpYaYJD8Wck+c3xr6v4=
Received: by 10.86.93.17 with SMTP id q17mr799388fgb.1188518015167;
        Thu, 30 Aug 2007 16:53:35 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 22sm1953230fkr.2007.08.30.16.53.30
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Aug 2007 16:53:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0708301609s330f8d6fna3755bff346452ab@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57094>

On Fri, 31 August 2007, Giuseppe Bilotta wrote:
> On 8/30/07, Junio C Hamano <gitster@pobox.com> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> That reminds me that gitweb has no support for detached HEAD as of yet,
>>> although I don't think we want to encourage detached HEAD in public
>>> repo.
[...]
>> But obviously people use gitweb/instaweb as a way to view their
>> own live repository, and I think it makes sense to show and
>> support remotes/ in such a case.  It also would make sense to
>> support detached HEAD there as well.
> 
> If I understand correctly, a detached HEAD is simply a checkout in the
> middle of a branch, and thus not named. So what exactly are we looking
> for when we talk about supporting a detached HEAD? Would it be enough
> to display HEAD in the list of heads?

I think we want display HEAD in the list of heads if it is detached,
and also use it as a ref marker, while only marking (with undeline or
bold style) current head as such if HEAD is not detached, i.e. is
symref or symlink.

-- 
Jakub Narebski
Poland
