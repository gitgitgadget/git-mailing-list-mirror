From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document escaping of special characters in gitignore files
Date: Wed, 5 Jan 2011 22:02:32 +0100
Message-ID: <201101052202.34043.jnareb@gmail.com>
References: <1294234732-20094-1-git-send-email-jnareb@gmail.com> <4D24D0CB.3030004@gmail.com> <7vk4ijccji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bruce Korb <bruce.korb@gmail.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 22:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaaWi-0000KW-GE
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 22:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab1AEVEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 16:04:06 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42609 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab1AEVEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 16:04:04 -0500
Received: by wyb28 with SMTP id 28so15759061wyb.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 13:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=73C6BGm18SaawobmJtYHLm6tR/wpZaHU5Gx+kgztHI4=;
        b=D2B3N04kY5c+Ha3hl6xvuSuIm1cZ6ew7Qt2gcjp/SHw/ABI9/OUBVm4Dmq8nQZNTNU
         iCuCCwZODgJWUPuCHON/oHR/fboybdX57hkH5mJW38CKPLlBxccAxlrfvlYR4jUa+rKk
         tpGlwVu66UGMmzQk6hnSL4DgkHn5/+olHvN18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Hc23mEQRhWoL4FMt7waLiVBOOILDtDJURLzREI1E7+EjVxVdfYIqIrP/ExyLgXvIAf
         6QCbQZnGU4it+XvKCvJ2s8OzbaXZ8t8BZSMwHPH66J5dTe/TtDxoP3xPd5gqNKUvAgvN
         CiNQTTQmF0iG3jBK84Sy+Jn6w7J8BVhgudaVo=
Received: by 10.227.141.78 with SMTP id l14mr13520172wbu.128.1294261382145;
        Wed, 05 Jan 2011 13:03:02 -0800 (PST)
Received: from [192.168.1.13] (abwm104.neoplus.adsl.tpnet.pl [83.8.236.104])
        by mx.google.com with ESMTPS id 11sm16252942wbj.1.2011.01.05.13.02.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 13:03:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk4ijccji.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164596>

On Wed, 5 Jan 2011, Junio C Hamano wrote:

> Perhaps a single liner comment to describe the three examples immediately
> below "exclude patterns (uncomment them..." is in order in that case,
> something like:
> 
> # exclude patterns (object and library, emacs backup, emacs autosave
> # files) -- uncomment if you want to use them
> # *.[oa]
> # *~

Errr... I think that '*~' pattern is generic UNIX backup, like '*.bak'
is for MS-DOS / MS Windows.

http://en.wikipedia.org/wiki/Tilde#Backup_filenames

  Backup filenames

  The dominant Unix convention for naming backup copies of files is
  appending a tilde to the original file name. It originated with the
  Emacs text editor[citation needed] and was adopted by many other
  editors and some command-line tools.

> # \#*#

Anyway, should I reroll this patch with above addition?  Should I add
an explanation why we can use `\#` but need to use "{tilde}#"? 
-- 
Jakub Narebski
Poland
