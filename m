From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH 2/3] Documentation: gitrevisions
Date: Wed, 14 Jul 2010 09:49:44 -0700
Message-ID: <4C3DEAA8.3090509@gmail.com>
References: <cover.1278346173.git.git@drmicha.warpmail.net> <7efed85cefddff1cd2cc3a0e3802326306117f4e.1278346173.git.git@drmicha.warpmail.net> <4C3D562B.3070404@gmail.com> <4C3D785D.1050000@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 14 18:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ59n-0000K0-Cr
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 18:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab0GNQt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 12:49:57 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63547 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab0GNQt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 12:49:56 -0400
Received: by pxi14 with SMTP id 14so45428pxi.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8tgLKisX3+WVPYaP3ia+MkKmrrqrDPc8vSZv004OBdU=;
        b=asavXvhJwCRpX5TRuTiYoPF/5Av7CVSNp4tVMqgdroSCBR1CGJ1H7YxZ1YeMPcZ3n8
         vxOhyKKLqeZIaR+/bpwy1oTT1NLXThfokKBTXhW5hI5gx8dOvArRyfxXZ9A2wkmVK84b
         XVv/PWLcttCqdyAudBLxabShTdl25v8Di3o2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Fx0wbIX1bM03v7tBGhDaI1jyyxtFu2uuJaUkjOpiR2nO3SNuE+QWM/s9WHlOevpN2m
         BQJOpgSolFHkM31DIO1HsIgBtqpcAsnOrvIWGvVwgJbvYhTnU/Oa+eZZDxnNkG2AVcNs
         Dq28GmcgmIVIMhMsRmnOiQ4w06DlgCjpRzlBA=
Received: by 10.142.144.2 with SMTP id r2mr6046312wfd.183.1279126195654;
        Wed, 14 Jul 2010 09:49:55 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id 23sm31735wfa.22.2010.07.14.09.49.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 09:49:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100713 Thunderbird/3.1
In-Reply-To: <4C3D785D.1050000@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151010>

  On 07/14/2010 01:42 AM, Michael J Gruber wrote:
>
> I added this text on purpose. The "DESCRIPTION" section is meant to give
> a concise description of the overall picture so that, e.g., you
> understand which section will answer which question without having to
> read all of them. In this case it gives you a short overview of what can
> be referred to by revisions (commit, commit range, general object)
> before the sections go into the details of how to specify them.
>
> Also, as I mentioned in the cover letter, I suggest a rework of the
> actual (included, old) content if that structure is to stay. So, in a
> second step, one could avoid duplications.

Ok, I must have missed that in the cover letter. I hope in the next version we can rework the old content and integrate it into the two paragraphs in this patch. I don't see how keeping the DESCRIPTION section this verbose is helpful. At most it should say:

Many Git commands take revisions as parameters. A revision typically specifies a commit, but it can also specify a blob, a tree, or a set of commits. A set of commits is commonly referred to as a revision range. (or just range?)

And then I wonder if that should just go in the SYNOPSIS section and the DESCRIPTION should be deleted.
